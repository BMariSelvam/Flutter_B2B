import 'package:b2b/Helper/HttpUrl.dart';
import 'package:b2b/Helper/NetworkClass.dart';
import 'package:b2b/Helper/preferenceHelper.dart';
import 'package:b2b/Model/OrderModel.dart';
import 'package:b2b/Model/login_model1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController with StateMixin {
  RxInt counter = 0.obs;
  Rx<bool> isLoading = false.obs;
  List<OrderModel> ordersModelList = [];
  LoginUser? loginUser;

  @override
  onInit() async {
    // getOrderList();
    super.onInit();
  }

  getOrderList() async {
    isLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    NetworkService.get(url: HttpUrl.salesOrderGetHeaderSearch, parameters: {
      "searchModel.organisationId": "1",
      "searchModel.customerCode": loginUser!.code,
    }).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            ordersModelList = (response.apiResponseModel!.data as List)
                .map((e) => OrderModel.fromJson(e))
                .toList();
            change(ordersModelList);
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
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "ee",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }
}
