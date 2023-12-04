import 'package:b2b/Helper/size.dart';
import 'package:b2b/Model/OrderModel.dart';
import 'package:b2b/Model/PaymentModel.dart';
import 'package:b2b/Model/ProductModel1.dart';
import 'package:b2b/View/Order/Order_controller.dart';
import 'package:b2b/View/Payment/PaymentController.dart';
import 'package:b2b/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Helper/colors.dart';
import '../../../Helper/fonts.dart';

class PaymentInvoiceScreen extends StatefulWidget {
  const PaymentInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<PaymentInvoiceScreen> createState() => _OrderInvoiceScreenState();
}

class _OrderInvoiceScreenState extends State<PaymentInvoiceScreen> {
  late PaymentModel selectedItems;

  double? amount = 0;
  String? orderNo = "";
  String? orderName = "";

  @override
  void initState() {
    super.initState();

    selectedItems = Get.arguments as PaymentModel;

    amount = selectedItems.paidAmount;
    orderNo = selectedItems.tranNo;
    orderName = selectedItems.customerName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      appBar: AppBar(
        backgroundColor: MyColors.mainTheme,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Payment Invoice',
          style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.bold,
              color: MyColors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Number',
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  color: MyColors.black),
            ),
            const SizedBox(height: 10),
            Text(
              orderNo!,
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  color: MyColors.greyText),
            ),
            SizedBox(height: height(context) / 50),
            Text(
              'Order Name',
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  color: MyColors.black),
            ),
            const SizedBox(height: 10),
            Text(
              orderName!,
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  color: MyColors.greyText),
            ),
            SizedBox(height: height(context) / 50),
            Text(
              'Amount',
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  color: MyColors.black),
            ),
            const SizedBox(height: 10),
            Text(
              amount.toString(),
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  color: MyColors.greyText),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: MyColors.mainTheme),
          onPressed: () {},
          child: Text(
            'Print',
            style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.bold,
                color: MyColors.white),
          ),
        ),
      ),
    );
  }
}
