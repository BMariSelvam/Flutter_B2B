import 'package:b2b/Helper/assets.dart';
import 'package:b2b/Helper/button.dart';
import 'package:b2b/Helper/colors.dart';
import 'package:b2b/Helper/fonts.dart';
import 'package:b2b/Helper/size.dart';
import 'package:b2b/View/Login/loginscreen.dart';
import 'package:b2b/View/Support/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/valitation.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late ForgetPasswordController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ForgetPasswordController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(builder: (logic) {
      return Form(
        key: controller.forgotPassKey,
        child: Scaffold(
          backgroundColor: MyColors.primaryCustom,
          body: Container(
            height: height(context) / 1.3,
            decoration: const BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))),
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: [
                    SizedBox(height: 120, child: Image.asset(Assets.logo)),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.forgetPasswordController,
                      inputFormatters: [EmailInputFormatter()],
                      maxLength: 100,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter email id";
                        } else if (!validateEmail(value)) {
                          return "Invalid Email Id";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text(
                          "Email",
                          style: TextStyle(fontFamily: MyFont.myFont),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // FocusScope.of(context).unfocus();
                        // if (controller.forgotPassKey.currentState!.validate()) {
                        //   controller.forgotPasswordType(context);
                        // }
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
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 35.0, vertical: 10.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 18, color: MyColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class SuccessfulScreen extends StatefulWidget {
  final String text;
  final bool isLoading;
  final String title;
  final Function onTap;

  const SuccessfulScreen({
    Key? key,
    required this.text,
    required this.isLoading,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SuccessfulScreen> createState() => _SuccessfulScreenState();
}

class _SuccessfulScreenState extends State<SuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.successImage),
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SubmitButton(
            isLoading: widget.isLoading,
            onTap: widget.onTap,
            title: widget.title),
      ),
    );
  }
}
