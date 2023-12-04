import 'package:b2b/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Helper/colors.dart';
import '../../Helper/fonts.dart';

class CreateTicket extends StatefulWidget {
  const CreateTicket({Key? key}) : super(key: key);

  @override
  State<CreateTicket> createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.mainTheme,
        title: Text(
          'Ticket',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: MyFont.myFont,
              color: MyColors.white),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: ElevatedButton(
          child: Text(
            'Submit',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: MyFont.myFont,
                color: MyColors.white),
          ),
          onPressed: () {
            Get.toNamed(AppRoutes.ticketSubmit);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Your Name',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: MyFont.myFont,
                  color: MyColors.black),
            ),
            const SizedBox(height: 20),
            TextFormField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    hintText: 'Name',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: MyFont.myFont,
                      fontSize: 15,
                    ),
                    border: const OutlineInputBorder())),
            const SizedBox(height: 20),
            Text(
              'Enter Your Email',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: MyFont.myFont,
                  color: MyColors.black),
            ),
            const SizedBox(height: 20),
            TextFormField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    hintText: 'Email Address',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: MyFont.myFont,
                      fontSize: 15,
                    ),
                    border: const OutlineInputBorder())),
            const SizedBox(height: 20),
            Text(
              'Message',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: MyFont.myFont,
                  color: MyColors.black),
            ),
            const SizedBox(height: 20),
            TextFormField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    hintText: 'Message',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: MyFont.myFont,
                      fontSize: 15,
                    ),
                    border: const OutlineInputBorder())),
            const SizedBox(height: 20),
            Text(
              'Attachment',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: MyFont.myFont,
                  color: MyColors.black),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                hintText: 'Choose Your File',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: MyFont.myFont,
                  fontSize: 15,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
