import 'dart:async';

import 'package:b2b/Helper/assets.dart';
import 'package:b2b/Helper/colors.dart';
import 'package:b2b/Helper/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../approute.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () =>
            //Get.toNamed(AppRoutes.bottomNavBar)
            Get.toNamed(AppRoutes.bottomNavBar0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: MyColors.white,
              child: Image.asset(
                Assets.successImage,
                scale: 2,
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Text(
                'successfully',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: MyFont.myFont,
                  fontSize: 30,
                  color: MyColors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
