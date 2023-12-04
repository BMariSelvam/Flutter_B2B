import 'package:b2b/View/Order/Order_controller.dart';
import 'package:b2b/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Helper/colors.dart';
import '../../Helper/fonts.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late OrderController orderController;

  @override
  void initState() {
    orderController = Get.put(OrderController());
    orderController.getOrderList();
    super.initState();
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      orderController = Get.put(OrderController());
      orderController.getOrderList();
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (logic) {
      return Scaffold(
        backgroundColor: MyColors.grey,
        appBar: AppBar(
          backgroundColor: MyColors.mainTheme,
          leading: IconButton(
            onPressed: () {
              Get.offAndToNamed(
                AppRoutes.bottomNavBar0,
              );
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          iconTheme: const IconThemeData(color: MyColors.white),
          title: Text(
            'Order',
            style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.bold,
                color: MyColors.white),
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: Stack(
            children: [
              orderList(),
              if (orderController.status.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      );
    });
  }

  orderList() {
    if (orderController.ordersModelList.isNotEmpty) {
      return Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: orderController.ordersModelList.length,
              itemBuilder: (context, index) {
                DateTime dateTime = DateFormat("yyyy-MM-dd").parse(
                    orderController.ordersModelList[index].tranDate
                            .toString() ??
                        "");
                String date = DateFormat("dd-MM-yyyy").format(dateTime);

                var status = orderController.ordersModelList[index].status;

                String statusName = "";
                if (status == 0) {
                  statusName = "open";
                } else if (status == 1) {
                  statusName = "Delivered";
                } else if (status == 2) {
                  statusName = "Return";
                } else {
                  statusName = "Canceled";
                }

                return Container(
                  padding: const EdgeInsets.only(
                    top: 2,
                  ),
                  child: Card(
                    elevation: 5,
                    shadowColor: MyColors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Date : ',
                                    style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: MyColors.black)),
                                TextSpan(
                                    text: date,
                                    style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: MyColors.mainTheme)),
                              ])),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, top: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Total : ',
                                        style: TextStyle(
                                            fontFamily: MyFont.myFont,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: MyColors.black),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "\$ ${orderController.ordersModelList[index].netTotal!.toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: MyColors.mainTheme),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: 'Order No : ',
                                                style: TextStyle(
                                                    fontFamily: MyFont.myFont,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: MyColors.black)),
                                            TextSpan(
                                                text: orderController
                                                    .ordersModelList[index]
                                                    .tranNo
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily: MyFont.myFont,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: MyColors.mainTheme)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(right: 10, top: 10),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Card(
                                      color: (status == 0)
                                          ? MyColors.org
                                          : (status == 1)
                                              ? MyColors.green
                                              : (status == 2)
                                                  ? MyColors.red
                                                  : Colors.grey,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Text(
                                          statusName,
                                          textAlign: TextAlign.center,
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
                              )
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // controller.getOrderPreviewList(controller
                              //     .ordersModelList[index].tranNo);
                              Get.toNamed(
                                AppRoutes.orderInvoiceScreen,
                                arguments:
                                    orderController.ordersModelList[index],
                              );
                            },
                            child: Text(
                              'View Order',
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
      if (orderController.status.isLoadingMore ||
          orderController.status.isLoading) {
        return Container(
            child: const Center(
          child: Text("No Order found"),
        ));
      }
      const Center(
        child: Text("No Order found"),
      );
    }
  }
}
