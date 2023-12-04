import 'dart:async';

import 'package:b2b/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Helper/assets.dart';
import '../Helper/preferenceHelper.dart';
import '../Model/login_model1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LoginUser? loginModel1;

  @override
  void initState() {
    super.initState();
    checkUser();
    NavigationFunc();
  }

  checkUser() async {
    loginModel1 = await PreferenceHelper.getUserData();
  }

  NavigationFunc() {
    if (loginModel1 == null) {
      Timer(const Duration(seconds: 2),
          () => Get.offAllNamed(AppRoutes.loginScreen));
    } else {
      Timer(const Duration(seconds: 2),
          () => Get.offAllNamed(AppRoutes.bottomNavBar0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset(Assets.logo, scale: 1.5),
    ));
  }
}

//  fetchData() {
//   var params = {
//     "OrganizationId": "1",
//     "BranchCode" : "jp",
//   };
//   NetworkService.get(HttpUrl.specilaloginapi, parameters: params).then((response) {
//     // Handle the GET response
//     if (response.apiResponseModel != null &&
//         response.apiResponseModel!.status) {
//       print("santhosh chcking");
//       print(response.apiResponseModel?.data[1]["InventoryCode"]);
//     }
//   }).catchError((error) {
//     // Handle GET errors
//     print('GET Error: $error');
//   });
//
//   // Similar usage for POST, PUT, and DELETE requests
// }
