import 'package:b2b/Helper/size.dart';
import 'package:b2b/Model/OrderModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Helper/colors.dart';
import '../../../Helper/fonts.dart';
import 'orderPrintScreenController.dart';

class OrderInvoiceScreen extends StatefulWidget {
  const OrderInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<OrderInvoiceScreen> createState() => _OrderInvoiceScreenState();
}

class _OrderInvoiceScreenState extends State<OrderInvoiceScreen> {
  late OrderModel selectedItems;

  late OrderPrintController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(OrderPrintController());
    selectedItems = Get.arguments as OrderModel;
    controller.getOrderPreviewList(selectedItems.tranNo);
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime =
        DateFormat("yyyy-MM-dd").parse(selectedItems.tranDate.toString());
    String date = DateFormat("dd-MM-yyyy").format(dateTime);
    return GetBuilder<OrderPrintController>(builder: (logic) {
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
          title: Text(
            'Sales Order',
            style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.bold,
                color: MyColors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: width(context) / 5.5,
                          child: Text("Date :",
                              style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: MyColors.black)),
                        ),
                        Text("  ${date}",
                            style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: MyColors.mainTheme))
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        SizedBox(
                          width: width(context) / 5.5,
                          child: Text("Order No :",
                              style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: MyColors.black)),
                        ),
                        Text("  ${selectedItems.tranNo}",
                            style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: MyColors.mainTheme))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Name :  ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: MyFont.myFont,
                      fontSize: 15,
                    ),
                  ),
                  Text("${selectedItems.customerName}",
                      style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: MyColors.mainTheme)),
                ],
              )),
              (selectedItems.addressLine1 != null)
                  ? Center(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Address :  ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: MyFont.myFont,
                            fontSize: 15,
                          ),
                        ),
                        Text("${selectedItems.addressLine1}",
                            style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: MyColors.mainTheme)),
                      ],
                    ))
                  : Container(),
              const SizedBox(height: 5),
              orderList(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(height: height(context) / 50),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       'Order Summary',
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontFamily: MyFont.myFont,
                    //         fontSize: 15,
                    //       ),
                    //     ),
                    //     Text(
                    //       "Product Selected ( ${totalcount.toStringAsFixed(
                    //           0)} )",
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontFamily: MyFont.myFont,
                    //         fontSize: 15,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: height(context) / 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sub Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: MyFont.myFont,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '\$ ${selectedItems.subTotal?.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: MyFont.myFont,
                            fontSize: 15,
                            color: MyColors.mainTheme,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height(context) / 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tax',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: MyFont.myFont,
                            fontSize: 15,
                          ),
                        ),
                        StatefulBuilder(builder: (context, setState) {
                          return Text(
                            '\$ ${selectedItems.tax?.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: MyFont.myFont,
                                fontSize: 15,
                                color: MyColors.mainTheme),
                          );
                        }),
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
                          'Grand Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: MyFont.myFont,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '\$ ${selectedItems.netTotal?.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: MyFont.myFont,
                              fontSize: 15,
                              color: MyColors.mainTheme),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 18),
          child: ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: MyColors.mainTheme),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Download  ',
                  style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      color: MyColors.white),
                ),
                const Icon(Icons.print),
              ],
            ),
          ),
        ),
      );
    });
  }

  //  orderList() {
  //   print("lengthsanthosh");
  //   print(controller.ordersModelList.first.salesOrderDetail?.length);
  //   return ListView.builder(
  //       itemCount: controller.ordersModelList.first.salesOrderDetail?.length ?? 0,
  //       physics: const NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       itemBuilder: (context, index) {
  //         print("salesOrderDetail");
  //         print(controller.ordersModelList.first.salesOrderDetail?[index].productName);
  //         return Padding(
  //           padding: const EdgeInsets.all(5),
  //           child: Card(
  //             elevation: 10,
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(15)),
  //             child: Column(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(left: 10),
  //                   child: Row(
  //                     children: [
  //                       // Padding(
  //                       //   padding: const EdgeInsets.only(
  //                       //       top: 8, bottom: 8, right: 8, left: 8),
  //                       //   child: Container(
  //                       //     height: height(context) / 10,
  //                       //     width: width(context) / 5,
  //                       //   ),
  //                       //   // child: Container(
  //                       //   //   height: height(context) / 10,
  //                       //   //   width: width(context) / 5,
  //                       //   //   decoration: BoxDecoration(
  //                       //   //     borderRadius: BorderRadius.circular(10.0),
  //                       //   //     color: MyColors.grey,
  //                       //   //   ),
  //                       //   //   child: selectedItems2[index].remarks != null
  //                       //   //       ? ("${selectedItems2[index].remarks}".isNotEmpty)
  //                       //   //           ? Image.network(
  //                       //   //               '${selectedItems2[index].remarks}',
  //                       //   //               fit: BoxFit.fill)
  //                       //   //           : Image.asset(Assets.noImage)
  //                       //   //       : const Icon(Icons.error),
  //                       //   // ),
  //                       // ),
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Container(
  //                             padding: const EdgeInsets.only(
  //                               top: 20,
  //                             ),
  //                             width: width(context) / 1.5,
  //                             child: Text(
  //                               "${controller.ordersModelList.first.salesOrderDetail?[index].productName}",
  //                               style: TextStyle(
  //                                 fontFamily: MyFont.myFont,
  //                                 fontWeight: FontWeight.w600,
  //                                 fontSize: 14,
  //                               ),
  //                             ),
  //                           ),
  //                           SizedBox(height: height(context) / 80),
  //                           Padding(
  //                             padding: const EdgeInsets.only(right: 24),
  //                             child: Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceEvenly,
  //                               children: [
  //                                 Row(
  //                                   mainAxisAlignment:
  //                                       MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Text(
  //                                       'qty :',
  //                                       style: TextStyle(
  //                                           fontFamily: MyFont.myFont,
  //                                           fontWeight: FontWeight.bold,
  //                                           fontSize: 12,
  //                                           color: MyColors.greyText),
  //                                     ),
  //                                     Text(
  //                                       "${controller.ordersModelList.first.salesOrderDetail?[index].qty} x ${controller.ordersModelList.first.salesOrderDetail?[index].total}",
  //                                       //     .toString(),
  //                                       style: TextStyle(
  //                                           fontFamily: MyFont.myFont,
  //                                           fontWeight: FontWeight.bold,
  //                                           fontSize: 14,
  //                                           color: MyColors.mainTheme),
  //                                     ),
  //                                     SizedBox(width: width(context) / 2.7),
  //                                     Text(
  //                                       'Total : ',
  //                                       style: TextStyle(
  //                                           fontFamily: MyFont.myFont,
  //                                           fontWeight: FontWeight.bold,
  //                                           fontSize: 12,
  //                                           color: MyColors.greyText),
  //                                     ),
  //                                     Text(
  //                                       "${controller.ordersModelList.first.salesOrderDetail?[index].total}",
  //                                       //     .toString(),
  //                                       style: TextStyle(
  //                                           fontFamily: MyFont.myFont,
  //                                           fontWeight: FontWeight.bold,
  //                                           fontSize: 14,
  //                                           color: MyColors.mainTheme),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           SizedBox(height: height(context) / 80),
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 ),
  //                 SizedBox(height: height(context) / 50),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  orderList() {
    print(" .length===========");
    print( controller.ordersModelList.first.salesOrderDetail!.length );
    return ListView.builder(
        itemCount:
        controller.ordersModelList.first.salesOrderDetail!.length ?? 0,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       top: 8, bottom: 8, right: 8, left: 8),
                        //   child: Container(
                        //     height: height(context) / 10,
                        //     width: width(context) / 5,
                        //   ),
                        //   // child: Container(
                        //   //   height: height(context) / 10,
                        //   //   width: width(context) / 5,
                        //   //   decoration: BoxDecoration(
                        //   //     borderRadius: BorderRadius.circular(10.0),
                        //   //     color: MyColors.grey,
                        //   //   ),
                        //   //   child: selectedItems2[index].remarks != null
                        //   //       ? ("${selectedItems2[index].remarks}".isNotEmpty)
                        //   //           ? Image.network(
                        //   //               '${selectedItems2[index].remarks}',
                        //   //               fit: BoxFit.fill)
                        //   //           : Image.asset(Assets.noImage)
                        //   //       : const Icon(Icons.error),
                        //   // ),
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                top: 20,
                              ),
                              width: width(context) / 1.5,
                              child: Text(
                                "${controller.ordersModelList.first.salesOrderDetail?[index].productName}",
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(height: height(context) / 50),
                            SizedBox(
                              width: width(context) / 1.4,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Qty : ',
                                          style: TextStyle(
                                              fontFamily: MyFont.myFont,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: MyColors.greyText),
                                        ),
                                        Text(
                                          controller
                                              .ordersModelList
                                              .first
                                              .salesOrderDetail?[
                                          index]
                                              .isWeight ==
                                              true
                                              ? "${controller.ordersModelList.first.salesOrderDetail?[index].weight} x \$ ${controller.ordersModelList.first.salesOrderDetail?[index].price?.toStringAsFixed(2)}"
                                              : "${controller.ordersModelList.first.salesOrderDetail?[index].qty} x \$ ${controller.ordersModelList.first.salesOrderDetail?[index].price?.toStringAsFixed(2)}",
                                          //     .toString(),
                                          style: TextStyle(
                                              fontFamily: MyFont.myFont,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: MyColors.mainTheme),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Total : ',
                                          style: TextStyle(
                                              fontFamily: MyFont.myFont,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: MyColors.greyText),
                                        ),
                                        Text(
                                          "\$ ${controller.ordersModelList.first.salesOrderDetail?[index].total?.toStringAsFixed(2)}",
                                          //     .toString(),
                                          style: TextStyle(
                                              fontFamily: MyFont.myFont,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: MyColors.mainTheme),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height(context) / 80),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height(context) / 50),
                ],
              ),
            ),
          );
        });
  }
}
