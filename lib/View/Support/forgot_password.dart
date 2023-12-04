import 'package:b2b/Helper/HttpUrl.dart';
import 'package:b2b/Helper/NetworkClass.dart';
import 'package:b2b/View/Login/loginscreen.dart';
import 'package:b2b/View/Support/forgetpasswordscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/preferenceHelper.dart';

class ForgetPasswordController extends GetxController with StateMixin {
  TextEditingController forgetPasswordController = TextEditingController();
  final forgotPassKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;
  int loginType = 1;


  forgotPasswordType( context) async {
    await NetworkService.post(
      URl:HttpUrl.login,
      params: {
        "OrganizationId": 1,
        "EmailId": forgetPasswordController.text.trim(),
        "Password": forgetPasswordController.text.trim(),
      },
    ).then((apiResponse) async {
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel?.result) {
          forgetPasswordApi("S", context);
        }
          else {
          PreferenceHelper.showSnackBar(context: Get.context!, msg: "User not Match please Check");

      }
    }});
  }

  forgetPasswordApi(userType, context) async {
    isLoading.value = true;

    await NetworkService.post(
    URl: HttpUrl.getforgotPassword,
      params: {
        "OrganizationId": 1,
        "EmailId": forgetPasswordController.text,
        "UserType": userType,
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.status) {
          Get.to(SuccessfulScreen(
              text: "Password Sent To Your \n Email",
              isLoading: false,
              title: "Go to Login",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              }));
        } else {
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }
}
