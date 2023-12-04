import 'package:b2b/Helper/HttpUrl.dart';
import 'package:b2b/Helper/NetworkClass.dart';
import 'package:b2b/Helper/preferenceHelper.dart';
import 'package:b2b/Model/TaxModel.dart';
import 'package:b2b/Model/login_model1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:get/get.dart';

import '../../Model/ProductModel1.dart';
import '../../locator/cart_service.dart';
import '../../locator/locator.dart';

class AboutProductController extends GetxController with StateMixin {
  RxBool isAbout = false.obs;
  RxBool isFavorite = false.obs;
  int counter = 0;
  var text = lorem(paragraphs: 1, words: 20);
  PageController imageSwipeController = PageController();
  final loginKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  final CartService cartService = getIt<CartService>();
  RxList<Product> productList = <Product>[].obs;
  List<TaxModel> taxModel = [];
  double taxPercentage = 0;
  String tax = "";
  String taxName = "";
  RxInt selectedIndex = 0.obs;

  @override
  onInit() async {
    getTaxDetails();
    super.onInit();
  }

  Future<void> getTaxDetails() async {
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
              element.weightCount.toStringAsFixed(2);
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
