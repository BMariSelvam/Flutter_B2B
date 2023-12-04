import 'package:b2b/Helper/preferenceHelper.dart';
import 'package:b2b/View/Product/productcontroller.dart';
import 'package:b2b/View/Widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Helper/assets.dart';
import '../../Helper/colors.dart';
import '../../Helper/fonts.dart';
import '../../Helper/size.dart';
import '../../Helper/valitation.dart';
import '../../Model/ProductModel1.dart';
import '../../Model/TaxModel.dart';
import 'aboutproductcontroller.dart';

class AboutProductScreen extends StatefulWidget {
  const AboutProductScreen({Key? key}) : super(key: key);

  @override
  State<AboutProductScreen> createState() => _AboutProductScreenState();
}

class _AboutProductScreenState extends State<AboutProductScreen> {
  late AboutProductController controller;
  late ProductController _productController;

  TextEditingController qtycountController = TextEditingController();
  TextEditingController stockcountController = TextEditingController();
  TextEditingController piecesPerBoxController = TextEditingController();
  TextEditingController focController = TextEditingController();
  TextEditingController sellingBoxCostController = TextEditingController();
  TextEditingController sellingCostController = TextEditingController();

  late Product productModel1;

  double boxtotal = 0;
  double Unittotal = 0;
  double qtytotal = 0;
  double subTotal = 0;
  double qty = 0;
  double box = 0;
  double countqty = 0;
  double tax = 0;
  double netTotal = 0;
  double taxValue = 0;
  double boxcount = 0;
  double unitcount = 0;

  double unittotal = 0;

  double subtotal = 0;
  double total = 0;

  double boxCounts = 0;

  String? selectedItemLength;

