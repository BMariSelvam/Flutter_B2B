import 'package:b2b/Helper/HttpUrl.dart';
import 'package:b2b/Helper/NetworkClass.dart';
import 'package:b2b/Helper/preferenceHelper.dart';
import 'package:b2b/Model/PaymentModel.dart';
import 'package:b2b/Model/login_model1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PaymentController extends GetxController with StateMixin {
  RxInt counter = 0.obs;

  Rx<bool> isLoading = false.obs;
  List<PaymentModel> PaymentModelList = [];

  // Rx<List<PaymentModel>?> PaymentModelList = (null as List<PaymentModel>?).obs;
  LoginUser? loginUser;

  @override
  onInit() async {
    super.onInit();
    getPaymentList();
  }

  getPaymentList() async {
    isLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    await NetworkService.get(
      url: HttpUrl.receiptGetHeaderSearch,
      parameters: {
        "searchModel.organisationId": "1",
        "searchModel.customerCode": loginUser!.code,
      },
    ).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            PaymentModelList = (response.apiResponseModel!.data as List)
                .map((e) => PaymentModel.fromJson(e))
                .toList();
            change(PaymentModelList);
            return;
          }
        } else {
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
