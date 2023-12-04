import 'package:b2b/Helper/NetworkClass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/HttpUrl.dart';
import '../../Helper/preferenceHelper.dart';
import '../../approute.dart';

class LoginController extends GetxController with StateMixin {
  final loginKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;
  bool isButtonDisabled = false;

  // login() async {
  //   isLoading.value = true;
  //   await NetworkService.post(URl: HttpUrl.login, params: {
  //     "OrgId": "1",
  //     "Username": userNameController.text.trim(),
  //     "Password": passwordController.text.trim(),
  //     "BranchCode": "HO"
  //   }).then((apiResponse) async {
  //     isLoading.value = false;
  //     if (apiResponse.apiResponseModel != null &&
  //         apiResponse.apiResponseModel!.status) {
  //       if (apiResponse.apiResponseModel!.data != null &&
  //           (apiResponse.apiResponseModel!.data as List).isNotEmpty) {
  //         Map<String, dynamic>? customerJson =
  //             (apiResponse.apiResponseModel!.data! as List).first;
  //         print("00000000000");
  //         print(customerJson);
  //         if (customerJson != null) {
  //           print("1111111111");
  //           change(null, status: RxStatus.success());
  //           await PreferenceHelper.saveUserData(customerJson)
  //               .then((value) async {
  //             Get.offAllNamed(AppRoutes.bottomNavBar0);
  //           });
  //         } else {
  //           change(null, status: RxStatus.error());
  //           Get.showSnackbar(GetSnackBar(
  //             margin: const EdgeInsets.all(10),
  //             borderRadius: 10,
  //             backgroundColor: Colors.red,
  //             title: "Error",
  //             message: apiResponse.apiResponseModel!.message!,
  //             icon: const Icon(Icons.error, color: Colors.white),
  //             duration: const Duration(seconds: 3),
  //           ));
  //         }
  //       } else {
  //         change(null, status: RxStatus.error());
  //         Get.showSnackbar(GetSnackBar(
  //           margin: const EdgeInsets.all(10),
  //           borderRadius: 10,
  //           backgroundColor: Colors.red,
  //           title: "Error",
  //           message: apiResponse.apiResponseModel!.message!,
  //           icon: const Icon(Icons.error, color: Colors.white),
  //           duration: const Duration(seconds: 3),
  //         ));
  //       }
  //     } else {
  //       Get.showSnackbar(GetSnackBar(
  //         margin: const EdgeInsets.all(10),
  //         borderRadius: 10,
  //         backgroundColor: Colors.red,
  //         title: "Error",
  //         message: apiResponse.apiResponseModel!.message!,
  //         icon: const Icon(Icons.error, color: Colors.white),
  //         duration: const Duration(seconds: 3),
  //       ));
  //     }
  //     isLoading.value = false;
  //     update();
  //   });
  // }

  login() async {
    // try {
    //   // Check internet connectivity before making the request
    //   bool isConnected = await NetworkService.isNetworkAvailable();
    //   print("checking1111111111===========$isConnected");
    //   if (!isConnected) {
    //     // Show a snackbar or dialog to inform the user about the network connection failure.
    //     throw Exception('No internet connection.');
    //   }
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkService.post(URl: HttpUrl.login, params: {
      "OrgId": 1,
      "Username": userNameController.text.trim(),
      "Password": passwordController.text.trim(),
      "BranchCode": "HO"
    }).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null &&
            (apiResponse.apiResponseModel!.data as List).isNotEmpty) {
          Map<String, dynamic>? customerJson =
              (apiResponse.apiResponseModel!.data! as List).first;

          if (customerJson != null) {
            change(null, status: RxStatus.success());
            await PreferenceHelper.saveUserData(customerJson).then((value) {
              Get.offAllNamed(AppRoutes.bottomNavBar0);
            });
            await PreferenceHelper.saveEmail(
                key: "my_key", value: userNameController.text);
          } else {
            change(null, status: RxStatus.error());
            Get.showSnackbar(GetSnackBar(
              margin: const EdgeInsets.all(10),
              borderRadius: 10,
              backgroundColor: Colors.red,
              title: "Error",
              message: apiResponse.apiResponseModel!.message!,
              icon: const Icon(Icons.error, color: Colors.white),
              duration: const Duration(seconds: 3),
            ));
          }
        } else {
          change(null, status: RxStatus.error());
          Get.showSnackbar(GetSnackBar(
            margin: const EdgeInsets.all(10),
            borderRadius: 10,
            backgroundColor: Colors.red,
            title: "Error",
            message: apiResponse.apiResponseModel!.message!,
            icon: const Icon(Icons.error, color: Colors.white),
            duration: const Duration(seconds: 3),
          ));
        }
      } else {
        change(null, status: RxStatus.error());
        Get.showSnackbar(GetSnackBar(
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          backgroundColor: Colors.red,
          message: apiResponse.apiResponseModel!.message!,
          icon: const Icon(Icons.error, color: Colors.white),
          duration: const Duration(seconds: 3),
        ));
      }
      // isLoading.value = true;
      // LoginUser? loginUser = await PreferenceHelper.getUserData();
      // change(null, status: RxStatus.loading());
      // await NetworkService.get(
      //   url: HttpUrl.taxGetApi,
      //   parameters: {
      //     "OrganizationId": 1,
      //     "TaxCode": loginUser?.taxTypeId,
      //   },
      // ).then((apiResponse) async {
      //   // ... Rest of your code ...
      // });
    });
    // } catch (e) {
    //   // print('Error: $e');
    //   // Get.snackbar(
    //   //   'Error',
    //   //   'No internet connection.',
    //   //   snackPosition: SnackPosition.BOTTOM,
    //   //   duration: Duration(seconds: 3),
    //   // );
    //   Get.showSnackbar(const GetSnackBar(
    //     margin: EdgeInsets.all(10),
    //     borderRadius: 10,
    //     backgroundColor: Colors.red,
    //     title: "Error",
    //     message: 'No internet connection.',
    //     icon: Icon(Icons.error, color: Colors.white),
    //     duration: Duration(seconds: 3),
    //   ));
    // }
  }
}
