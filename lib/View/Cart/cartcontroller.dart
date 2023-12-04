import 'dart:async';
import 'package:b2b/Helper/HttpUrl.dart';
import 'package:b2b/Helper/NetworkClass.dart';
import 'package:b2b/Helper/colors.dart';
import 'package:b2b/Helper/fonts.dart';
import 'package:b2b/Helper/preferenceHelper.dart';
import 'package:b2b/Model/ProductModel1.dart';
import 'package:b2b/Model/sales_order/sales_order.dart';
import 'package:b2b/helper/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Model/TaxModel.dart';
import '../../Model/login_model1.dart';
import '../../approute.dart';
import '../../locator/cart_service.dart';
import '../../locator/locator.dart';

class CartController extends GetxController with StateMixin {
  final loginKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  late SalesOrder salesOrder;
  List<TaxModel> taxmodel = [];
  double taxpercentage = 0;
  String tax = "";
  String taxName = "";
  RxInt selectedIndex = 0.obs;
  List<Product> selectedItems = [];

  // RxList<ProductModel1> selectedItems = <ProductModel1>[].obs;

  final CartService cartService = getIt<CartService>();

  salesOrderApi() async {
    isLoading.value = true;
    int index = 1;
    salesOrder.salesOrderDetail?.forEach((element) {
      element.slNo = index;
      index += 1;
      print("||||||||||||||||||||||||||||||||||||||||||");
    });
    NetworkService.post(
            URl: HttpUrl.salesOrderCreate, params: salesOrder.toMap())
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          // Get.toNamed(AppRoutes.successScreen);
          selectedItems.clear();
          sucess(Get.context);
          await PreferenceHelper.removeCartData();
          Timer(const Duration(milliseconds: 1000), () async {
            cartService.clearCart();
            await PreferenceHelper.removeCartData()
                .then((value) => Get.offAllNamed(AppRoutes.bottomNavBar0));
          });
        } else {
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      }
      else {
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }

  Future<void> getTaxDetails() async {
    isLoading.value = true;
    LoginUser? loginUser = await PreferenceHelper.getUserData();
    change(null, status: RxStatus.loading());
    await NetworkService.get(
      url: HttpUrl.taxGetApi,
      parameters: {
        //todo hardcoded for business id
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
            print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
            print(cartService.cartItems.length);
            taxmodel = list;
            taxpercentage = taxmodel.first.taxPercentage!;
            tax = taxmodel.first.taxType!;
            taxName = taxmodel.first.taxName!;

            change(taxpercentage);
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

  static sucess(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          content: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  color: MyColors.white,
                  child: Image.asset(
                    Assets.successImage,
                    scale: 2,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Success',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: MyFont.myFont,
                          fontSize: 30,
                          color: MyColors.black,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        'Order Saved Successfully',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: MyFont.myFont,
                          fontSize: 18,
                          color: MyColors.black,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void updateProductCount() {
    for (var product in selectedItems) {
      cartService.cartItems.firstWhereOrNull((element) {
        if (element.productCode == product.productCode) {
          product.boxcountController.text = element.boxcount.toInt().toString();
          product.unitcountController.text =
              element.unitcount.toInt().toString();
          product.WeightcountController.text = element.unitcount.toString();
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
