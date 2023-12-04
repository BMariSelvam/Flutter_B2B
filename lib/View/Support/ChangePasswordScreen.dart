import 'package:b2b/Helper/button.dart';
import 'package:b2b/Helper/fonts.dart';
import 'package:b2b/Helper/size.dart';
import 'package:b2b/View/Support/ChangePasswordController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/preferenceHelper.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool passwordVisibility = true;
  final _formKey = GlobalKey<FormState>();

  late ChangePasswordController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = Get.put(ChangePasswordController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(
            fontFamily: MyFont.myFont,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _controller.currentPasswordController,
                        obscureText: passwordVisibility,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter the your Current Password';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            label: const Text('Current Password'),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordVisibility = !passwordVisibility;
                                });
                              },
                              icon: passwordVisibility
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 0, 0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _controller.newPasswordController,
                        obscureText: passwordVisibility,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter the your New Password';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            label: const Text('New Password'),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordVisibility = !passwordVisibility;
                                });
                              },
                              icon: passwordVisibility
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 0, 0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _controller.confromPasswordController,
                        obscureText: passwordVisibility,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter the your Confirm Password';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            label: const Text('Confirm Password'),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordVisibility = !passwordVisibility;
                                });
                              },
                              icon: passwordVisibility
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 30, bottom: 20, left: 20, right: 20),
              width: width(context),
              child: SubmitButton(
                  isLoading: _controller.isLoading.value,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      print(_controller.confromPasswordController);
                      print(_controller.newPasswordController);
                      if (_controller.newPasswordController.text ==
                          _controller.confromPasswordController.text) {
                        _controller.changePassword(
                            _controller.confromPasswordController.text,
                            _controller.currentPasswordController.text);
                      } else {
                        PreferenceHelper.showSnackBar(
                            context: Get.context!,
                            msg: "Missmatch NewPassword And ConfirmPassword");
                      }
                    }
                  },
                  title: 'Updated Password'),
            ),
          ],
        ),
      ),
    );
  }
}
