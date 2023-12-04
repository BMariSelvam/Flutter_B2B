import 'package:b2b/Model/OrderModel.dart';
import 'package:b2b/Model/PaymentModel.dart';
import 'package:b2b/View/Payment/PaymentController.dart';
import 'package:b2b/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Helper/colors.dart';
import '../../Helper/fonts.dart';
import '../../Helper/size.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late PaymentController paymentController;

  @override
  void initState() {
    paymentController = Get.put(PaymentController());
    paymentController.getPaymentList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(builder: (logic) {
      return Scaffold(
        backgroundColor: MyColors.grey,
        appBar: AppBar(
          backgroundColor: MyColors.mainTheme,
          iconTheme: const IconThemeData(color: MyColors.white),
          title: Text(
            'Payment',
            style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.bold,
                color: MyColors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
        ),
        body: Stack(children: [
          PaymentList(),
          if (paymentController.status.isLoadingMore)
            const Center(
              child: CircularProgressIndicator(),
            )
        ]),
      );
    });
  }

  PaymentList() {
    if (paymentController.PaymentModelList.isNotEmpty) {
      return Padding(
          padding: const EdgeInsets.fromLTRB(8, 3, 8, 0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: paymentController.PaymentModelList.length ?? 0,
              itemBuilder: (context, index) {
                DateTime dateTime = DateFormat("yyyy-MM-dd").parse(
                    paymentController.PaymentModelList[index].tranDate
                        .toString());
                String date = DateFormat("dd-MM-yyyy").format(dateTime);
                return Container(
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: Card(
                    elevation: 5,
                    shadowColor: MyColors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Date ',
                                      style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: MyColors.greyText)),
                                  TextSpan(
                                      text: date.toString(),
                                      style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: MyColors.greyText)),
                                ])),
                                Card(
                                  color: Colors.deepOrange,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(
                                      paymentController
                                          .PaymentModelList[index].payMode!,
                                      style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: MyColors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 2, top: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Payment No : ',
                                      style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: MyColors.black)),
                                  TextSpan(
                                      text: paymentController
                                          .PaymentModelList[index].tranNo,
                                      style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: MyColors.black)),
                                ])),
                                Column(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                        color: MyColors.grey,
                                      ))),
                                      child: Text(
                                        'Amount : ',
                                        style: TextStyle(
                                            fontFamily: MyFont.myFont,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: MyColors.greyText),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      paymentController.PaymentModelList[index]
                                              .paidAmount
                                              .toString() ??
                                          " ",
                                      style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: MyColors.mainTheme),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.offNamed(AppRoutes.paymentInvoiceScreen,
                                  arguments: paymentController
                                      .PaymentModelList[index]);
                            },
                            child: Text(
                              'View Invoice',
                              style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: MyColors.mainTheme),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }));
    } else {
      if (paymentController.status.isLoadingMore ||
          paymentController.status.isLoading) {
        return Container();
      }
      const Center(
        child: Text("No Order found"),
      );
    }
  }
}
