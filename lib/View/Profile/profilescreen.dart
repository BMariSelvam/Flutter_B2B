import 'package:flutter/material.dart';

import '../../Helper/colors.dart';
import '../../Helper/fonts.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          children: [
            TextFormField(
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
    );
  }
}
