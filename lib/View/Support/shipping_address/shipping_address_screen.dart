import 'package:b2b/Helper/size.dart';
import 'package:b2b/View/Support/add_address_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/colors.dart';
import '../../../Helper/fonts.dart';
import 'shipping_address_screen_controller.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({Key? key}) : super(key: key);

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  late ShippingAddressController shippingAddressController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shippingAddressController = Get.put(ShippingAddressController());
    shippingAddressController.getCustomerDeliveryAddress();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShippingAddressController>(
      builder: (logic) {
        if (logic.isLoading.value == true) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
            backgroundColor: MyColors.grey,
            appBar: AppBar(
              backgroundColor: MyColors.mainTheme,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.back();
                },
              ),
              title: Text('Address',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: MyFont.myFont,
                      color: MyColors.white)),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add_circle_outline,
                      size: 25,
                      color: MyColors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EnterAddressDetailsScreen(),
                          ));
                    },
                  ),
                ),
              ],
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: (shippingAddressController.shippingAddressModel.isEmpty ||
                      shippingAddressController.shippingAddressModel.length ==
                          null)
                  ? (shippingAddressController.isLoading.value)
                      ? CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.only(top: 380),
                          child: const Center(
                            child: Text("No Address"),
                          ),
                        )
                  : SizedBox(
                      height: height(context),
                      child: ListView.builder(
                        itemCount: shippingAddressController
                            .shippingAddressModel.length,
                        itemBuilder: (context, index) {
                          String address1 = shippingAddressController
                                  .shippingAddressModel[index].addressLine1 ??
                              "";
                          String address2 = shippingAddressController
                                  .shippingAddressModel[index].addressLine2 ??
                              "";
                          String address3 = shippingAddressController
                                  .shippingAddressModel[index].addressLine3 ??
                              "";
                          String countryName = shippingAddressController
                                  .shippingAddressModel[index].countryName ??
                              "";
                          String postalCode = shippingAddressController
                                  .shippingAddressModel[index].postalCode ??
                              "";
                          return SizedBox(
                            height: height(context) / 10,
                            child: Card(
                              elevation: 5,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.location_on,
                                    color: MyColors.lightBlue,
                                    size: 20,
                                  ),
                                  Container(
                                    width: width(context) / 1.5,
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    child: Text(
                                      "$address1,$address2,$address3$countryName$postalCode",
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: MyFont.myFont,
                                        color: MyColors.black,
                                      ),
                                    ),
                                  ),
                                  // const Icon(
                                  //   Icons.edit,
                                  //   color: MyColors.lightBlue,
                                  //   size: 20,
                                  // ),
                                  // const SizedBox(
                                  //   width: 5,
                                  // ),
                                  // const Icon(
                                  //   Icons.delete_outline_rounded,
                                  //   color: MyColors.lightBlue,
                                  //   size: 20,
                                  // ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ));
      },
    );
  }
}
