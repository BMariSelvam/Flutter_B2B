import 'package:b2b/Helper/HttpUrl.dart';
import 'package:b2b/Helper/NetworkClass.dart';
import 'package:b2b/Model/login_model1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Model/OrderModel.dart';
import '../../../Model/OrderProductList/StorageOrder.dart';

class OrderPrintController extends GetxController with StateMixin {
  RxInt counter = 0.obs;
  Rx<bool> isLoading = false.obs;
  LoginUser? loginUser;
  List<StorageOrder> ordersModelList = [];

  // getOrderPreviewList(String? tranNo) async {
  //   isLoading.value = true;
  //   try {
  //     NetworkService.get(url: HttpUrl.salesOrderGetbycode, parameters: {
  //       "OrganizationId": "1",
  //       "TranNo": tranNo,
  //     }).then((response) {
  //       isLoading.value = false;
  //       if (response.apiResponseModel != null &&
  //           response.apiResponseModel!.status) {
  //         if (response.apiResponseModel!.data != null) {
  //           List? resJson = response.apiResponseModel!.data!;
  //           if (resJson != null) {
  //             ordersModelList = (response.apiResponseModel!.data as List)
  //                 .map((e) => StorageOrder.fromJson(e))
  //                 .toList();
  //             print("1111111111111$ordersModelList");
  //             change(ordersModelList);
  //           }
  //         } else {
  //           Get.showSnackbar(
  //             GetSnackBar(
  //               title: "Error",
  //               message: response.apiResponseModel!.message ?? '',
  //               icon: const Icon(Icons.error),
  //               duration: const Duration(seconds: 3),
  //             ),
  //           );
  //         }
  //       }
  //     });
  //   } catch (error) {
  //     change(null, status: RxStatus.error());
  //     Get.showSnackbar(
  //       GetSnackBar(
  //         title: "Error",
  //         message: error.toString(),
  //         icon: const Icon(Icons.error),
  //         duration: const Duration(seconds: 3),
  //       ),
  //     );
  //   }
  // }

  getOrderPreviewList(String? tranNo) async {
    isLoading.value = true;
    try {
      NetworkService.get(url: HttpUrl.salesOrderGetbycode, parameters: {
        "OrganizationId": "1",
        "TranNo": tranNo,
      }).then((response) {
        isLoading.value = false;
        if (response.apiResponseModel != null &&
            response.apiResponseModel!.status) {
          if (response.apiResponseModel!.data != null) {
            List? resJson = response.apiResponseModel!.data!;
            if (resJson != null) {
              ordersModelList = (response.apiResponseModel!.data as List)
                  .map((e) => StorageOrder.fromJson(e))
                  .toList();
              change(ordersModelList);
              print("lengthvalue----------------------------");
              print( ordersModelList.first.salesOrderDetail?.length);
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
