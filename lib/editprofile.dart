import 'package:b2b/Helper/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Helper/assets.dart';
import 'Helper/colors.dart';
import 'Helper/preferenceHelper.dart';
import 'Helper/size.dart';
import 'Model/login_model1.dart';
import 'View/Widget/bottomnavbar.dart';
import 'approute.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  LoginUser? loginModel1;
  var orgName;
  String? phoneNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initial();
  }

  _initial() async {
    loginModel1 = await PreferenceHelper.getUserData();
    setState(() {
      orgName = loginModel1?.name;
      phoneNumber = loginModel1?.phone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.mainTheme,
        iconTheme: const IconThemeData(color: MyColors.white),
        leading: IconButton(
          onPressed: () {
            // Get.toNamed(AppRoutes.bottomNavBar);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (builder) => const BottomNavBar()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: MyFont.myFont,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 100,
                width: 100,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(75.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70.0),
                  child: Image.asset(
                    Assets.profile,
                    scale: 10,
                    fit: BoxFit.cover,
                  ),
                )),
            SizedBox(height: height(context) / 50),
            Text(
              '$orgName' ?? "",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: MyColors.mainTheme),
            ),
            SizedBox(height: height(context) / 100),
            Text(
              '$phoneNumber' ?? "",
              style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: MyColors.mainTheme),
            ),
            SizedBox(height: height(context) / 50),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.person,
                color: MyColors.lightBlue,
              ),
              title: Text(
                'Edit Profile',
                style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: MyColors.black),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.location_on,
                color: MyColors.lightBlue,
              ),
              title: Text(
                'Shipping Address',
                style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: MyColors.black),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.password,
                color: MyColors.lightBlue,
              ),
              title: Text(
                'Change Password',
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
      ),
    );
    ;
  }
}
