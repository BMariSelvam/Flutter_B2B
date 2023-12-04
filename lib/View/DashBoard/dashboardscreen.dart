import 'package:b2b/View/InVoice/invoicescreen.dart';
import 'package:b2b/View/Payment/paymentscreen.dart';
import 'package:b2b/View/Widget/bottomnavbar.dart';
import 'package:b2b/approute.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Helper/assets.dart';
import '../../Helper/colors.dart';
import '../../Helper/fonts.dart';
import '../../Helper/size.dart';
import 'dashboardcontroller.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late DashBoardController dashBoardController;

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    dashBoardController = Get.put(DashBoardController());
    dashBoardController.bannerGet();
    dashBoardController.getOrderList();
    dashBoardController.getPaymentList();
    dashBoardController.getInvoiceList();
    dashBoardController.getCustomerDashBoard();
  }
  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      dashBoardController = Get.put(DashBoardController());
      dashBoardController.bannerGet();
      dashBoardController.getOrderList();
      dashBoardController.getPaymentList();
      dashBoardController.getInvoiceList();
      dashBoardController.getCustomerDashBoard();
    });
  }

  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (logic) {
      if (logic.isLoading.value == true) {
        const Center(
          child: CircularProgressIndicator(),
        );
      }
      return WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Do you want to go exit?'),
                actionsAlignment: MainAxisAlignment.spaceAround,
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context, true);
                      });
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                        // Get.offAndToNamed(AppRoutes.bottomNavBar0);
                      });
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(color: MyColors.white),
            title: Text(
              'DashBoard',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: MyFont.myFont,
              ),
            ),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh:  _refreshData,
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(Assets.bannerCard)),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Payments',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: MyFont.myFont,
                                                fontSize: 15,
                                                color: MyColors.white),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            '\$ ${dashBoardController.receiptTotal.toStringAsFixed(2)}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: MyFont.myFont,
                                                fontSize: 15,
                                                color: MyColors.white),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Total OutStanding',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: MyFont.myFont,
                                                fontSize: 15,
                                                color: MyColors.white),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            '\$ ${dashBoardController.outStandingTotal.toStringAsFixed(2)}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: MyFont.myFont,
                                                fontSize: 15,
                                                color: MyColors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'This Week',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: MyFont.myFont,
                                        fontSize: 15,
                                        color: MyColors.white),
                                  ),
                                  Image.asset(Assets.graphLine)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height(context) / 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BottomNavBar(
                                      intex: 2,
                                    ),
                                  ));
                            },
                            child: SizedBox(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Order Details',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: MyFont.myFont,
                                                    fontSize: 12,
                                                    color:
                                                        MyColors.orderDetailText),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                '\$ ${dashBoardController.salesOrderTotal.toStringAsFixed(2)}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: MyFont.myFont,
                                                    fontSize: 15,
                                                    color: MyColors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child:
                                                Image.asset(Assets.orderDetails))
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: MyColors.grey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        'View Details',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: MyFont.myFont,
                                            fontSize: 12,
                                            color: MyColors.orderDetailText),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const InvoiceScreen(),
                                  ));
                            },
                            child: SizedBox(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Invoice Details',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: MyFont.myFont,
                                                    fontSize: 12,
                                                    color: MyColors.mainTheme),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                '\$ ${dashBoardController.invoiceTotal.toStringAsFixed(2)}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: MyFont.myFont,
                                                    fontSize: 15,
                                                    color: MyColors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: Image.asset(
                                                Assets.invoiceDetails))
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: MyColors.grey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        'View Details',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: MyFont.myFont,
                                            fontSize: 12,
                                            color: MyColors.mainTheme),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height(context) / 50),
                      (dashBoardController.bannerImageList.isNotEmpty)
                          ? Column(
                              children: [
                                SizedBox(
                                  height: height(context) / 6,
                                  width: double.infinity,
                                  child: CarouselSlider.builder(
                                    itemCount: dashBoardController
                                        .bannerImageList.length,
                                    itemBuilder: (context, itemIndex, realIndex) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: SizedBox(
                                            width: width(context),
                                            child: Image.network(
                                              dashBoardController
                                                  .bannerImageList[itemIndex]
                                                  .bannerImageFilePath
                                                  .toString(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    carouselController: carouselController,
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      aspectRatio: 1,
                                      viewportFraction: 1,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          currentIndex = index;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: height(context) / 90),
                              ],
                            )
                          : Container(
                              color: MyColors.white,
                            ),
                      SizedBox(height: height(context) / 90),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: dashBoardController.bannerImageList
                            .asMap()
                            .entries
                            .map((entry) {
                          return GestureDetector(
                            onTap: () =>
                                carouselController.animateToPage(entry.key),
                            child: Container(
                              width: currentIndex == entry.key ? 20 : 5,
                              height: 4.0,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 2.0,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: currentIndex == entry.key
                                      ? MyColors.mainTheme
                                      : MyColors.greyText),
                            ),
                          );
                        }).toList(),
                      ),

                      // ),
                      // Center(
                      //         child: Text("No Order found"),
                      //       ),
                      SizedBox(height: height(context) / 100),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Recent Transactions',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: MyFont.myFont,
                                      fontSize: 14,
                                      color: MyColors.mainTheme),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: MyColors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButtonHideUnderline(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: DropdownButton<String>(
                                          value:
                                              dashBoardController.dropDownValue,
                                          items: const <DropdownMenuItem<String>>[
                                            DropdownMenuItem<String>(
                                              value: 'index 0',
                                              child: Text(
                                                'Order',
                                              ),
                                            ),
                                            DropdownMenuItem<String>(
                                              value: 'index 1',
                                              child: Text(
                                                'Invoice',
                                              ),
                                            ),
                                            DropdownMenuItem<String>(
                                              value: 'index 2',
                                              child: Text(
                                                'Payment',
                                              ),
                                            ),
                                          ],
                                          onChanged: (String? val) {
                                            setState(() {
                                              dashBoardController.dropDownValue =
                                                  val!;
                                            });
                                          },
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: height(context) / 50),
                          if (dashBoardController.dropDownValue == 'index 0')
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: MyColors.mainTheme),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: width(context) / 3.5,
                                        child: Text('Order No',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: MyFont.myFont,
                                                fontSize: 13,
                                                color: MyColors.white)),
                                      ),
                                      Container(
                                        width: width(context) / 3.5,
                                        child: Text('Date',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: MyFont.myFont,
                                                fontSize: 13,
                                                color: MyColors.white)),
                                      ),
                                      Container(
                                        width: width(context) / 3.5,
                                        child: Text(
                                          'Amount',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: MyFont.myFont,
                                              fontSize: 13,
                                              color: MyColors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                recentOrderItemsListViewBuilder(),
                                (dashBoardController.ordersModelList.length >= 5)
                                    ? TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BottomNavBar(
                                                  intex: 2,
                                                ),
                                              ));
                                        },
                                        child: Text(
                                          'View All',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: MyFont.myFont,
                                              fontSize: 12,
                                              color: MyColors.mainTheme),
                                        ))
                                    : Container()
                                // Container(
                                //   decoration: const BoxDecoration(
                                //       // borderRadius: BorderRadius.circular(5.0),
                                //       border: Border(
                                //           right: BorderSide(color: MyColors.grey),
                                //           left: BorderSide(color: MyColors.grey))),
                                //   //border: Border.all(color: MyColors.gray)),
                                //   child: ListView.builder(
                                //       shrinkWrap: true,
                                //       physics: const NeverScrollableScrollPhysics(),
                                //       itemCount: showMore ? items.length : 5,
                                //       // itemCount: showMore ? 10 : 5,
                                //       itemBuilder: (context, index) {
                                //         return Column(
                                //           children: [
                                //             Padding(
                                //               padding: const EdgeInsets.all(5.0),
                                //               child: Row(
                                //                 children: [
                                //                   SizedBox(
                                //                     width: width(context) / 15,
                                //                     child: Text(
                                //                       '${controller.serial++}',
                                //                       style: TextStyle(
                                //                           fontWeight: FontWeight.bold,
                                //                           fontFamily: MyFont.myFont,
                                //                           fontSize: 12,
                                //                           color: MyColors.black),
                                //                     ),
                                //                   ),
                                //                   SizedBox(
                                //                     width: width(context) / 4.5,
                                //                     child: Text('IN22-2253',
                                //                         textAlign: TextAlign.center,
                                //                         style: TextStyle(
                                //                             fontWeight: FontWeight.bold,
                                //                             fontFamily: MyFont.myFont,
                                //                             fontSize: 12,
                                //                             color: MyColors.black)),
                                //                   ),
                                //                   SizedBox(
                                //                     width: width(context) / 5,
                                //                     child: Text(
                                //                       '29/05/23',
                                //                       textAlign: TextAlign.center,
                                //                       style: TextStyle(
                                //                           fontWeight: FontWeight.bold,
                                //                           fontFamily: MyFont.myFont,
                                //                           fontSize: 12,
                                //                           color: MyColors.black),
                                //                     ),
                                //                   ),
                                //                   SizedBox(
                                //                     width: width(context) / 4.5,
                                //                     child: Text('Card',
                                //                         textAlign: TextAlign.center,
                                //                         style: TextStyle(
                                //                             fontWeight: FontWeight.bold,
                                //                             fontFamily: MyFont.myFont,
                                //                             fontSize: 12,
                                //                             color: MyColors.black)),
                                //                   ),
                                //                   SizedBox(
                                //                     child: Text('\$200.00',
                                //                         textAlign: TextAlign.center,
                                //                         overflow: TextOverflow.ellipsis,
                                //                         style: TextStyle(
                                //                             fontWeight: FontWeight.bold,
                                //                             fontFamily: MyFont.myFont,
                                //                             fontSize: 12,
                                //                             color: MyColors.black)),
                                //                   )
                                //                 ],
                                //               ),
                                //             ),
                                //             const Divider(
                                //               thickness: 1,
                                //             ),
                                //           ],
                                //         );
                                //       }),
                                // ),
                                // TextButton(
                                //     onPressed: () {
                                //
                                //         showMore = !showMore;
                                //
                                //     },
                                //     child: showMore
                                //         ? Text(
                                //             'View Less',
                                //             style: TextStyle(
                                //                 fontWeight: FontWeight.bold,
                                //                 fontFamily: MyFont.myFont,
                                //                 fontSize: 12,
                                //                 color: MyColors.mainTheme),
                                //           )
                                //         : Text(
                                //             'View All',
                                //             style: TextStyle(
                                //                 fontWeight: FontWeight.bold,
                                //                 fontFamily: MyFont.myFont,
                                //                 fontSize: 12,
                                //                 color: MyColors.mainTheme),
                                //           ))
                              ],
                            ),
                          if (dashBoardController.dropDownValue == 'index 1')
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 15,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: MyColors.mainTheme),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: width(context) / 3.5,
                                        child: Text('Invoice No',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: MyFont.myFont,
                                                fontSize: 13,
                                                color: MyColors.white)),
                                      ),
                                      Container(
                                        width: width(context) / 3.5,
                                        child: Text('Date',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: MyFont.myFont,
                                                fontSize: 13,
                                                color: MyColors.white)),
                                      ),
                                      Container(
                                        width: width(context) / 3.5,
                                        child: Text(
                                          'Amount',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: MyFont.myFont,
                                              fontSize: 13,
                                              color: MyColors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                recentInvoiceItemsListViewBuilder(),
                                dashBoardController.InvoiceModelList.length >= 5
                                    ? TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const InvoiceScreen(),
                                              ));
                                        },
                                        child: Text(
                                          'View All',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: MyFont.myFont,
                                              fontSize: 12,
                                              color: MyColors.mainTheme),
                                        ))
                                    : Container(),
                              ],
                            ),
                          if (dashBoardController.dropDownValue == 'index 2')
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 15,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: MyColors.mainTheme),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: width(context) / 4,
                                        child: Text('Payment No',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: MyFont.myFont,
                                                fontSize: 13,
                                                color: MyColors.white)),
                                      ),
                                      Container(
                                        width: width(context) / 5,
                                        child: Text('Date',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: MyFont.myFont,
                                                fontSize: 13,
                                                color: MyColors.white)),
                                      ),
                                      Container(
                                        width: width(context) / 5,
                                        child: Text(
                                          'Payment',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: MyFont.myFont,
                                              fontSize: 13,
                                              color: MyColors.white),
                                        ),
                                      ),
                                      Container(
                                        width: width(context) / 5,
                                        child: Text(
                                          'Amount',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: MyFont.myFont,
                                              fontSize: 13,
                                              color: MyColors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                recentPaymentItemsListViewBuilder(),
                                dashBoardController.PaymentModelList.length >= 5
                                    ? TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const PaymentScreen(),
                                              ));
                                        },
                                        child: Text(
                                          'View All',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: MyFont.myFont,
                                              fontSize: 12,
                                              color: MyColors.mainTheme),
                                        ))
                                    : Container(),
                              ],
                            ),
                        ],
                      ),
                      SizedBox(height: height(context) / 50),
                      // orderList()
                    ],
                  ),
                ),
                if (logic.isLoading.value == true)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            ),
          ),
        ),
      );
    });
  }

  recentOrderItemsListViewBuilder() {
    return GetBuilder<DashBoardController>(builder: (logic) {
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
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (dashBoardController.ordersModelList.length > 5)
            ? 5
            : dashBoardController.ordersModelList.length,
        itemBuilder: (context, index) {
          DateTime dateTime = DateFormat("yyyy-MM-dd").parse(
              dashBoardController.ordersModelList[index].tranDate.toString());
          String date = DateFormat("dd-MM-yyyy").format(dateTime);
          return GestureDetector(
            onTap: () {
              Get.toNamed(
                AppRoutes.orderInvoiceScreen,
                arguments: dashBoardController.ordersModelList[index],
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                  color: index.isEven ? MyColors.white : MyColors.grey,
                  border: Border.all(color: MyColors.grey)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width(context) / 4,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height(context) / 180,
                          ),
                          Text(
                            dashBoardController.ordersModelList[index].tranNo
                                .toString(),
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: MyColors.black),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: width(context) / 4,
                      child: Text(
                        date,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: MyColors.black),
                      ),
                    ),
                    Container(
                      width: width(context) / 4,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height(context) / 180,
                          ),
                          Text(
                            dashBoardController.ordersModelList[index].netTotal!
                                .toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: MyColors.black),
                          ),
                        ],
                      ),
                    ),
                    // dashBoardController.ordersModelList[index].total.toString(),
                  ]),
            ),
          );
        },
      );
    });
  }

  recentInvoiceItemsListViewBuilder() {
    return GetBuilder<DashBoardController>(builder: (logic) {
      if (logic.isLoading.value == true) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (dashBoardController.InvoiceModelList.length > 5)
            ? 5
            : dashBoardController.InvoiceModelList.length,
        itemBuilder: (context, index) {
          DateTime dateTime = DateFormat("yyyy-MM-dd").parse(
              dashBoardController.InvoiceModelList[index].tranDate.toString());
          String date = DateFormat("dd-MM-yyyy").format(dateTime);
          return GestureDetector(
            onTap: () {
              Get.toNamed(
                AppRoutes.invoicePrintScreen,
                arguments: dashBoardController.InvoiceModelList[index],
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                  color: index.isEven ? MyColors.white : MyColors.grey,
                  border: Border.all(color: MyColors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: width(context) / 4,
                    child: Column(
                      children: [
                        Text(
                          "Tran No: ",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: MyColors.black),
                        ),
                        SizedBox(
                          height: height(context) / 300,
                        ),
                        Text(
                          dashBoardController.InvoiceModelList[index].tranNo
                              .toString(),
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: MyColors.black),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: width(context) / 4,
                    child: Text(
                      date,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: MyColors.black),
                    ),
                  ),
                  Container(
                    width: width(context) / 4,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height(context) / 300,
                        ),
                        Text(
                          dashBoardController.InvoiceModelList[index].netTotal
                              .toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: MyColors.black),
                        ),
                      ],
                    ),
                  ),
                  // dashBoardController.ordersModelList[index].total.toString(),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  recentPaymentItemsListViewBuilder() {
    return GetBuilder<DashBoardController>(builder: (logic) {
      if (logic.isLoading.value == true) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dashBoardController.PaymentModelList.length > 5
            ? 5
            : dashBoardController.PaymentModelList.length,
        itemBuilder: (context, index) {
          DateTime dateTime = DateFormat("yyyy-MM-dd").parse(
              dashBoardController.PaymentModelList[index].tranDate.toString());
          String date = DateFormat("dd-MM-yyyy").format(dateTime);
          return GestureDetector(
            onTap: () {
              Get.toNamed(
                AppRoutes.paymentInvoiceScreen,
                arguments: dashBoardController.PaymentModelList[index],
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                  color: index.isEven ? MyColors.white : MyColors.grey,
                  border: Border.all(color: MyColors.grey)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: width(context) / 4,
                      child: Column(
                        children: [
                          Text(
                            "Tran No : ",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: MyColors.black),
                          ),
                          SizedBox(
                            height: height(context) / 300,
                          ),
                          Text(
                            dashBoardController.PaymentModelList[index].tranNo
                                .toString(),
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: MyColors.black),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: width(context) / 5,
                      child: Text(
                        date,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: MyColors.black),
                      ),
                    ),

                    Container(
                      width: width(context) / 5,
                      child: Text(
                        dashBoardController.PaymentModelList[index].payMode
                            .toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: MyColors.black),
                      ),
                    ),

                    Container(
                      width: width(context) / 5,
                      child: Column(
                        children: [
                          Text(
                            dashBoardController
                                .PaymentModelList[index].paidAmount
                                .toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: MyColors.black),
                          ),
                        ],
                      ),
                    ),

                    // dashBoardController.ordersModelList[index].total.toString(),
                  ]),
            ),
          );
        },
      );
    });
  }
}
