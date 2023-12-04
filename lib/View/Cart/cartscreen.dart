// ignore_for_file: unrelated_type_equality_checks

import 'package:b2b/Helper/preferenceHelper.dart';
import 'package:b2b/Helper/valitation.dart';
import 'package:b2b/Model/ProductModel1.dart';
import 'package:b2b/Model/login_model1.dart';
import 'package:b2b/Model/sales_order/sales_order_detail.dart';
import 'package:b2b/View/Widget/Hero.dart';
import 'package:b2b/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/assets.dart';
import '../../Helper/colors.dart';
import '../../Helper/fonts.dart';
import '../../Helper/size.dart';
import '../../Model/sales_order/sales_order.dart';
import '../Product/productcontroller.dart';
import 'cartcontroller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  LoginUser? loginUser;

  String currentDate = DateTime.now().toString();
  late CartController controller;

  // late ProductController productController;
  List<Product> productList = [];

  double taxValue = 0;
  double boxtotal = 0;
  double unittotal = 0;
  double weightTotal = 0;
  double qtytotal = 0;
  double subtotal = 0;
  double total = 0;
  double tax = 0;
  double totalcount = 0;
  double GrandTotal = 0;
  int slNo = 0;

  getUserData() async {
    loginUser = await PreferenceHelper.getUserData();
  }

  @override
  initState() {
    super.initState();
    controller = Get.put(CartController());
    ProductController productController = Get.put(ProductController());
    productList = productController.cartAddedProduct.value;
    getUserData();
    print(productList.first.name);
    print(productList.first.weight);
    print(productList.length);
    controller.cartService.cartChangeStream.listen((_) {
      setState(() {});
    });
    controller.getTaxDetails().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double taxValue = 0;
    double boxtotal = 0;
    double unittotal = 0;
    double subtotal = 0;
    double total = 0;
    double totalcount = 0;
    double grandTotal = 0;
    bool? isWet = false;
    for (var element in productList) {
      isWet = element.isWeight;
      if (isWet == false) {
        unittotal += element.unitcount * element.sellingCost!;
        boxtotal += element.boxcount * element.sellingBoxCost!;
        subtotal = unittotal + boxtotal;
        totalcount +=
            element.unitcount + (element.pcsPerCarton! * element.boxcount);
      } else {
        unittotal += element.weightCount * element.sellingCost!;
        subtotal = unittotal;
        totalcount += element.weightCount;
      }
      taxValue = (subtotal * controller.taxpercentage) / 100;
      if (controller.taxName == "Inclusive") {
        grandTotal = subtotal;
      } else if (controller.taxName == "Exclusive") {
        grandTotal = subtotal + taxValue;
      } else if (controller.taxName == "GSTs") {
        grandTotal = subtotal + taxValue;
      } else {
        grandTotal = subtotal + taxValue;
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.mainTheme,
        elevation: 0,
        iconTheme: const IconThemeData(color: MyColors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Cart',
          style: TextStyle(
            fontFamily: MyFont.myFont,
            fontWeight: FontWeight.bold,
            color: MyColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            SizedBox(
              width: width(context),
              child: orderList(),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: height(context) / 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order Summary',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: MyFont.myFont,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Product Selected (${totalcount.toStringAsFixed(0)})",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: MyFont.myFont,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
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
                        '\$${subtotal.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: MyFont.myFont,
                          fontSize: 15,
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
                      Text(
                        '\$${taxValue.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: MyFont.myFont,
                          fontSize: 15,
                        ),
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
                        'Grand Total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: MyFont.myFont,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '\$${grandTotal.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: MyFont.myFont,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height(context) / 40),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: MyColors.mainTheme),
          onPressed: () async {
            if (
            productList.first.weightCount == 0 &&
                productList.first.unitcount == 0 &&
                productList.first.boxCount == 0

            ) {
              showbarBottom();
              productList.clear();
              Get.offAndToNamed(AppRoutes.bottomNavBar1);
            } else {
              controller.salesOrder = SalesOrder(
                orgId: 1,
                tranNo: "",
                tranDate: currentDate,
                customerId: loginUser?.code,
                customerName: loginUser?.name,
                customerAddress: "",
                locationCode: "HO",
                taxCode: loginUser?.taxTypeId,
                taxType: "E",
                taxPerc: controller.taxpercentage,
                currencyCode: loginUser?.currencyId,
                currencyRate: 1,
                total: total.toInt(),
                discount: 0,
                discountPerc: 0,
                subTotal: subtotal,
                //total-discount
                tax: taxValue,
                netTotal: grandTotal,
                fTotal: 0,
                fDiscount: 0,
                fSubTotal: 0,
                fTax: 0,
                fNetTotal: 0,
                referenceNo: "",
                remarks: "",
                createdFrom: "b2b",
                isActive: true,
                createdBy: loginUser?.countryId,
                createdOn: '2023-06-21',
                changedBy: "admin",
                changedOn: '2023-06-21',
                assignTo: "",
                tranDateString: "",
                status: 0,
                isUpdate: true,
                customerShipToId: 0,
                customerShipToAddress: "",
                priceSettingCode: loginUser?.priceSettings,
                termCode: loginUser?.paymentTerms,
                invoiceType: true,
                latitude: 0,
                longitude: 0,
                signatureimage: "",
                cameraimage: "",
                summaryRemarks: "",
                addressLine1: "",
                salesOrderDetail: productList
                    .map((e) =>
                    SalesOrderDetail(
                        orgId: 1,
                        tranNo: "",
                        slNo: e.slNO,
                        productCode: e.productCode,
                        productName: e.productName,
                        boxCount: (e.boxCount != null) ? e.boxCount : 0,
                        pcsQty: e.unitcount,
                        qty: e.unitcount +
                            (e.boxcount * e.pcsPerCarton!).toInt(),
                        foc: 0,
                        exchange: 0,
                        boxPrice: e.sellingBoxCost,
                        price: e.sellingCost!.toInt(),
                        total: e.isWeight == true ? (e.weightCount *
                            e.sellingCost!) : (e.unitcount * e.sellingCost!) +
                            (e.boxcount * e.sellingBoxCost!),
                        itemDiscount: 0,
                        itemDiscountPerc: 0,
                        subTotal: e.isWeight == true ? (e.weightCount *
                            e.sellingCost!) : (e.unitcount * e.sellingCost!) +
                            (e.boxcount * e.sellingBoxCost!),
                        tax: ((e.isWeight == true ? (e.weightCount * e
                            .sellingCost!) : (e.unitcount * e.sellingCost!) +
                            (e.boxcount * e.sellingBoxCost!)) *
                            controller.taxpercentage.toDouble() /
                            100),
                        netTotal: ((e.isWeight == true ? (e.weightCount *
                            e.sellingCost!) : (e.unitcount * e.sellingCost!) +
                            (e.boxcount * e.sellingBoxCost!)) *
                            controller.taxpercentage.toDouble() /
                            100) +
                            (e.isWeight == true ? (e.weightCount *
                                e.sellingCost!) : (e.unitcount * e
                                .sellingCost!) +
                                (e.boxcount * e.sellingBoxCost!)),
                        fPrice: e.sellingCost,
                        fBoxPrice: e.sellingBoxCost,
                        fTotal: e.isWeight == true ? (e.weightCount *
                            e.sellingCost!) : (e.unitcount * e.sellingCost!) +
                            (e.boxcount * e.sellingBoxCost!),
                        fTax: ((e.isWeight == true ? (e.weightCount * e
                            .sellingCost!) : (e.unitcount * e.sellingCost!) +
                            (e.boxcount * e.sellingBoxCost!)) *
                            controller.taxpercentage.toDouble() /
                            100),
                        fNetTotal: ((e.isWeight == true ? (e.weightCount *
                            e.sellingCost!) : (e.unitcount * e.sellingCost!) +
                            (e.boxcount * e.sellingBoxCost!)) *
                            controller.taxpercentage.toDouble() /
                            100) +
                            (e.isWeight == true ? (e.weightCount *
                                e.sellingCost!) : (e.unitcount * e
                                .sellingCost!) +
                                (e.boxcount * e.sellingBoxCost!)),
                        createdBy: "Admin",
                        createdOn: '2023-06-21',
                        changedBy: "Admin",
                        changedOn: '2023-06-21',
                        stockQty: 0,
                        stockBoxQty: 0,
                        weight: e.weightCount,
                        isWeight: e.isWeight,
                        remarks: e.productImagePath,
                        boxQty: (e.boxcount * e.pcsPerCarton!).toInt(),
                        fSubTotal: e.isWeight == true ? (e.weightCount *
                            e.sellingCost!) : (e.unitcount * e.sellingCost!) +
                            (e.boxcount * e.sellingBoxCost!),
                        fItemDiscount: 0,
                        stockPcsQty: 0))
                    .toList(),
              );
              controller.salesOrderApi();
            }
          },
          child: Text(
            'Place Order',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: MyFont.myFont,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
    // });
  }


  orderList() {
    return ListView.builder(
        itemCount: productList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          unittotal =
              productList[index].unitcount * productList[index].sellingCost!;
          boxtotal =
              productList[index].boxcount * productList[index].sellingBoxCost!;
          weightTotal =
              productList[index].weightCount * productList[index].sellingCost!;
          if (productList[index].isWeight == true) {
            total = weightTotal;
          } else {
            total = unittotal + boxtotal;
          }
          slNo = index;

          if (productList[index].boxcount == 0 &&
              productList[index].unitcount == 0 &&
              productList[index].weightCount == 0) {
            return Container();
          } else {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HeroScreen(
                                          item: productList[index],
                                        ),
                                  )),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 8, right: 8, left: 8),
                            child: Container(
                              height: height(context) / 10,
                              width: width(context) / 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: MyColors.grey,
                              ),
                              child: Hero(
                                tag: productList[index],
                                child: productList[index].productImagePath !=
                                    null
                                    ? ("${productList[index].productImagePath}"
                                    .isNotEmpty)
                                    ? Image.network(
                                    '${productList[index].productImagePath}',
                                    fit: BoxFit.fill)
                                    : Image.asset(Assets.noImage)
                                    : const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                top: 20,
                              ),
                              width: width(context) / 2,
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.aboutProductScreen,
                                      arguments: productList[index]);
                                },
                                child: Text(
                                  productList[index].productName ?? "",
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height(context) / 80),
                            (productList[index].pcsPerCarton == 1)
                                ? Container(
                              child: (productList[index].isWeight == true)
                                  ? Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Weight :  ",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: MyFont.myFont,
                                          fontSize: 8,
                                          color: MyColors.mainTheme),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                    child: SizedBox(
                                      width: width(context) / 5,
                                      child: TextField(
                                        onChanged: (value) async {
                                          print("Entered value: $value");

                                          if (value == "") {
                                            value = "";
                                          }
                                          productList[index].weightCount = double.parse(value);

                                          print("Weight count: ${productList[index].weightCount}");

                                          bool isAlreadyAdded = controller.cartService.cartItems.any((element) =>
                                          element.productCode == productList[index].productCode);

                                          print("Is already added: $isAlreadyAdded");

                                          if (productList[index].weightCount != 0.00) {
                                            if (!isAlreadyAdded) {
                                              controller.cartService.cartItems.add(productList[index]);
                                              print("Added to cart");
                                            }
                                          }

                                          setState(() {
                                            controller.cartService.removeFromCart(product: productList[index]);
                                            controller.updateProductCount();
                                            print("Removed from cart");
                                          });

                                          await PreferenceHelper.saveCartData(controller.selectedItems);
                                          checkEmptyCart(index: index);

                                          if (controller.cartService.cartItems[controller.selectedIndex.value].weightCount == 0) {
                                            if (controller.cartService.cartItems.any((element) =>
                                            element.productCode == productList[index].productCode)) {
                                              var selectedIndex = controller.cartService.cartItems
                                                  .indexWhere((element) =>
                                              element.productCode == productList[index].productCode);

                                              controller.cartService.cartItems.removeAt(selectedIndex);
                                              print("Removed from cartItems");
                                            }
                                          }
                                        },


                                        maxLines: 1,
                                        readOnly: false,
                                        textAlign: TextAlign.start,
                                        showCursor: false,
                                        inputFormatters: [
                                          NumericInputFormatter(),
                                        ],
                                        decoration:
                                        const InputDecoration(
                                            border: InputBorder
                                                .none,
                                            counterText: '',
                                            hintStyle: TextStyle(
                                                color: MyColors
                                                    .black),
                                            hintText: "0.00"),
                                        controller: productList[index]
                                            .WeightcountController,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: MyColors.black),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '\$ ${weightTotal.toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: MyColors.black),
                                    ),
                                  )
                                ],
                              )
                                  : Container(),)
                                : Row(
                              children: [
                                Text(
                                  "BoxCount :  ",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: MyFont.myFont,
                                      fontSize: 8,
                                      color: MyColors.white),
                                ),
                                Text(
                                  productList[index]
                                      .pcsPerCarton
                                      .toString() ??
                                      "",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: MyFont.myFont,
                                      fontSize: 8,
                                      color: MyColors.white),
                                ),
                              ],
                            ),
                            (productList[index].pcsPerCarton == 1)
                                ? Container()
                                : Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Text(
                                      "Box :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: MyColors.mainTheme),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        4, 8, 8, 8),
                                    alignment: Alignment.center,
                                    child: (productList[index].boxcount == 0)
                                        ? InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets
                                            .fromLTRB(5, 0, 0, 0),
                                        child: SizedBox(
                                          height:
                                          height(context) / 40,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                MyColors.white,
                                                side: const BorderSide(
                                                    color: MyColors
                                                        .mainTheme)),
                                            onPressed: () async {
                                              setState(
                                                    () {
                                                  // productList[index]
                                                  //     .boxcountincrement();

                                                  setState(() {
                                                    controller
                                                        .cartService
                                                        .addToCart(
                                                        product:
                                                        productList[
                                                        index],
                                                        isBox:
                                                        true);
                                                    controller
                                                        .updateProductCount();
                                                  });

                                                  productList[index]
                                                      .isShowButtons =
                                                      productList[
                                                      index]
                                                          .isShowButtons;
                                                },
                                              );
                                              await PreferenceHelper
                                                  .saveCartData(
                                                  productList);
                                            },
                                            child: const Text(
                                              'Add',
                                              style: TextStyle(
                                                  color: MyColors
                                                      .mainTheme),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                        : SizedBox(
                                      height: 25,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              setState(() {
                                                controller
                                                    .cartService
                                                    .removeFromCart(
                                                    product:
                                                    productList[
                                                    index],
                                                    isBox:
                                                    true);
                                                controller
                                                    .updateProductCount();
                                              });

                                              // setState(() {
                                              //  productList[
                                              //           index]
                                              //       .boxcountdecrement();
                                              // });
                                              checkEmptyCart(
                                                  index: index);
                                            },
                                            child: Container(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                top: 1,
                                                bottom: 1,
                                                right: 6,
                                                left: 6,
                                              ),
                                              decoration:
                                              BoxDecoration(
                                                color: MyColors
                                                    .mainTheme,
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    8),
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                                size: 12,
                                                color:
                                                MyColors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Container(
                                              padding:
                                              const EdgeInsets
                                                  .all(1),
                                              width:
                                              width(context) /
                                                  14,
                                              child: Center(
                                                child: Text(
                                                    "${productList[index]
                                                        .boxcount}"),
                                              )
                                            // TextField(
                                            //   onChanged: (String) {
                                            //    selectedItems[
                                            //                 index]
                                            //             .boxcountController
                                            //             .text =
                                            //         selectedItems[
                                            //                 index]
                                            //             .boxcount
                                            //             .toInt()
                                            //             .toString();
                                            //   },
                                            //   inputFormatters: [
                                            //     NumericInputFormatter()
                                            //   ],
                                            //   readOnly: true,
                                            //   textAlign:
                                            //       TextAlign.center,
                                            //   showCursor: false,
                                            //   decoration:
                                            //       const InputDecoration
                                            //               .collapsed(
                                            //           hintText: ""),
                                            //   controller:selectedItems[
                                            //           index]
                                            //       .boxcountController,
                                            //   style:
                                            //       const TextStyle(
                                            //     fontSize: 12,
                                            //   ),
                                            // ),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              setState(() {
                                                controller
                                                    .cartService
                                                    .addToCart(
                                                    product:
                                                    productList[
                                                    index],
                                                    isBox:
                                                    true);
                                                controller
                                                    .updateProductCount();
                                              });

                                              // setState(() {
                                              //   productList[index]
                                              //       .boxcountincrement();
                                              // });
                                              await PreferenceHelper
                                                  .saveCartData(productList);
                                            },
                                            child: Container(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                top: 1,
                                                bottom: 1,
                                                right: 6,
                                                left: 6,
                                              ),
                                              decoration:
                                              BoxDecoration(
                                                color: MyColors
                                                    .mainTheme,
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    8),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                size: 12,
                                                color:
                                                MyColors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '\$ ${boxtotal.toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: MyColors.black),
                                    ),
                                  )
                                ]),
                            productList[index].isWeight == false
                                ? Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(5),
                                    child: const Text(
                                      "Unit :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: MyColors.mainTheme),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 8),
                                    alignment: Alignment.center,
                                    child: (productList[index].unitcount == 0)
                                        ? InkWell(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            5, 0, 0, 0),
                                        child: SizedBox(
                                          height: height(context) / 40,
                                          child: ElevatedButton(
                                            style:
                                            ElevatedButton.styleFrom(
                                                backgroundColor:
                                                MyColors.white,
                                                side: const BorderSide(
                                                    color: MyColors
                                                        .mainTheme)),
                                            onPressed: () async {
                                              setState(
                                                    () {
                                                  setState(() {
                                                    controller.cartService
                                                        .addToCart(
                                                        product:
                                                        productList[
                                                        index],
                                                        isBox: false);
                                                    controller
                                                        .updateProductCount();
                                                  });

                                                  // productList[index]
                                                  //     .unitincrement();

                                                  productList[index]
                                                      .isShowButtons =
                                                      productList[index]
                                                          .isShowButtons;
                                                },
                                              );
                                              await PreferenceHelper
                                                  .saveCartData(
                                                  productList);
                                            },
                                            child: const Text(
                                              'Add',
                                              style: TextStyle(
                                                  color:
                                                  MyColors.mainTheme),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                        : SizedBox(
                                      height: 25,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              setState(() {
                                                controller.cartService.removeFromCart(
                                                    product: productList[index],
                                                    isBox: false);
                                                controller.updateProductCount();
                                              });

                                              // setState(
                                              //   () {
                                              //     productList[index]
                                              //         .unitdecrement();
                                              //   },
                                              //
                                              // );
                                              await PreferenceHelper
                                                  .saveCartData(controller
                                                  .selectedItems);
                                              checkEmptyCart(
                                                  index: index);
                                            },
                                            child: Container(
                                              padding:
                                              const EdgeInsets.only(
                                                top: 1,
                                                bottom: 1,
                                                right: 6,
                                                left: 6,
                                              ),
                                              decoration: BoxDecoration(
                                                color: MyColors.mainTheme,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8),
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                                size: 12,
                                                color: MyColors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Container(
                                              padding:
                                              const EdgeInsets.all(1),
                                              width: width(context) / 14,
                                              child: Center(
                                                child: Text(
                                                    "${productList[index]
                                                        .unitcount}"),
                                              )
                                            // TextField(
                                            //   onChanged: (String) {
                                            //     selectedItems[index]
                                            //             .unitcountController
                                            //             .text =
                                            //         selectedItems[
                                            //                 index]
                                            //             .unitcount
                                            //             .toInt()
                                            //             .toString();
                                            //   },
                                            //   inputFormatters: [
                                            //     NumericInputFormatter()
                                            //   ],
                                            //   readOnly: true,
                                            //   textAlign: TextAlign.center,
                                            //   showCursor: false,
                                            //   decoration:
                                            //       const InputDecoration
                                            //               .collapsed(
                                            //           hintText: ""),
                                            //   controller: selectedItems[index]
                                            //       .unitcountController,
                                            //   style: const TextStyle(
                                            //     fontSize: 12,
                                            //   ),
                                            // ),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              setState(() {
                                                controller.cartService
                                                    .addToCart(
                                                    product: productList[index],
                                                    isBox: false);
                                                controller
                                                    .updateProductCount();
                                              });
                                              // setState(() {
                                              //   productList[index]
                                              //       .unitincrement();
                                              // });
                                              await PreferenceHelper
                                                  .saveCartData(
                                                  productList);
                                            },
                                            child: Container(
                                              padding:
                                              const EdgeInsets.only(
                                                top: 1,
                                                bottom: 1,
                                                right: 6,
                                                left: 6,
                                              ),
                                              decoration: BoxDecoration(
                                                color: MyColors.mainTheme,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                size: 12,
                                                color: MyColors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '\$ ${unittotal.toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: MyColors.black),
                                    ),
                                  )
                                ])
                                : Container(),
                            SizedBox(height: height(context) / 50),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            width: 150,
                          ),
                          Row(
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: MyColors.greyText),
                              ),
                              SizedBox(width: width(context) / 20),
                              Text(
                                '\$ ${total.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: MyColors.mainTheme),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height(context) / 50),
                  ],
                ),
              ),
            );
          }
        });
  }

  showbarBottom() {
    Get.showSnackbar(
      const GetSnackBar(
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        backgroundColor: Colors.red,
        title: "Error",
        message: "Please select atleast one product",
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> checkEmptyCart({required index}) async {
    if (productList[index].boxcount == 0 && productList[index].unitcount == 0 &&
        productList[index].weightCount == 0) {
      productList.removeAt(index);
    }
    await PreferenceHelper.saveCartData(productList);
    if (productList.isEmpty) {
      Get.back();
    }
  }
}
