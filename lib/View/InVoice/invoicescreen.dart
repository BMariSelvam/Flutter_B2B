import 'package:b2b/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../../Helper/colors.dart';
import '../../Helper/fonts.dart';
import 'invoicecontroller.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  late InVoiceController inVoiceController;

  @override
  void initState() {
    inVoiceController = Get.put(InVoiceController());
    inVoiceController.getInvoiceList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InVoiceController>(
      builder: (logic) {
        return Scaffold(
          backgroundColor: MyColors.grey,
          appBar: AppBar(
            backgroundColor: MyColors.mainTheme,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            iconTheme: const IconThemeData(color: MyColors.white),
            title: Text(
              'Invoice',
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  color: MyColors.white),
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              invoiceList(),
              if (inVoiceController.status.isLoadingMore)
                const Center(
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        );
      },
    );
  }

  invoiceList() {
    if (inVoiceController.invoiceModelList.isEmpty &&
        inVoiceController.invoiceModelList.length == null) {
      if (inVoiceController.status.isLoading ||
          inVoiceController.status.isLoadingMore) {
        return Container();
      }
      Center(
        child: Text("No Order found"),
      );
    } else {
      return Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: inVoiceController.invoiceModelList.length,
            itemBuilder: (context, index) {
              DateTime dateTime = DateFormat("yyyy-MM-dd").parse(
                  inVoiceController.invoiceModelList[index].tranDate
                          .toString() ??
                      "");
              String date = DateFormat("dd-MM-yyyy").format(dateTime);

              String amount = inVoiceController
                      .invoiceModelList[index].balanceAmount
                      ?.toStringAsFixed(2) ??
                  "0.00";
              return Container(
                padding: const EdgeInsets.only(
                  top: 2,
                ),
                child: Card(
                  elevation: 5,
                  shadowColor: MyColors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              child: Text('Invoice No : ',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: MyColors.black)),
                            ),
                            SizedBox(
                              child: Text(
                                  inVoiceController
                                          .invoiceModelList[index].tranNo
                                          .toString() ??
                                      "",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: MyColors.mainTheme)),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Date :   ',
                                  style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: MyColors.black)),
                              TextSpan(
                                  text: date.toString(),
                                  style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: MyColors.mainTheme)),
                            ])),
                            // DropdownButtonHideUnderline(
                            //   child: DropdownButton<String>(
                            //     value:
                            //         inVoiceController.selectedValue,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         inVoiceController
                            //             .selectedValue = value;
                            //       });
                            //
                            //       if (inVoiceController
                            //               .selectedValue ==
                            //           'Option 1') {
                            //         Get.toNamed(
                            //             AppRoutes
                            //                 .invoicePrintScreen,
                            //             arguments: inVoiceController
                            //                     .InvoiceModelList[
                            //                 index]);
                            //       }
                            //       // if (inVoiceController.selectedValue ==
                            //       //     'Option 2') {
                            //       //   Get.toNamed(
                            //       //       AppRoutes.orderInvoiceScreen);
                            //       // }
                            //       // if (inVoiceController.selectedValue ==
                            //       //     'Option 3') {
                            //       //   Get.toNamed(
                            //       //       AppRoutes.orderInvoiceScreen);
                            //       // }
                            //     },
                            //     items: const [
                            //       DropdownMenuItem(
                            //         value: 'Option 1',
                            //         child: Text('View Invoice'),
                            //       ),
                            //       // DropdownMenuItem(
                            //       //   value: 'Option 2',
                            //       //   child: Text('Download Invoice'),
                            //       // ),
                            //       // DropdownMenuItem(
                            //       //   value: 'Option 3',
                            //       //   child: Text('Make Payment'),
                            //       // ),
                            //     ],
                            //     icon: const Icon(
                            //       Icons.more_vert,
                            //       color: MyColors.mainTheme,
                            //     ),
                            //   ),
                            // ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.invoicePrintScreen,
                                    arguments: inVoiceController
                                        .invoiceModelList[index]);
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('SubTotal',
                                    style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: MyColors.black)),
                                const SizedBox(height: 10),
                                Text(
                                    "\$ ${inVoiceController.invoiceModelList[index].subTotal!.toStringAsFixed(2)}" ??
                                        "0",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: MyColors.mainTheme)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Tax',
                                    style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: MyColors.black)),
                                const SizedBox(height: 10),
                                Text(
                                    "\$ ${inVoiceController.invoiceModelList[index].tax!.toStringAsFixed(2)}" ??
                                        "0",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: MyColors.mainTheme)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Net Total',
                                    style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: MyColors.black)),
                                const SizedBox(height: 10),
                                Text(
                                    "\$ ${inVoiceController.invoiceModelList[index].netTotal!.toStringAsFixed(2)}" ??
                                        "0",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: MyColors.mainTheme)),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Balance',
                                    style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: MyColors.black)),
                                const SizedBox(height: 10),
                                Text("\$ $amount",
                                    style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: MyColors.mainTheme)),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ));
    }
  }
}
