import 'package:b2b/Helper/HttpUrl.dart';
import 'package:b2b/Helper/NetworkClass.dart';
import 'package:b2b/Helper/preferenceHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confromPasswordController =
      TextEditingController();

  changePassword(changepassword, currentpassword) async {
    isLoading.value = true;
    await NetworkService.post(
      URl: HttpUrl.login,
      params: {
        "OrganizationId": 1,
        "EmailId":
            await PreferenceHelper.getUserData().then((value) => value?.mail),
        "Password": currentpassword,
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null &&
            (apiResponse.apiResponseModel!.result as List).isNotEmpty) {
          Map<String, dynamic>? customerJson =
              (apiResponse.apiResponseModel!.result! as List).first;
          if (customerJson != null) {
            changeConfrimPassword(changepassword, currentpassword);
          } else {
            PreferenceHelper.showSnackBar(
                context: Get.context!, msg: "Your Current password is worng");
          }
        } else {
          PreferenceHelper.showSnackBar(
              context: Get.context!, msg: "Your Current password is worng");
        }
      } else {
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }

  changeConfrimPassword(changepassword, currentpassword) async {
    isLoading.value = true;
    update();
    await NetworkService.post(
      URl: HttpUrl.getCustomerChangepassword,
      params: {
        "OrgId": 1,
        "CustomerCode":
            "${(await PreferenceHelper.getUserData().then((value) => value?.code))}",
        "UserName":
            "${await PreferenceHelper.getUserData().then((value) => value?.name)}",
        "OldPassword": "${currentpassword}",
        "NewPassword": "${changepassword}",
        "CreatedBy": "admin",
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.status) {
          await PreferenceHelper.clearUserData();
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
}