  List<TaxModel> taxvalueList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(AboutProductController());
    _productController = Get.put(ProductController());
    ProductController _controller = Get.find<ProductController>();
    taxvalueList = _controller.taxModel;
    productModel1 = Get.arguments as Product;
    stockcountController.text = "${productModel1.stockQty}" ?? "0";
    sellingBoxCostController.text =
        productModel1.sellingBoxCost!.toStringAsFixed(2);
    sellingCostController.text = productModel1.sellingCost!.toStringAsFixed(2);
    piecesPerBoxController.text =
        productModel1.pcsPerCarton!.toStringAsFixed(0);
    box = productModel1.pcsPerCarton!.toDouble();
    controller.cartService.cartChangeStream.listen((_) {});
    UnitCountControllerFunction();
    BoxCountControllerFunction();
  }

  UnitCountControllerFunction() {
    setState(() {
      if (productModel1.boxcountController.text == "") {
        productModel1.boxcountController.text = "0";
      }
      boxcount = double.parse(productModel1.boxcountController.text);
      boxtotal = boxcount * productModel1.sellingBoxCost!;
      boxCounts = boxcount * box;
      qtycountController.text = boxCounts.toStringAsFixed(0);
      subTotal = boxCounts * productModel1.sellingCost!;
      tax = subTotal * controller.taxPercentage / 100;
      if (controller.taxName == "Inclusive") {
        netTotal = subTotal;
      } else if (controller.taxName == "Exclusive") {
        netTotal = subTotal + tax;
      } else if (controller.taxName == "GSTs") {
        netTotal = subTotal + tax;
      } else {
        netTotal = subTotal + tax;
      }
    });
  }

  BoxCountControllerFunction() {
    setState(() {
      if (productModel1.unitcountController.text == "") {
        productModel1.unitcountController.text = "0";
      }
      ((productModel1.pcsPerCarton == 1)
          ? boxcount
          : double.parse(productModel1.boxcountController.text));
      unitcount = double.parse(productModel1.unitcountController.text);
      Unittotal = unitcount * productModel1.sellingCost!;
      boxtotal = boxcount * productModel1.sellingBoxCost!;
      total += unittotal + boxtotal;
      boxCounts = boxcount * box;
      countqty = boxCounts + unitcount;
      qtycountController.text = countqty.toStringAsFixed(0);
      subTotal = countqty * productModel1.sellingCost!;
      tax = subTotal * controller.taxPercentage! / 100;
      if (controller.taxName == "Inclusive") {
        netTotal = subTotal;
      } else if (controller.taxName == "Exclusive") {
        netTotal = subTotal + tax;
      } else if (controller.taxName == "GSTs") {
        netTotal = subTotal + tax;
      } else {
        netTotal = subTotal + tax;
      }
    });
  }

  firstBoxCalculation(String value) {
    setState(() {
      if (value == "") {
        value = "0";
      }
      double bC = double.parse(value);
      if (productModel1.unitcountController.text != "" &&
          productModel1.unitcountController.text != "0") {
        double boxQty = double.parse(piecesPerBoxController.text);
        double unitCount = double.parse(productModel1.unitcountController.text);
        double totalBoxQty = (bC * boxQty) + unitCount;
        qtycountController.text = totalBoxQty.toStringAsFixed(0);
        double selllingCost = double.parse(sellingCostController.text);
        subTotal = totalBoxQty * selllingCost;
        tax = subTotal * controller.taxPercentage! / 100;
        if (controller.taxName == "Inclusive") {
          netTotal = subTotal;
        } else if (controller.taxName == "Exclusive") {
          netTotal = subTotal + tax;
        } else if (controller.taxName == "GSTs") {
          netTotal = subTotal + tax;
        } else {
          netTotal = subTotal + tax;
        }
      } else {
        double boxQty = double.parse(piecesPerBoxController.text);
        double totalBoxQty = bC * boxQty;
        qtycountController.text = totalBoxQty.toStringAsFixed(0);
        double selllingCost = double.parse(sellingCostController.text);
        subTotal = totalBoxQty * selllingCost;
        tax = subTotal * controller.taxPercentage! / 100;
        if (controller.taxName == "Inclusive") {
          netTotal = subTotal;
        } else if (controller.taxName == "Exclusive") {
          netTotal = subTotal + tax;
        } else if (controller.taxName == "GSTs") {
          netTotal = subTotal + tax;
        } else {
          netTotal = subTotal + tax;
        }
      }
    });
  }

  firstUnitCalculation(String value) {
    setState(() {
      if (value == "") {
        value = "0";
      }
      double UC = double.parse(value);

      if (productModel1.boxcountController.text != "" &&
          productModel1.boxcountController.text != "0") {
        double boxc = double.parse(productModel1.boxcountController.text);
        double boxQty = double.parse(piecesPerBoxController.text);
        double totalBoxQty = boxc * boxQty;
        double totalqty = UC + totalBoxQty;
        double selllingCost = double.parse(sellingCostController.text);
        qtycountController.text = totalqty.toStringAsFixed(0);
        subTotal = totalqty * selllingCost;
        tax = subTotal * controller.taxPercentage! / 100;
        if (controller.taxName == "Inclusive") {
          netTotal = subTotal;
        } else if (controller.taxName == "Exclusive") {
          netTotal = subTotal + tax;
        } else if (controller.taxName == "GSTs") {
          netTotal = subTotal + tax;
        } else {
          netTotal = subTotal + tax;
        }
      } else {
        qtycountController.text = UC.toStringAsFixed(0);
        double selllingCost = double.parse(sellingCostController.text);
        subTotal = UC * selllingCost;
        tax = subTotal * controller.taxPercentage! / 100;
        if (controller.taxName == "Inclusive") {
          netTotal = subTotal;
        } else if (controller.taxName == "Exclusive") {
          netTotal = subTotal + tax;
        } else if (controller.taxName == "GSTs") {
          netTotal = subTotal + tax;
        } else {
          netTotal = subTotal + tax;
        }
      }
    });
  }

  reverseCalculation(String value) {
    print(value);
    setState(() {
      if (value == "") {
        value = "0";
      }
      double qty = double.parse(value);
      if (productModel1.pcsPerCarton != 1) {
        double oneBoxqty = double.parse(piecesPerBoxController.text);
        double boxSplit = (qty / oneBoxqty);
        if (oneBoxqty <= qty) {
          int roundedValue = boxSplit.toInt();
          productModel1.boxcountController.text =
              roundedValue.toStringAsFixed(0);
          double splitUnit = qty % oneBoxqty;
          productModel1.unitcountController.text = splitUnit.toStringAsFixed(0);
          double selllingCost = double.parse(sellingCostController.text);
          subTotal = qty * selllingCost;
          tax = subTotal * controller.taxPercentage! / 100;
          if (controller.taxName == "Inclusive") {
            netTotal = subTotal;
          } else if (controller.taxName == "Exclusive") {
            netTotal = subTotal + tax;
          } else if (controller.taxName == "GSTs") {
            netTotal = subTotal + tax;
          } else {
            netTotal = subTotal + tax;
          }
        } else {
          double splitUnit = qty % oneBoxqty;
          productModel1.unitcountController.text = splitUnit.toStringAsFixed(0);
          productModel1.boxcountController.text = '';
          double selllingCost = double.parse(sellingCostController.text);
          subTotal = qty * selllingCost;
          tax = subTotal * controller.taxPercentage! / 100;
          if (controller.taxName == "Inclusive") {
            netTotal = subTotal;
          } else if (controller.taxName == "Exclusive") {
            netTotal = subTotal + tax;
          } else if (controller.taxName == "GSTs") {
            netTotal = subTotal + tax;
          } else {
            netTotal = subTotal + tax;
          }
        }
      } else {
        double selllingCost = double.parse(sellingCostController.text);
        subTotal = qty * selllingCost;
        tax = subTotal * controller.taxPercentage! / 100;
        if (controller.taxName == "Inclusive") {
          netTotal = subTotal;
        } else if (controller.taxName == "Exclusive") {
          netTotal = subTotal + tax;
        } else if (controller.taxName == "GSTs") {
          netTotal = subTotal + tax;
        } else {
          netTotal = subTotal + tax;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.mainTheme,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: MyColors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Products',
          style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.bold,
              color: MyColors.white),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20, top: 20),
              child: Text("ADD",
                  style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      color: MyColors.white)),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: height(context) / 4,
                      width: width(context),
                      child: PageView.builder(
                          itemCount: 2,
                          controller: controller.imageSwipeController,
                          itemBuilder: (context, pagePosition) {
                            return SizedBox(
                              child: (productModel1.productImagePath != null)
                                  ? ("${productModel1.productImagePath}"
                                          .isNotEmpty)
                                      ? Image.network(
                                          '${productModel1.productImagePath}',
                                          fit: BoxFit.contain)
                                      : Image.asset(Assets.noImage)
                                  : const Icon(Icons.error),
                            );
                          }),
                    ),
                    SizedBox(height: height(context) / 50),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller.imageSwipeController,
                        count: 2,
                        effect: const SlideEffect(
                          activeDotColor: MyColors.mainTheme,
                          dotWidth: 6,
                          dotHeight: 5,
                          spacing: 4,
                        ),
                      ),
                    ),
                    SizedBox(height: height(context) / 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                            left: 10,
                            bottom: 20,
                          ),
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Text(
                            "${productModel1.name}",
                            style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: MyColors.black),
                          ),
                        ),
                        SizedBox(height: height(context) / 100),
                        SizedBox(height: height(context) / 100),
                      ],
                    ),
                    SizedBox(height: height(context) / 50),
                    (productModel1.isWeight == true)
                        ? Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  inputFormatters: [NumericInputFormatter()],
                                  filled: true,
                                  click: true,
                                  fillColor: MyColors.grey,
                                  inputBorder: const OutlineInputBorder(),
                                  controller: stockcountController,
                                  keyboardType: TextInputType.number,
                                  hintText: "0",
                                  labelText: "Stock",
                                  readOnly: true,
                                ),
                              ),
                              Expanded(
                                child: CustomTextField(
                                  inputFormatters: [NumericInputFormatter()],
                                  inputBorder: const OutlineInputBorder(),
                                  controller:
                                      productModel1.WeightcountController,
                                  keyboardType: TextInputType.number,
                                  hintText: "0.00",
                                  click: false,
                                  labelText: "Weight",
                                  fillColor: MyColors.tp,
                                  readOnly: false,
                                  onChanged: (value) async {
                                    print("Value entered: $value");
                                    //firstUnitCalculation(value);
                                    if (value == "") {
                                      value = "0.00";
                                    }
                                    productModel1.weightCount =
                                        double.parse(value);
                                    bool isAlreadyAdded = _productController
                                        .cartAddedProduct
                                        .any((element) =>
                                            element.productCode ==
                                            productModel1.productCode);

                                    if (productModel1.weightCount != 0.00) {
                                      print("Adding to cart: $productModel1");
                                      if (!isAlreadyAdded) {
                                        _productController.cartAddedProduct
                                            .add(productModel1);
                                      }
                                    }
                                    setState(() {
                                      controller.cartService
                                          .addToCart(product: productModel1);
                                      controller.updateProductCount();
                                    });
                                    print("Widget rebuilt!");

                                    if (_productController
                                            .cartAddedProduct[_productController
                                                .selectedIndex.value]
                                            .weightCount ==
                                        0) {
                                      if (_productController.cartAddedProduct
                                          .any((element) =>
                                              element.productCode ==
                                              productModel1.productCode)) {
                                        var selectedIndex = _productController
                                            .cartAddedProduct
                                            .indexWhere((element) =>
                                                element.productCode ==
                                                productModel1.productCode);

                                        _productController.cartAddedProduct
                                            .removeAt(selectedIndex);
                                      }
                                    }
                                    await PreferenceHelper.saveCartData(
                                        _productController.cartAddedProduct);
                                  },
                                ),
                              )
                            ],
                          )
                        : Container(),
                    (productModel1.isWeight == false)
                        ? Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  inputFormatters: [NumericInputFormatter()],
                                  filled: true,
                                  click: true,
                                  fillColor: MyColors.grey,
                                  inputBorder: const OutlineInputBorder(),
                                  controller: stockcountController,
                                  keyboardType: TextInputType.number,
                                  hintText: "0",
                                  labelText: "Stock",
                                  readOnly: true,
                                ),
                              ),
                              Expanded(
                                child: CustomTextField(
                                  inputFormatters: [NumericInputFormatter()],
                                  inputBorder: const OutlineInputBorder(),
                                  controller: productModel1.boxcountController,
                                  keyboardType: TextInputType.number,
                                  fillColor: productModel1.pcsPerCarton == 1
                                      ? MyColors.grey
                                      : MyColors.tp,
                                  hintText: "0",
                                  click: false,
                                  labelText: "Box",
                                  readOnly: productModel1.pcsPerCarton == 1,
                                  showCursr: productModel1.pcsPerCarton == 1,
                                  onChanged: (value) async {
                                    firstBoxCalculation(value);
                                    var localdata =
                                        await PreferenceHelper.getCartData();
                                    print("========================localdata");
                                    print(localdata.length);
                                    if (value == "") {
                                      value = "0";
                                    }
                                    productModel1.boxcount = int.parse(value);
                                    bool isAlreadyAdded = _productController
                                        .cartAddedProduct
                                        .any((element) =>
                                            element.productCode ==
                                            productModel1.productCode);

                                    if (productModel1.unitcount != 0 ||
                                        productModel1.boxCount != 0) {
                                      if (!isAlreadyAdded) {
                                        _productController.cartAddedProduct
                                            .add(productModel1);
                                      }
                                    }

                                    if (_productController
                                                .cartAddedProduct[
                                                    _productController
                                                        .selectedIndex.value]
                                                .boxcount ==
                                            0 &&
                                        _productController
                                                .cartAddedProduct[
                                                    _productController
                                                        .selectedIndex.value]
                                                .unitcount ==
                                            0) {
                                      if (_productController.cartAddedProduct
                                          .any((element) =>
                                              element.productCode ==
                                              productModel1.productCode)) {
                                        var selectedIndex = _productController
                                            .cartAddedProduct
                                            .indexWhere((element) =>
                                                element.productCode ==
                                                productModel1.productCode);
                                        _productController.cartAddedProduct
                                            .removeAt(selectedIndex);
                                      }
                                    }
                                    await PreferenceHelper.saveCartData(
                                        _productController.cartAddedProduct);
                                  },
                                ),
                              ),
                              Expanded(
                                child: CustomTextField(
                                  inputFormatters: [NumericInputFormatter()],
                                  inputBorder: const OutlineInputBorder(),
                                  controller: productModel1.unitcountController,
                                  keyboardType: TextInputType.number,
                                  hintText: "0",
                                  click: false,
                                  labelText: "Unit",
                                  fillColor: MyColors.tp,
                                  readOnly: false,
                                  onChanged: (value) async {
                                    firstUnitCalculation(value);
                                    if (value == "") {
                                      value = "0";
                                    }
                                    productModel1.unitcount = int.parse(value);
                                    bool isAlreadyAdded = _productController
                                        .cartAddedProduct
                                        .any((element) =>
                                            element.productCode ==
                                            productModel1.productCode);

                                    if (productModel1.unitcount != 0 ||
                                        productModel1.boxCount != 0) {
                                      if (!isAlreadyAdded) {
                                        _productController.cartAddedProduct
                                            .add(productModel1);
                                      }
                                    }
                                    setState(() {
                                      controller.cartService
                                          .addToCart(product: productModel1);
                                      controller.updateProductCount();
                                    });

                                    if (_productController
                                                .cartAddedProduct[
                                                    _productController
                                                        .selectedIndex.value]
                                                .boxcount ==
                                            0 &&
                                        _productController
                                                .cartAddedProduct[
                                                    _productController
                                                        .selectedIndex.value]
                                                .unitcount ==
                                            0) {
                                      if (_productController.cartAddedProduct
                                          .any((element) =>
                                              element.productCode ==
                                              productModel1.productCode)) {
                                        var selectedIndex = _productController
                                            .cartAddedProduct
                                            .indexWhere((element) =>
                                                element.productCode ==
                                                productModel1.productCode);

                                        _productController.cartAddedProduct
                                            .removeAt(selectedIndex);
                                      }
                                    }
                                    await PreferenceHelper.saveCartData(
                                        _productController.cartAddedProduct);
                                  },
                                ),
                              ),
                              Expanded(
                                child: CustomTextField(
                                  inputFormatters: [NumericInputFormatter()],
                                  inputBorder: const OutlineInputBorder(),
                                  controller: (productModel1.pcsPerCarton == 1)
                                      ? productModel1.unitcountController
                                      : qtycountController,
                                  keyboardType: TextInputType.number,
                                  hintText: "0",
                                  click: false,
                                  labelText: "Qty",
                                  fillColor: MyColors.tp,
                                  readOnly: false,
                                  onChanged: (value) async {
                                    reverseCalculation(value);
                                    if (value == "") {
                                      value = "0";
                                      productModel1.boxcount = 0;
                                      productModel1.unitcount = 0;
                                      productModel1.boxcountController.text =
                                          "0";
                                      productModel1.unitcountController.text =
                                          "0";
                                    }
                                    productModel1.boxcount = int.parse(
                                        productModel1.boxcountController.text);
                                    productModel1.unitcount = int.parse(
                                        productModel1.unitcountController.text);
                                    bool isAlreadyAdded = _productController
                                        .cartAddedProduct
                                        .any((element) =>
                                            element.productCode ==
                                            productModel1.productCode);
                                    if (productModel1.unitcount != 0 ||
                                        productModel1.boxCount != 0) {
                                      if (!isAlreadyAdded) {
                                        _productController.cartAddedProduct
                                            .add(productModel1);
                                      }
                                    }
                                    if (_productController
                                                .cartAddedProduct[
                                                    _productController
                                                        .selectedIndex.value]
                                                .boxcount ==
                                            0 &&
                                        _productController
                                                .cartAddedProduct[
                                                    _productController
                                                        .selectedIndex.value]
                                                .unitcount ==
                                            0) {
                                      if (_productController.cartAddedProduct
                                          .any((element) =>
                                              element.productCode ==
                                              productModel1.productCode)) {
                                        var selectedIndex = _productController
                                            .cartAddedProduct
                                            .indexWhere((element) =>
                                                element.productCode ==
                                                productModel1.productCode);

                                        _productController.cartAddedProduct
                                            .removeAt(selectedIndex);
                                      }
                                    }
                                    await PreferenceHelper.saveCartData(
                                        _productController.cartAddedProduct);
                                  },
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(height: height(context) / 150),
                    (productModel1.isWeight == false)
                        ? Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  inputFormatters: [NumericInputFormatter()],
                                  filled: true,
                                  click: true,
                                  fillColor: MyColors.grey,
                                  inputBorder: const OutlineInputBorder(),
                                  controller: piecesPerBoxController,
                                  keyboardType: TextInputType.number,
                                  hintText: "0",
                                  labelText: "Pieces Per Box",
                                  readOnly: true,
                                ),
                              ),
                              Expanded(
                                child: CustomTextField(
                                  inputFormatters: [NumericInputFormatter()],
                                  inputBorder: const OutlineInputBorder(),
                                  controller: focController,
                                  keyboardType: TextInputType.number,
                                  hintText: "0",
                                  click: false,
                                  fillColor: MyColors.tp,
                                  labelText: "FOC",
                                  readOnly: productModel1.pcsPerCarton == 1
                                      ? true
                                      : false,
                                  showCursr: productModel1.pcsPerCarton == 1
                                      ? true
                                      : false,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(height: height(context) / 150),
                    (productModel1.isWeight == false)
                        ? Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  inputFormatters: [NumericInputFormatter()],
                                  inputBorder: const OutlineInputBorder(),
                                  controller: sellingBoxCostController,
                                  keyboardType: TextInputType.number,
                                  hintText: "0",
                                  labelText: "Selling Box Cost",
                                  readOnly: true,
                                  onChanged: (value) {
                                    productModel1.sellingBoxCost;
                                  },
                                ),
                              ),
                              Expanded(
                                child: CustomTextField(
                                  inputFormatters: [NumericInputFormatter()],
                                  inputBorder: const OutlineInputBorder(),
                                  controller: sellingCostController,
                                  keyboardType: TextInputType.number,
                                  hintText: "0",
                                  labelText: "Selling Cost",
                                  readOnly: true,
                                  onChanged: (value) {
                                    productModel1.sellingCost;
                                  },
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    CustomTextField(
                      inputFormatters: [NumericInputFormatter()],
                      inputBorder: const OutlineInputBorder(),
                      controller: sellingCostController,
                      keyboardType: TextInputType.number,
                      hintText: "0",
                      labelText: "Selling Cost",
                      readOnly: true,
                      onChanged: (value) {
                        productModel1.sellingCost;
                      },
                    ),
                    SizedBox(height: height(context) / 50),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: MyColors.mainTheme,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            child: Table(
              children: [
                TableRow(children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Sub Total',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: MyColors.white),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "\$ ${subTotal.toStringAsFixed(2)}",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: MyColors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tax',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: MyColors.white),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "\$ ${tax.toStringAsFixed(2)}",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: MyColors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Net Total',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: MyColors.white),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "\$ ${netTotal.toStringAsFixed(2)}",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: MyColors.white),
                        ),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
