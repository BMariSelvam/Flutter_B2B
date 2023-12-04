import 'package:b2b/Helper/size.dart';
import 'package:b2b/View/Support/forgetpasswordscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper/assets.dart';
import '../../Helper/button.dart';
import '../../Helper/colors.dart';
import '../../Helper/fonts.dart';
import '../../Helper/valitation.dart';
import 'logincontroller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController controller;
  bool passwordVisibility = true;
  bool _isChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(LoginController());
    loadUserEmailPassword();
    // controller.userNameController.text = "joseph@gmail.com";
    // controller.passwordController.text = "098765";
    // controller.userNameController.text = "kapilan@gmail.com";
    // controller.passwordController.text = "123456";
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (logic) {
      return Form(
        key: controller.loginKey,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                            child: Image.asset(Assets.login),
                          ),
                          SizedBox(height: height(context) / 20),
                          Text(
                            'Sign In',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: MyFont.myFont,
                                fontSize: 18,
                                color: MyColors.black),
                          ),
                          SizedBox(height: height(context) / 50),
                          Text(
                            'Log In to Your Account',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: MyFont.myFont,
                                fontSize: 18,
                                color: MyColors.greyText),
                          ),
                          SizedBox(height: height(context) / 20),
                          TextFormField(
                            controller: controller.userNameController,
                            inputFormatters: [
                              MyInputFormatter(),
                            ],
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: MyFont.myFont,
                                  color: MyColors.greyText),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter the Username';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: height(context) / 20),
                          TextFormField(
                            controller: controller.passwordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordVisibility = !passwordVisibility;
                                  });
                                },
                                icon: passwordVisibility
                                    ? const Icon(Icons.visibility_off,
                                        color: MyColors.mainTheme)
                                    : const Icon(Icons.visibility,
                                        color: MyColors.mainTheme),
                              ),
                              border: const OutlineInputBorder(),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: MyFont.myFont,
                                  color: MyColors.greyText),
                            ),
                            obscureText: passwordVisibility,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter the Password';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: height(context) / 40),
                          remberMeCheckBox(),
                          SizedBox(height: height(context) / 20),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPasswordScreen(),
                                    ));
                              },
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: MyFont.myFont,
                                    fontSize: 18,
                                    color: MyColors.mainTheme),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: StatefulBuilder(builder: (context, setState) {
                      return SubmitButton(
                          isLoading: controller.isLoading.value,
                          onTap: () {
                            setState(() {
                              FocusScope.of(context).unfocus();
                              if (controller.loginKey.currentState!
                                  .validate()) {
                                controller.login();
                              }
                            });
                          },
                          title: 'Log In');
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  remberMeCheckBox() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
        height: 24.0,
        width: 24.0,
        child: Theme(
            data: ThemeData(
                unselectedWidgetColor: MyColors.mainTheme // Your color
                ),
            child: Checkbox(
              activeColor: MyColors.mainTheme,
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  handleRemeberme(value!);
                });
              },
            )),
      ),
      const SizedBox(width: 10.0),
      const Text("Remember Me",
          style: TextStyle(
            color: MyColors.mainTheme,
            fontSize: 15,
          ))
    ]);
  }

  //handle remember me function
  handleRemeberme(bool value) {
    _isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('User Name', controller.userNameController.text);
        prefs.setString('password', controller.passwordController.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  //load email and password
  loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("User Name") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;
      print(_remeberMe);
      print(_email);
      print(_password);
      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        controller.userNameController.text = _email ?? "";
        controller.passwordController.text = _password ?? "";
      }
    } catch (e) {
      print(e);
    }
  }
}
