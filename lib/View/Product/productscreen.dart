import 'dart:ffi';

import 'package:b2b/Helper/preferenceHelper.dart';
import 'package:b2b/Helper/size.dart';
import 'package:b2b/Helper/valitation.dart';
import 'package:b2b/Model/ProductModel1.dart';
import 'package:b2b/View/DashBoard/dashboardcontroller.dart';
import 'package:b2b/View/Product/productcontroller.dart';
import 'package:b2b/approute.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Helper/assets.dart';
import '../../Helper/colors.dart';
import '../../Helper/fonts.dart';
import '../AboutProuduct/aboutproductcontroller.dart';
import '../Cart/cartscreen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController _scrollController = ScrollController();
  late ProductController controller;
  late Product productModel1;

  late DashBoardController dashBoardController;
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  String? cateogryId = '';
  String? subCateogryId = '';
  double totalcost = 0;
  double totalcount = 0;
  double totalunitcount = 0;
  double totalboxcost = 0;
  double totalboxcount = 0;
  double totalunitcost = 0;
  double boxTotal = 0;
  double unitTotal = 0;
  double weightTotal = 0;
  bool isLoading = false;
  final _scrollThreshold = 200.0;
  List<String> savedProduct = [];

  @override
  void initState() {
    super.initState();
    // Listen to changes in the cart and refresh the state
    controller = Get.put(ProductController());
    controller.cartService.cartChangeStream.listen((_) {
      setState(() {});
    });
    initData();
    controller.updateProductCount();
  }

  late final List<Product> localData;

  Future<void> initData() async {
    productModel1 = Get.put(Product());
    dashBoardController = Get.put(DashBoardController());
    await controller.getCategoryList();
    await controller.getProductByCategoryId(
        categoryId: cateogryId ?? '',
        subCategoryId: subCateogryId ?? '',
        isPagination: false);
    _scrollController.addListener(_scrollListener);
    dashBoardController
      ..bannerGet()
      ..getOrderList()
      ..getPaymentList()
      ..getInvoiceList();
    localData = await PreferenceHelper.getCartData();
    if (localData != null) {
      for (int i = 0; i < localData.length; i++) {
        savedProduct.add(localData[i].productCode!);
      }
      controller.cartAddedProduct.clear();
      controller.cartAddedProduct.addAll(localData);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollListener() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      if (controller.currentPage <= controller.totalPages &&
          !controller.status.isLoadingMore) {
        await controller.getProductByCategoryId(
            categoryId: cateogryId ?? '',
            subCategoryId: subCateogryId ?? '',
            isPagination: true);
      }
    }
  }
  final ScrollController scrollGridController = ScrollController();
  final ScrollController horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
        init: controller,
        builder: (state) {
          return Scaffold(
            floatingActionButton: (controller.productList.value.isNotEmpty)
                ? buildFloatingButton()
                : Container(),
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Get.offAndToNamed(AppRoutes.bottomNavBar0);
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              backgroundColor: MyColors.mainTheme,
              title: Text('Products',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: MyFont.myFont,
                      color: MyColors.white)),
              centerTitle: true,
              actions: [
                buildAppBarCartButton() // Replace with your desired widget
              ],
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Column(
                    children: [
                      SizedBox(height: height(context) / 50),
                      // banner list
                      if (dashBoardController.bannerImageList.isNotEmpty)
                        buildBannerWidget(context),
                      // Categroy and Sub category Listview
                      Column(
                        children: [
                          if (controller.categoryList.value?.isNotEmpty ??
                              false)
                            buildCategoryListView(context),
                          const SizedBox(height: 10),
                          buildSubCategoryListView(),
                        ],
                      ),
                      // Product List Vie
                      _productListView()
                    ],
                  ),
                ),
                if (controller.status.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            ),
          );
        });
  }

  Widget buildCategoryListView(BuildContext context) {
    return Obx(() {
      return SizedBox(
        height: 55,
        child: ListView.builder(
            controller: horizontalScrollController,
            shrinkWrap: true,
            itemCount: controller.categoryList.value?.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  controller.category.value = index;
                  controller.currentPage = 1;
                  controller.totalPages = 1;
                  controller.productList.clear();
                  if (index == 0) {
                    cateogryId = "";
                    subCateogryId = "";
                    controller.subCategoryList.value = null;
                    await controller.getProductByCategoryId(
                        categoryId: '', subCategoryId: '', isPagination: false);
                  } else {
                    cateogryId = controller.categoryList.value?[index].code;
                    await controller.getSubCategoryList(
                        categoryId: cateogryId ?? '');
                    await controller.getProductByCategoryId(
                        categoryId: cateogryId ?? '',
                        subCategoryId: '',
                        isPagination: false);
                  }
                },
                child: Card(
                  elevation: 3,
                  color: controller.category.value == index
                      ? MyColors.primaryCustom
                      : MyColors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Text(
                      controller.categoryList.value?[index].name ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: MyFont.myFont,
                        letterSpacing: 0.5,
                        fontSize: 13,
                        color: controller.category.value == index
                            ? MyColors.white
                            : MyColors.black,
                      ),
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }

  Widget buildSubCategoryListView() {
    return Obx(() {
      return (controller.subCategoryList.value != null)
          ? Container(
              padding: const EdgeInsets.all(5),
              height: 55,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.subCategoryList.value?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        controller.subcategory.value = index;
                        controller.currentPage = 1;
                        controller.totalPages = 1;
                        controller.productList.clear();
                        if (index == 0) {
                          await controller.getProductByCategoryId(
                              categoryId: cateogryId ?? '',
                              subCategoryId: "",
                              isPagination: false);
                        } else {
                          subCateogryId =
                              controller.subCategoryList.value?[index].code;

                          await controller.getProductByCategoryId(
                              categoryId: cateogryId ?? '',
                              subCategoryId: subCateogryId ?? '',
                              isPagination: false);
                        }
                      },
                      child: Card(
                        elevation: 3,
                        color: controller.subcategory.value == index
                            ? MyColors.primaryCustom
                            : MyColors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text(
                            controller.subCategoryList.value?[index].name ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: MyFont.myFont,
                              letterSpacing: 0.5,
                              fontSize: 13,
                              color: controller.subcategory.value == index
                                  ? MyColors.white
                                  : MyColors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }))
          : Container();
    });
  }

  Column buildBannerWidget(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height(context) / 6,
          width: double.infinity,
          child: CarouselSlider.builder(
            itemCount: dashBoardController.bannerImageList.length,
            itemBuilder: (context, itemIndex, realIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: width(context),
                    child: Image.network(
                      dashBoardController
                          .bannerImageList[itemIndex].bannerImageFilePath!
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
        SizedBox(height: height(context) / 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              dashBoardController.bannerImageList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => carouselController.animateToPage(entry.key),
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
        SizedBox(height: height(context) / 80),
      ],
    );
  }

  Widget buildAppBarCartButton() {
    return Obx(() {
      return GestureDetector(
        onTap: () async {
          print("123456789");
          print(controller.cartAddedProduct.length);
          if (controller.cartAddedProduct.isNotEmpty) {
            Get.toNamed(AppRoutes.cartScreen,
                    arguments: controller.cartAddedProduct)
                ?.then((value) {
              if (value == true) {
                initData();
              }
            });
          } else {
            Get.showSnackbar(
              const GetSnackBar(
                margin: EdgeInsets.all(10),
                borderRadius: 10,
                backgroundColor: Colors.red,
                snackPosition: SnackPosition.TOP,
                message: "Please select atleast one product",
                icon: Icon(
                  Icons.error,
                  color: Colors.white,
                ),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 11.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 11.0),
                child: Icon(
                  Icons.shopping_cart,
                  color: MyColors.grey,
                  size: 30,
                ),
              ),
              if (controller.cartAddedProduct.isNotEmpty)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffc32c37),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: Center(
                      child: Text(
                        controller.cartAddedProduct.length.toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Container buildFloatingButton() {
    return Container(
      decoration: const BoxDecoration(
        color: MyColors.black2,
        shape: BoxShape.circle,
      ),
      width: 40,
      height: 40,
      child: IconButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        },
        icon: const Icon(
          Icons.arrow_upward_rounded,
          color: MyColors.white,
        ),
      ),
    );
  }

  _productListView() {
    if ((controller.productList.value.isNotEmpty)) {
      return Column(
        children: [
          GridView.builder(
              controller: scrollGridController,
              shrinkWrap: true,
              itemCount: controller.productList.value.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                boxTotal = controller.productList.value[index].sellingBoxCost!;
                unitTotal = controller.productList.value[index].sellingCost!;
                weightTotal = controller.productList.value[index].sellingCost!;

                // boxTotal = controller
                //         .product.value[index].sellingBoxCost! *
                //     controller.product.value[index].boxcount
                //         .toDouble();
                // unitTotal = controller
                //         .product.value[index].sellingCost! *
                //     controller.product.value[index].unitcount
                //         .toDouble();

                return Container(
                  padding: const EdgeInsets.only(
                    top: 2,
                    left: 2,
                    right: 2,
                  ),
                  child: Column(children: [
                    InkWell(
                      onTap: () {
                        controller.selectedIndex.value = index;
                        Get.toNamed(AppRoutes.aboutProductScreen,
                            arguments: controller.productList.value[index]);
                      },
                      child: Container(
                        width: 200,
                        height: 150,
                        padding: const EdgeInsets.fromLTRB(
                          15,
                          15,
                          15,
                          15,
                        ),
                        decoration: const BoxDecoration(
                          color: MyColors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.grey,
                              blurRadius: 2,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: (controller
                                    .productList[index].productImagePath !=
                                null)
                            ? ("${controller.productList[index].productImagePath}"
                                    .isNotEmpty)
                                ? Image.network(
                                    '${controller.productList[index].productImagePath}',
                                    fit: BoxFit.contain)
                                : Image.asset(Assets.noImage)
                            : const Icon(Icons.error),
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 15,
                        right: 5,
                        left: 5,
                      ),
                      decoration: const BoxDecoration(
                        color: MyColors.mainTheme,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.grey,
                            blurRadius: 2,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.selectedIndex.value = index;
                              Get.toNamed(AppRoutes.aboutProductScreen,
                                  arguments:
                                      controller.productList.value[index]);
                            },
                            child: SizedBox(
                              height: height(context) / 50,
                              width: width(context) / 2.2,
                              child: Text(
                                controller.productList.value[index].name ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: MyFont.myFont,
                                    fontSize: 10,
                                    color: MyColors.white),
                              ),
                            ),
                          ),
                          (controller.productList.value[index].pcsPerCarton ==
                                  1)
                              ? Container(height: 9)
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
                                      controller
                                          .productList.value[index].pcsPerCarton
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: MyFont.myFont,
                                          fontSize: 8,
                                          color: MyColors.white),
                                    ),
                                  ],
                                ),
                          const SizedBox(
                            height: 5,
                          ),
                          if (controller.productList[index].pcsPerCarton == 1)
                            Container(
                              height: 25,
                            )
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: MyColors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "Box",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 8,
                                        color: MyColors.mainTheme),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 25,
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                Product? selectedProduct =
                                                    controller
                                                        .productList[index];

                                                setState(() {
                                                  controller.cartService
                                                      .removeFromCart(
                                                          product:
                                                              selectedProduct,
                                                          isBox: true);
                                                  controller
                                                      .updateProductCount();
                                                });

                                                controller
                                                        .productList[index]
                                                        .boxcountController
                                                        .text =
                                                    controller
                                                        .productList[index]
                                                        .boxcount
                                                        .toInt()
                                                        .toString();

                                                if (selectedProduct.unitcount ==
                                                        0 &&
                                                    selectedProduct.boxcount ==
                                                        0) {
                                                  if (controller
                                                      .cartAddedProduct
                                                      .any((element) =>
                                                          element.productCode ==
                                                          selectedProduct
                                                              .productCode)) {
                                                    var selectedIndex = controller
                                                        .cartAddedProduct
                                                        .indexWhere((element) =>
                                                            element
                                                                .productCode ==
                                                            selectedProduct
                                                                .productCode);

                                                    controller.cartAddedProduct
                                                        .removeAt(
                                                            selectedIndex);
                                                    if (controller
                                                        .cartAddedProduct
                                                        .isEmpty) {
                                                      controller
                                                          .cartAddedProduct
                                                          .clear();
                                                    }
                                                  }
                                                }
                                                if (controller
                                                        .productList[index]
                                                        .boxcountController
                                                        .text ==
                                                    "0") {
                                                  controller.cartAddedProduct
                                                      .length = 0;
                                                }
                                                await PreferenceHelper
                                                    .saveCartData(controller
                                                        .cartAddedProduct);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                  top: 1,
                                                  bottom: 1,
                                                  right: 6,
                                                  left: 6,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: MyColors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: const Icon(Icons.remove,
                                                    size: 12,
                                                    color: MyColors.mainTheme),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            SizedBox(
                                              width: width(context) / 15,
                                              child: TextField(
                                                onChanged: (String) {
                                                  controller
                                                          .productList[index]
                                                          .boxcountController
                                                          .text =
                                                      controller
                                                          .productList[index]
                                                          .boxcount
                                                          .toInt()
                                                          .toString();
                                                },
                                                maxLines: 1,
                                                maxLength: 3,
                                                readOnly: true,
                                                maxLengthEnforcement:
                                                    MaxLengthEnforcement
                                                        .enforced,
                                                textAlign: TextAlign.center,
                                                showCursor: false,
                                                inputFormatters: [
                                                  NumericInputFormatter(),
                                                ],
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  counterText: '',
                                                  hintStyle: TextStyle(
                                                      color: MyColors.white),
                                                  hintText: "0",
                                                ),
                                                controller: controller
                                                    .productList
                                                    .value[index]
                                                    .boxcountController,
                                                style: const TextStyle(
                                                    fontSize: 11,
                                                    color: MyColors.white),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                // controller
                                                //         .product[index]
                                                //         .boxcountController
                                                //         .text =
                                                //     controller
                                                //         .product[
                                                //             index]
                                                //         .boxcount
                                                //         .toInt()
                                                //         .toString();
                                                Product? selectedProduct =
                                                    controller.productList
                                                        .value[index];

                                                if (savedProduct.contains(
                                                    selectedProduct
                                                        .productCode)) {
                                                  var selectedIndex = controller
                                                      .cartAddedProduct
                                                      .indexWhere((element) =>
                                                          element.productCode ==
                                                          selectedProduct
                                                              .productCode);

                                                  controller.cartAddedProduct
                                                      .removeAt(selectedIndex);
                                                  savedProduct.remove(
                                                      selectedProduct
                                                          .productCode);
                                                }
                                                // selectedProduct
                                                //     .boxcountincrement();

                                                setState(() {
                                                  controller.cartService
                                                      .addToCart(
                                                          product:
                                                              selectedProduct,
                                                          isBox: true);
                                                  controller
                                                      .updateProductCount();
                                                });

                                                if (selectedProduct.unitcount !=
                                                        0 ||
                                                    selectedProduct.boxCount !=
                                                        0) {
                                                  bool isAlreadyAdded =
                                                      controller
                                                          .cartAddedProduct
                                                          .any((element) =>
                                                              element
                                                                  .productCode ==
                                                              selectedProduct
                                                                  .productCode);

                                                  if (!isAlreadyAdded) {
                                                    controller.cartAddedProduct
                                                        .add(selectedProduct);
                                                  }
                                                }
                                                await PreferenceHelper
                                                    .saveCartData(controller
                                                        .cartAddedProduct);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                  top: 1,
                                                  bottom: 1,
                                                  right: 6,
                                                  left: 6,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: MyColors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: const Icon(Icons.add,
                                                    size: 12,
                                                    color: MyColors.mainTheme),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      "\$ ${boxTotal.toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: MyFont.myFont,
                                          fontSize: 10,
                                          // decoration: TextDecoration.lineThrough,
                                          color: MyColors.white)),
                                ),
                              ],
                            ),
                          SizedBox(
                            height: height(context) / 100,
                          ),
                          (controller.productList[index].isWeight == false)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: MyColors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        "Unit",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8,
                                            color: MyColors.mainTheme),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: 25,
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    controller
                                                            .productList[index]
                                                            .unitcountController
                                                            .text =
                                                        controller
                                                            .productList[index]
                                                            .unitcount
                                                            .toInt()
                                                            .toString();
                                                    Product? selectedProduct =
                                                        controller.productList
                                                            .value[index];

                                                    setState(() {
                                                      controller.cartService
                                                          .removeFromCart(
                                                              product:
                                                                  selectedProduct,
                                                              //isBox: false
                                                      );
                                                      controller
                                                          .updateProductCount();
                                                    });

                                                    if (selectedProduct
                                                                .unitcount ==
                                                            0 &&
                                                        selectedProduct
                                                                .boxcount ==
                                                            0) {
                                                      if (controller
                                                          .cartAddedProduct
                                                          .any((element) =>
                                                              element
                                                                  .productCode ==
                                                              selectedProduct
                                                                  .productCode)) {
                                                        var selectedIndex = controller
                                                            .cartAddedProduct
                                                            .indexWhere((element) =>
                                                                element
                                                                    .productCode ==
                                                                selectedProduct
                                                                    .productCode);

                                                        controller
                                                            .cartAddedProduct
                                                            .removeAt(
                                                                selectedIndex);
                                                        if (controller
                                                            .cartAddedProduct
                                                            .isEmpty) {
                                                          controller
                                                              .cartAddedProduct
                                                              .clear();
                                                        }
                                                      }
                                                    }
                                                    await PreferenceHelper
                                                        .saveCartData(controller
                                                        .cartAddedProduct);
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
                                                      color: MyColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: const Icon(
                                                        Icons.remove,
                                                        size: 12,
                                                        color:
                                                            MyColors.mainTheme),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                SizedBox(
                                                  width: width(context) / 15,
                                                  child: TextField(
                                                    onChanged: (String) {
                                                      controller
                                                              .productList[index]
                                                              .unitcountController
                                                              .text =
                                                          controller
                                                              .productList[
                                                                  index]
                                                              .unitcount
                                                              .toInt()
                                                              .toString();
                                                    },
                                                    maxLines: 1,
                                                    maxLength: 3,
                                                    readOnly: true,
                                                    maxLengthEnforcement:
                                                        MaxLengthEnforcement
                                                            .enforced,
                                                    textAlign: TextAlign.center,
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
                                                                    .white),
                                                            hintText: "0"),
                                                    controller: controller
                                                        .productList
                                                        .value[index]
                                                        .unitcountController,
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        color: MyColors.white),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    controller.productList[index]
                                                            .unitcountController
                                                            .text =
                                                        controller
                                                            .productList[index]
                                                            .unitcount
                                                            .toInt()
                                                            .toString();
                                                    Product? selectedProduct =
                                                        controller.productList
                                                            .value[index];
                                                    if (savedProduct.contains(
                                                        selectedProduct
                                                            .productCode)) {
                                                      var selectedIndex = controller
                                                          .cartAddedProduct
                                                          .indexWhere((element) =>
                                                              element
                                                                  .productCode ==
                                                              selectedProduct
                                                                  .productCode);

                                                      controller
                                                          .cartAddedProduct
                                                          .removeAt(
                                                              selectedIndex);
                                                      savedProduct.remove(
                                                          selectedProduct
                                                              .productCode);
                                                    }
                                                    // selectedProduct.unitincrement();

                                                    setState(() {
                                                      controller.cartService
                                                          .addToCart(
                                                              product:
                                                                  selectedProduct,
                                                              isBox: false);
                                                      controller
                                                          .updateProductCount();
                                                    });

                                                    if (selectedProduct
                                                                .unitcount !=
                                                            0 ||
                                                        selectedProduct
                                                                .boxCount !=
                                                            0) {
                                                      bool isAlreadyAdded = controller
                                                          .cartAddedProduct
                                                          .any((element) =>
                                                              element
                                                                  .productCode ==
                                                              selectedProduct
                                                                  .productCode);

                                                      if (!isAlreadyAdded) {
                                                        controller
                                                            .cartAddedProduct
                                                            .add(
                                                                selectedProduct);
                                                      }
                                                    }
                                                    await PreferenceHelper
                                                        .saveCartData(controller
                                                            .cartAddedProduct);
                                                    print(controller.cartAddedProduct.length);
                                                    print("0000000000000000000000000000");
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
                                                      color: MyColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: const Icon(Icons.add,
                                                        size: 12,
                                                        color:
                                                            MyColors.mainTheme),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          "\$ ${unitTotal.toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: MyFont.myFont,
                                              fontSize: 10,
                                              // decoration: TextDecoration.lineThrough,
                                              color: MyColors.white)),
                                    ),
                                  ],
                                )
                              : Container(
                                  child: (controller
                                              .productList[index].isWeight ==
                                          false)
                                      ? Container(
                                          height: 25,
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 3),
                                              decoration: BoxDecoration(
                                                color: MyColors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Text(
                                                "Weight",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8,
                                                    color: MyColors.mainTheme),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SizedBox(
                                                    height: 30,
                                                    child: SizedBox(
                                                      width: width(context) / 6,
                                                      child: TextField(
                                                        onChanged: (value) async {
                                                          if (value == "") {
                                                             //value = "0.00";
                                                          }
                                                          print("Enter the Value:$value");
                                                          Product? selectedProduct = controller.productList.value[index];
                                                          selectedProduct.weightCount = double.parse(value);

                                                          bool isAlreadyAdded = controller.cartAddedProduct
                                                              .any((element) => element.productCode == selectedProduct.productCode);

                                                          if (selectedProduct.weightCount != 0.00) {

                                                            if (!isAlreadyAdded) {
                                                              controller.cartAddedProduct.add(selectedProduct);

                                                            }

                                                          }

                                                          setState(() {
                                                            controller.cartService.addToCart(product: selectedProduct);
                                                            controller.updateProductCount();
                                                            controller.productList.value[index].WeightcountController.text=value;
                                                          });

                                                          if (controller.cartAddedProduct[controller.selectedIndex.value].weightCount == 0) {
                                                            if (controller.cartAddedProduct
                                                                .any((element) => element.productCode == selectedProduct.productCode)) {
                                                              var selectedIndex = controller.cartAddedProduct
                                                                  .indexWhere((element) => element.productCode == selectedProduct.productCode);

                                                              controller.cartAddedProduct.removeAt(selectedIndex);
                                                            }
                                                          }

                                                          await PreferenceHelper.saveCartData(controller.cartAddedProduct);
                                                        },
                                                        maxLines: 1,
                                                        readOnly: false,
                                                        keyboardType: TextInputType.number,
                                                        //textAlign: TextAlign.center,
                                                        showCursor: true,
                                                        cursorColor: Colors.white,
                                                        inputFormatters: [
                                                          NumericInputFormatter(),
                                                        ],
                                                        decoration:  InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide:  BorderSide(
                                                              color: MyColors.white,
                                                            ),
                                                            borderRadius: BorderRadius.circular(12.0),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: MyColors.white,  // Set the desired border color when focused
                                                            ),
                                                            borderRadius: BorderRadius.circular(12.0),
                                                          ),
                                                          filled: true,
                                                          fillColor: MyColors.tp,  // Set filled color
                                                         hintStyle:  TextStyle(color: MyColors.grey),
                                                          hintText: "0.00",
                                                          labelText: "Weight",  // Set label text
                                                          labelStyle: const TextStyle(color: MyColors.white),
                                                        ),
                                                        controller:
                                                        controller.productList.value[index].WeightcountController,
                                                        style: const TextStyle(fontSize: 11, color: MyColors.white),
                                                      ),

                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  "\$ ${weightTotal.toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: MyFont.myFont,
                                                      fontSize: 10,
                                                      // decoration: TextDecoration.lineThrough,
                                                      color: MyColors.white)),
                                            ),
                                          ],
                                        ),
                                ),
                        ],
                      ),
                    ),
                  ]),
                );
              }),
          if (controller.status.isLoadingMore)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      );
    } else {
      if (controller.status.isLoadingMore || controller.status.isLoading) {
        return Container();
      }
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 150),
          child: Text("No product Found"),
        ),
      );
    }
  }
}
