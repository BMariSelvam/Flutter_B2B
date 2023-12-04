import 'package:b2b/Helper/preferenceHelper.dart';
import 'package:b2b/Model/ProductModel1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/HttpUrl.dart';
import '../../Helper/NetworkClass.dart';
import '../../Model/Categorymodel.dart';
import '../../Model/SubCategoryModel.dart';
import '../../Model/TaxModel.dart';
import '../../Model/login_model1.dart';
import '../../locator/cart_service.dart';
import '../../locator/locator.dart';

class ProductController extends GetxController with StateMixin {
  // RxInt counter = 0.obs;
  RxInt category = 0.obs;
  RxInt subcategory = 0.obs;
  Rx<List<Categorymodel>?> categoryList = (null as List<Categorymodel>?).obs;

  Rx<List<SubCategoryModel>?> subCategoryList =
      (null as List<SubCategoryModel>?).obs;

  RxBool isLoading = false.obs;

  List<TaxModel> taxModel = [];
  double taxPercentage = 0;
  String tax = "";
  String taxName = "";

  // RxInt counter = 0.obs;
  String selectedCategoryId = "";
  int totalPages = 1;
  int currentPage = 1;
  RxList<Product> productList = <Product>[].obs;
  RxList<Product> cartAddedProduct = <Product>[].obs;
  RxInt selectedIndex = 0.obs;
  final CartService cartService = getIt<CartService>();

  @override
  onInit() async {
    getTaxDetails();
    super.onInit();
  }

  Future<void> getCategoryList() async {
    change(null, status: RxStatus.loading());
    await NetworkService.get(url: HttpUrl.getAllCategory, parameters: {})
        .then((response) {
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            List<Categorymodel> list = resJson.map<Categorymodel>((value) {
              return Categorymodel.fromJson(value);
            }).toList();
            list.insert(0, Categorymodel(name: "All"));
            categoryList.value = list;
            change(categoryList.value);
            return;
          }
          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error());
          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: response.apiResponseModel!.message ?? '',
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } else {
        change(null, status: RxStatus.error());
        Get.showSnackbar(
          GetSnackBar(
            title: "Error",
            message: response.apiResponseModel!.message ?? '',
            icon: const Icon(Icons.error),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    });
    // Similar usage for POST, PUT, and DELETE requests
  }

  Future<void> getSubCategoryList({required String categoryId}) async {
    change(null, status: RxStatus.loading());
    await NetworkService.get(url: HttpUrl.getAllSubCategory, parameters: {
      "OrganizationId": "1",
      "CategoryCode": categoryId,
    }).then((response) {
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            List<SubCategoryModel> list =
                resJson.map<SubCategoryModel>((value) {
              return SubCategoryModel.fromJson(value);
            }).toList();
            list.insert(0, SubCategoryModel(name: "All"));
            subCategoryList.value = list;
            change(subCategoryList.value);
            return;
          }
          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error());
          subCategoryList.value = null;
          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: response.apiResponseModel!.message ?? '',
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } else {
        change(null, status: RxStatus.error());
        subCategoryList.value = null;
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      subCategoryList.value = null;
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    });
    // Similar usage for POST, PUT, and DELETE requests
  }

  Future<void> getProductByCategoryId(
      {required String categoryId,
      required String subCategoryId,
      required bool isPagination}) async {
    change(null, status: RxStatus.loadingMore());
    await NetworkService.get(
      url: HttpUrl.getAllProduct,
      parameters: {
        "OrganizationId": "1",
        "Category": categoryId ?? "",
        "SubCategory": subCategoryId ?? "",
        "pageNo": "$currentPage",
        "pageSize": "10"
      },
    ).then((response) {
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.result != null) {
          List? resJson = response.apiResponseModel!.result!;
          if (resJson != null) {
            List<Product> list = resJson.map<Product>((value) {
              return Product.fromJson(value);
            }).toList();
            if (!isPagination) {
              productList.clear();
            }
            productList.addAll(list);
            totalPages = response.apiResponseModel?.totalNumberOfPages ?? 1;
            currentPage++;
            updateProductCount();
            change(productList);
          }
          change(null, status: RxStatus.success());
        } else {
          productList.value = [];
          currentPage = 1;
          change(null, status: RxStatus.error());
          // Get.showSnackbar(
          //   GetSnackBar(
          //     title: "Error",
          //     message: response.apiResponseModel!.message ?? '',
          //     icon: const Icon(Icons.error),
          //     duration: const Duration(seconds: 3),
          //   ),
          // );
        }
      } else {
        productList.value = [];
        currentPage = 1;
        change(null, status: RxStatus.error());
        String? message = response.apiResponseModel?.message;
        PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }

  Future<void> getTaxDetails() async {
    print("taxValu==========");
    isLoading.value = true;
    LoginUser? loginUser = await PreferenceHelper.getUserData();
    change(null, status: RxStatus.loading());
    await NetworkService.get(
      url: HttpUrl.taxGetApi,
      parameters: {
        "OrganizationId": 1,
        "TaxCode": loginUser?.taxTypeId,
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            List<TaxModel> list = resJson.map<TaxModel>((value) {
              return TaxModel.fromJson(value);
            }).toList();
            taxModel = list;

            taxPercentage = taxModel.first.taxPercentage!;
            tax = taxModel.first.taxType!;
            taxName = taxModel.first.taxName!;
            print(
                " 111controller.taxPercentage ============  ${taxPercentage}");
            print("taxValu==========${taxModel.first.taxName}");
            change(taxPercentage);
            change(null, status: RxStatus.success());

            return;
          }
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        change(null, status: RxStatus.error());
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }

  void updateProductCount() {
    for (var product in productList) {
      cartService.cartItems.firstWhereOrNull((element) {
        if (element.productCode == product.productCode) {
          product.boxcountController.text = element.boxcount.toInt().toString();
          product.unitcountController.text =
              element.unitcount.toInt().toString();
          product.WeightcountController.text =
              element.unitcount.toString();
          product.boxcount = element.boxcount;
          product.unitcount = element.unitcount;
          product.weightCount = element.weightCount;
          return true;
        } else {
          return false;
        }
      });
    }
  }
}
