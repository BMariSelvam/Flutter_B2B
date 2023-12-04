import 'package:b2b/Helper/size.dart';
import 'package:b2b/Model/OrderModel.dart';
import 'package:b2b/Model/invoiceModel.dart';
import 'package:b2b/View/InVoice/InvoicePrint/invoicePrintScreenController.dart';

import 'package:b2b/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../Helper/colors.dart';
import '../../../../Helper/fonts.dart';
import 'package:flutter/services.dart';

class InvoicePrintScreen extends StatefulWidget {
  const InvoicePrintScreen({Key? key}) : super(key: key);

  @override
  State<InvoicePrintScreen> createState() => _InvoicePrintScreenState();
}

class _InvoicePrintScreenState extends State<InvoicePrintScreen> {
  late InvoiceModel selectedItems;

  String? date = "";

  late InvoicePrintController controller;

  @override
  void initState() {
    super.initState();
    selectedItems = Get.arguments as InvoiceModel;
    controller = Get.put(InvoicePrintController());
    controller.getInvoicePreviewList(selectedItems.tranNo);
    DateTime dateTime =
        DateFormat("yyyy-MM-dd").parse(selectedItems.createdOn!.toString());
    date = DateFormat("dd-MM-yyyy").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Invoice',
            style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.bold,
                color: MyColors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.payments_rounded),
              onPressed: () {
                setState(() {});
              },
            )
          ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                selectedItems.customerName ?? "",
                style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: MyColors.mainTheme),
              ),
            ),
            SizedBox(height: height(context) / 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Customer Id : ',
                  style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      color: MyColors.black),
                ),
                Text(
                  selectedItems.customerId!,
                  style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      color: MyColors.mainTheme),
                ),
              ],
            ),
            SizedBox(height: height(context) / 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Invoice No : ',
                  style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      color: MyColors.black),
                ),
                Text(
                  selectedItems.tranNo!,
                  style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      color: MyColors.mainTheme),
                ),
              ],
            ),
            SizedBox(height: height(context) / 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Invoice Date : ',
                  style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      color: MyColors.black),
                ),
                Text(
                  date!,
                  style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      color: MyColors.mainTheme),
                ),
              ],
            ),
            SizedBox(height: height(context) / 50),
            // (controller.storeInvoice.first!.invoiceDetail != null &&
            //         controller.storeInvoice.first!.invoiceDetail!.isNotEmpty)
            //     ?
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: MyColors.mainTheme),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: width(context) / 12,
                    child: Text(
                      "Sl No",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: MyColors.white),
                    ),
                  ),
                  Container(
                    width: width(context) / 5,
                    child: Text(
                      "Description",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: MyColors.white),
                    ),
                  ),
                  Container(
                    width: width(context) / 10,
                    child: Text(
                      "CQty",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: MyColors.white),
                    ),
                  ),
                  Container(
                    width: width(context) / 10,
                    child: Text(
                      "LQty",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: MyColors.white),
                    ),
                  ),
                  Container(
                    width: width(context) / 10,
                    child: Text(
                      "Qty",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: MyColors.white),
                    ),
                  ),
                  Container(
                    width: width(context) / 10,
                    child: Text(
                      "CPrice",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: MyColors.white),
                    ),
                  ),
                  Container(
                    width: width(context) / 10,
                    child: Text(
                      "LPrice",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: MyColors.white),
                    ),
                  ),
                  // dashBoardController.ordersModelList[index].total.toString(),
                ],
              ),
            ),
            // : Container(),
            recentInvoiceItemsListViewBuilder(),
            SizedBox(height: height(context) / 50),
            const Divider(
              thickness: 1,
              color: MyColors.greyText,
            ),

            SizedBox(height: height(context) / 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sub Total',
                  style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      color: MyColors.black),
                ),
                Text(
                  "\$ ${selectedItems.subTotal!.toStringAsFixed(2)} ",
                  style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      color: MyColors.mainTheme),
                ),
              ],
            ),
            SizedBox(height: height(context) / 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Tax',
                      style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          color: MyColors.black),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "   ( ${selectedItems.taxPerc!.toString()} % ) ",
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            color: MyColors.mainTheme,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "\$ ${selectedItems.tax!.toStringAsFixed(2)} ",
                  style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      color: MyColors.mainTheme),
                ),
              ],
            ),
            SizedBox(height: height(context) / 50),
            const Divider(
              thickness: 1,
              color: MyColors.greyText,
            ),

            SizedBox(height: height(context) / 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Net Total',
                  style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      color: MyColors.black),
                ),
                Text(
                  "\$ ${selectedItems.netTotal!.toStringAsFixed(2)} ",
                  style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      color: MyColors.mainTheme),
                ),
              ],
            ),

            SizedBox(height: height(context) / 30),
            Row(
              children: [
                Text(
                  'Remark : ',
                  style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      color: MyColors.black),
                ),
                Text(
                  selectedItems.remarks!,
                  style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      color: MyColors.mainTheme),
                ),
              ],
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
            'Download',
            style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.bold,
                color: MyColors.white),
          ),
        ),
      ),
    );
  }

  recentInvoiceItemsListViewBuilder() {
    return GetBuilder<InvoicePrintController>(builder: (logic) {
      if (logic.isLoading.value == true) {
        return const Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: CircularProgressIndicator(
              color: MyColors.mainTheme,
            ),
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.storeInvoice.first.invoiceDetail?.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
                color: MyColors.white,
                border: Border.all(color: MyColors.grey)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width(context) / 12,
                  child: Text(
                    controller.storeInvoice.first.invoiceDetail?[index].slNo
                            .toString() ??
                        (index + 1).toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                        color: MyColors.black),
                  ),
                ),
                Container(
                  width: width(context) / 5,
                  child: Text(
                    controller.storeInvoice.first.invoiceDetail?[index]
                            .productName! ??
                        "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                        color: MyColors.black),
                  ),
                ),
                Container(
                  width: width(context) / 10,
                  child: Text(
                    " ${controller.storeInvoice.first.invoiceDetail?[index].boxQty} ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                        color: MyColors.black),
                  ),
                ),
                Container(
                  width: width(context) / 10,
                  child: Text(
                    " ${controller.storeInvoice.first.invoiceDetail?[index].pcsQty} ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                        color: MyColors.black),
                  ),
                ),
                Container(
                  width: width(context) / 10,
                  child: Text(
                    "  ${controller.storeInvoice.first.invoiceDetail?[index].qty} ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                        color: MyColors.black),
                  ),
                ),

                Container(
                  width: width(context) / 10,
                  child: Text(
                    "\$ ${controller.storeInvoice.first.invoiceDetail?[index].boxPrice!.toStringAsFixed(2)} ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                        color: MyColors.black),
                  ),
                ),
                Container(
                  width: width(context) / 10,
                  child: Text(
                    "\$ ${controller.storeInvoice.first.invoiceDetail?[index].price!.toStringAsFixed(2)} ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                        color: MyColors.black),
                  ),
                ),
                // dashBoardController.ordersModelList[index].total.toString(),
              ],
            ),
          );
        },
      );
    });
  }

// Future<void> generatePDF() async {
//   final pdf = pw.Document();
//
//   // Add content to the PDF
//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) {
//         return pw.Center(
//           child: pw.Text('Hello, World!', style: pw.TextStyle(fontSize: 40)),
//         );
//       },
//     ),
//   );
//
//   // Save the PDF file
//   final bytes = await doc.save();
//
//   // Save the PDF file
//   final directory = await getTemporaryDirectory();
//   final file = File('${directory.path}/example.pdf' as List<Object>);
//   await file.writeAsBytes(bytes);
//
//   // Open the generated PDF file
//   await Printing.sharePdf(bytes: bytes, filename: 'example.pdf');
// }
}
