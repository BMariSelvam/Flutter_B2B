import 'package:b2b/Helper/size.dart';
import 'package:b2b/MyProfile_Screen.dart';
import 'package:b2b/View/InVoice/invoicescreen.dart';
import 'package:b2b/View/Payment/paymentscreen.dart';
import 'package:b2b/View/Widget/bottomnavbar.dart';
import 'package:b2b/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Helper/button.dart';
import '../../Helper/colors.dart';
import '../../Helper/fonts.dart';
import '../../Helper/preferenceHelper.dart';
import '../DashBoard/dashboardscreen.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  //ListText
  final List _supportQuestions = [
    'Profile',
    'My Transactions',
    'Return & Refund',
    'T & C',
    'Contact Us',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Get.offAndToNamed(
              AppRoutes.bottomNavBar0,
            );
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: MyColors.mainTheme,
        title: Text("Settings",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: MyFont.myFont,
                color: MyColors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyProfileScreen(),
                        ));
                  },
                  leading: const Icon(
                    Icons.person,
                    color: MyColors.lightBlue,
                  ),
                  title: Text(
                    'Profile',
                    style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: MyColors.black),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                ),
                SizedBox(height: height(context) / 80),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(),
                        ));
                  },
                  leading: const Icon(
                    Icons.monetization_on_rounded,
                    color: MyColors.lightBlue,
                  ),
                  title: Text(
                    'My Transactions',
                    style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: MyColors.black),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                ),
                SizedBox(height: height(context) / 80),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InvoiceScreen(),
                        ));
                  },
                  leading: const Icon(
                    Icons.money,
                    color: MyColors.lightBlue,
                  ),
                  title: Text(
                    'Invoice',
                    style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: MyColors.black),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                ),
                SizedBox(height: height(context) / 80),
                ListTile(
                  onTap: () {
                    // Get.toNamed(
                    //   AppRoutes.createTicketScreen,
                    // );
                  },
                  leading: const Icon(
                    Icons.attach_money,
                    color: MyColors.lightBlue,
                  ),
                  title: Text(
                    'Return & Refund',
                    style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: MyColors.black),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                ),
                SizedBox(height: height(context) / 80),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.quick_contacts_dialer,
                    color: MyColors.lightBlue,
                  ),
                  title: Text(
                    'T & C',
                    style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: MyColors.black),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                ),
                SizedBox(height: height(context) / 80),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.content_paste_sharp,
                    color: MyColors.lightBlue,
                  ),
                  title: Text(
                    'Contact US',
                    style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: MyColors.black),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                ),
                SizedBox(height: height(context) / 10),
                ListTile(
                  onTap: () async {
                    await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Are you sure you want to logout?'),
                          actionsAlignment: MainAxisAlignment.spaceAround,
                          actions: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  Get.back();
                                });
                              },
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                // await PreferenceHelper.clearUserData();
                                Get.offAllNamed(AppRoutes.loginScreen);
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                child: Text(
                                  'Log Out',
                                  style: TextStyle(
                                      fontSize: 15, color: MyColors.white),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                  leading: const Icon(
                    Icons.logout_rounded,
                    color: MyColors.lightBlue,
                  ),
                  title: Text(
                    "Log Out",
                    style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: MyColors.black),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
