import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Helper/colors.dart';
import '../../Helper/fonts.dart';
import '../../approute.dart';

class TicketCreatedSuccessFully extends StatefulWidget {
  const TicketCreatedSuccessFully({Key? key}) : super(key: key);

  @override
  State<TicketCreatedSuccessFully> createState() =>
      _TicketCreatedSuccessFullyState();
}

class _TicketCreatedSuccessFullyState extends State<TicketCreatedSuccessFully> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: ElevatedButton(
          child: Text(
            'Go To DashBoard',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: MyFont.myFont,
                color: MyColors.white),
          ),
          onPressed: () {
            Get.toNamed(AppRoutes.bottomNavBar0);
          },
        ),
      ),
      body: const Center(
        child: Text('Your Ticket Submitted'),
      ),
    );
  }
}
