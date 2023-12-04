import 'package:b2b/Helper/HttpUrl.dart';
import 'package:b2b/Helper/NetworkClass.dart';
import 'package:b2b/Model/invoiceprintModel/StoreInvoice.dart';
import 'package:b2b/Model/login_model1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoicePrintController extends GetxController with StateMixin {
  RxInt counter = 0.obs;
  Rx<bool> isLoading = false.obs;
  LoginUser? loginUser;
  List<StoreInvoice> storeInvoice = [];

  getInvoicePreviewList(String? tranNo) async {
    isLoading.value = true;
    try {
      NetworkService.get(url: HttpUrl.invoiceGetbycode, parameters: {
        "OrganizationId": "1",
        "TranNo": tranNo,
      }).then((response) {
        isLoading.value = false;
        if (response.apiResponseModel != null &&
            response.apiResponseModel!.status) {
          if (response.apiResponseModel!.data != null) {
            List? resJson = response.apiResponseModel!.data!;
            if (resJson != null) {
              storeInvoice = (response.apiResponseModel!.data as List)
                  .map((e) => StoreInvoice.fromJson(e))
                  .toList();
              change(storeInvoice);
              print("lengthvalue");
              print(storeInvoice.first.invoiceDetail?.length);
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
      });
    } catch (error) {
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
