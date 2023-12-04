import 'package:b2b/View/DashBoard/dashboardscreen.dart';
import 'package:b2b/View/Widget/bottomnavbar.dart';
import 'package:b2b/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Helper/colors.dart';
import '../InVoice/invoicescreen.dart';
import '../Order/orderscreen.dart';
import '../Payment/paymentscreen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.mainTheme,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              setState(() {
                Get.back();
              });
            },
          ),
          title: const Text('Order'),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: MyColors.white,
            tabs: [
              Tab(text: 'Orders'),
              Tab(text: 'Invoice'),
              Tab(text: 'Payment'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OrderScreen(),
            InvoiceScreen(),
            PaymentScreen(),
          ],
        ),
      ),
    );
  }
}
