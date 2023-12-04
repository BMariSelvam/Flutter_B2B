import 'package:b2b/Helper/HttpUrl.dart';
import 'package:b2b/Helper/NetworkClass.dart';
import 'package:b2b/Helper/preferenceHelper.dart';
import 'package:b2b/Model/invoiceModel.dart';
import 'package:b2b/Model/login_model1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InVoiceController extends GetxController with StateMixin {
  RxInt counter = 0.obs;
  Rx<bool> isLoading = false.obs;
  List<InvoiceModel> invoiceModelList = [];
  LoginUser? loginUser;

  @override
  onInit() async {
    getInvoiceList();
    super.onInit();
  }

  getInvoiceList() async {
    isLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    await NetworkService.get(url: HttpUrl.invoiceGetHeaderSearch, parameters: {
      "searchModel.customerCode": loginUser!.code,
      "searchModel.organisationId": "1",
    }).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            invoiceModelList = (response.apiResponseModel!.data as List)
                .map((e) => InvoiceModel.fromJson(e))
                .toList();
            change(invoiceModelList);
            return;
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
}
