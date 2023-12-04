import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Helper/colors.dart';
import '../../Helper/fonts.dart';
import '../../Helper/preferenceHelper.dart';
import '../../Model/login_model1.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  LoginUser? loginModel1;
  var orgName;
  String? phoneNumber;
  String? Email;
  TextEditingController nameController = TextEditingController();
  TextEditingController phnoeController = TextEditingController();
  TextEditingController EmailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initial();
  }
  _initial() async {
    await PreferenceHelper.getUserData().then((value) =>
        setState(() {
          orgName = value?.name;
          phoneNumber = value?.phone;
          Email = value?.mail;
        })
    );
    print("===$orgName====$phoneNumber=========$Email");
     nameController.text = orgName;
     phnoeController.text = phoneNumber!;
     EmailController.text = Email!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: MyColors.primaryCustom,
                ),
                hintText: 'Name',
                hintStyle: TextStyle(fontFamily: MyFont.myFont),
                contentPadding: const EdgeInsets.all(10.0),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: phnoeController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.phone_android,
                  color: MyColors.primaryCustom,
                ),
                hintText: 'Mobile Number',
                hintStyle: TextStyle(fontFamily: MyFont.myFont),
                contentPadding: const EdgeInsets.all(10.0),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: EmailController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: MyColors.primaryCustom,
                ),
                hintText: 'E-Mail',
                hintStyle: TextStyle(fontFamily: MyFont.myFont),
                contentPadding: const EdgeInsets.all(10.0),
                border: const OutlineInputBorder(),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  side: const BorderSide(color: MyColors.mainTheme)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 18, color: MyColors.mainTheme),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 18, color: MyColors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
