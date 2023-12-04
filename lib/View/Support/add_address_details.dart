import 'package:b2b/Helper/colors.dart';
import 'package:b2b/Helper/fonts.dart';
import 'package:b2b/Helper/preferenceHelper.dart';
import 'package:b2b/Model/shipping_address_screen_model.dart';
import 'package:b2b/View/Support/address_controller.dart';
import 'package:b2b/View/Widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterAddressDetailsScreen extends StatefulWidget {
  const EnterAddressDetailsScreen({Key? key}) : super(key: key);

  @override
  State<EnterAddressDetailsScreen> createState() =>
      _EditEnterAddressDetailsScreenState();
}

class _EditEnterAddressDetailsScreenState
    extends State<EnterAddressDetailsScreen> {
  late LocationFetchController locationFetchController;
  String currentDate = DateTime.now().toString();
  final addressKey = GlobalKey<FormState>();
  String? customerId;
  String? customerName;
  String? countryName;
  String? countryId;
  String? address;
  String? postalCode;
  String? emailId;
  String? mobile;
  String? priceSettingCode;
  String? termCode;

  @override
  void initState() {
    super.initState();
    getUserData();
    locationFetchController = Get.put(LocationFetchController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationFetchController>(builder: (logic) {
      // if (logic.createIsLoading.value == true) {
      //   return Container(
      //     color: MyColors.white,
      //     child: const Center(
      //       child: CircularProgressIndicator(),
      //     ),
      //   );
      // }

      return Form(
        key: addressKey,
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: AppBar(
            backgroundColor: MyColors.mainTheme,
            iconTheme: const IconThemeData(color: MyColors.white),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              'Enter Address Details',
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  color: MyColors.white),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 10,
                    right: 5,
                  ),
                  child: Text(
                    'Postal Code',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
                CustomTextField(
                  inputBorder: const OutlineInputBorder(),
                  controller: locationFetchController.postalCodeController,
                  keyboardType: TextInputType.number,
                  readOnly: false,
                  suffixIcon: locationFetchController.fetchIsLoading.value ==
                          true
                      ? const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: CircularProgressIndicator(
                            strokeWidth: 5,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: InkWell(
                            onTap: () async {
                              clear();
                              if (locationFetchController
                                  .postalCodeController.text.isNotEmpty) {
                                await locationFetchController.getPostal(
                                    locationFetchController
                                        .postalCodeController.text);
                              } else {
                                Get.snackbar(
                                  margin: EdgeInsets.all(20),
                                  backgroundColor: MyColors.red,
                                  "Attention",
                                  "Please enter postal code",
                                  colorText: MyColors.white,
                                  icon: const Icon(
                                    Icons.emergency,
                                    color: MyColors.white,
                                  ),
                                  duration: const Duration(seconds: 3),
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            },
                            child: Card(
                              elevation: 0,
                              color: MyColors.mainTheme,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  "Fetch",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Your PostalCode";
                    } else {}
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 10,
                    right: 5,
                  ),
                  child: Text(
                    'Building & Block No',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
                CustomTextField(
                  inputBorder: const OutlineInputBorder(),
                  controller: locationFetchController.buildingBlockNoController,
                  keyboardType: TextInputType.text,
                  // hintText: 'Mobile Number',
                  readOnly: false,
                  onChanged: (value) {
                    locationFetchController.buildingBlockNoController.text =
                        value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Your Building & Block No";
                    } else {}
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 10,
                              right: 5,
                            ),
                            child: Text(
                              'Floor & Unit No',
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          CustomTextField(
                            inputBorder: const OutlineInputBorder(),
                            controller:
                                locationFetchController.floorUnitNoController,
                            keyboardType: TextInputType.text,
                            readOnly: false,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return "Enter Your floor No.& Unit No";
                            //   } else {}
                            // },
                          ),
                        ],
                      ),
                    ),
                    // Expanded(
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         padding: const EdgeInsets.only(
                    //           top: 5,
                    //           left: 10,
                    //           right: 5,
                    //         ),
                    //         child: Text(
                    //           'Unit No',
                    //           style: TextStyle(
                    //             fontFamily: MyFont.myFont,
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 12,
                    //           ),
                    //         ),
                    //       ),
                    //       CustomTextField(
                    //         inputBorder: const OutlineInputBorder(),
                    //         controller:
                    //             locationFetchController.unitNoController,
                    //         keyboardType: TextInputType.text,
                    //         // hintText: 'Mobile Number',
                    //         readOnly: false,
                    //         validator: (value) {
                    //           if (value == null) {
                    //             return "Enter Your Unit No.";
                    //           } else {}
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 10,
                    right: 5,
                  ),
                  child: Text(
                    'Building Name',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
                CustomTextField(
                  inputBorder: const OutlineInputBorder(),
                  controller: locationFetchController.buildingController,
                  keyboardType: TextInputType.text,
                  readOnly: false,
                  onChanged: (value) {
                    locationFetchController.buildingController.text = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Your Building Name";
                    } else {}
                  },
                ),
                // Container(
                //   padding: const EdgeInsets.only(
                //     top: 5,
                //     left: 10,
                //     right: 5,
                //   ),
                //   child: Text(
                //     'Address',
                //     style: TextStyle(
                //       fontFamily: MyFont.myFont,
                //       fontWeight: FontWeight.w500,
                //       fontSize: 12,
                //     ),
                //   ),
                // ),
                // CustomTextField(
                //   inputBorder: const OutlineInputBorder(),
                //   controller: locationFetchController.addressController,
                //   keyboardType: TextInputType.text,
                //   readOnly: false,
                //   onChanged: (value) {
                //     locationFetchController.addressController.text = value;
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return "Enter Your Address";
                //     } else {}
                //   },
                // ),
                // Container(
                //   padding: const EdgeInsets.only(
                //     top: 5,
                //     left: 10,
                //     right: 5,
                //   ),
                //   child: Text(
                //     'Landmark & Area Name (Option)',
                //     style: TextStyle(
                //       fontFamily: MyFont.myFont,
                //       fontWeight: FontWeight.w500,
                //       fontSize: 12,
                //     ),
                //   ),
                // ),
                // CustomTextField(
                //   inputBorder: const OutlineInputBorder(),
                //   controller:
                //       locationFetchController.landmarkAreaNameController,
                //   keyboardType: TextInputType.text,
                //   readOnly: false,
                // ),
                // Container(
                //   padding: const EdgeInsets.only(
                //     top: 5,
                //     left: 10,
                //     right: 5,
                //   ),
                //   child: Text(
                //     'Add Address Label',
                //     style: TextStyle(
                //       fontFamily: MyFont.myFont,
                //       fontWeight: FontWeight.w500,
                //       fontSize: 12,
                //     ),
                //   ),
                // ),
                // CustomTextField(
                //   inputBorder: const OutlineInputBorder(),
                //   controller: locationFetchController.addAddressLabelController,
                //   keyboardType: TextInputType.text,
                //   readOnly: false,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return "Enter Your Add address label";
                //     } else {}
                //   },
                // ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            child: GestureDetector(
              onTap: () async {
                FocusScope.of(context).unfocus();
                if (addressKey.currentState!.validate()) {
                  locationFetchController.createAddress = ShippingAddressModel(
                    orgId: 1,
                    customerId: customerId ?? "",
                    deliveryId: 0,
                    fax: "",
                    countryName: countryName ?? "Singapore",
                    mail: emailId,
                    isDefault: true,
                    mobile: mobile,
                    name: customerName,
                    phone: mobile,
                    addressLine1:
                        locationFetchController.buildingBlockNoController.text,
                    addressLine2:
                        locationFetchController.floorUnitNoController.text,
                    addressLine3:
                        locationFetchController.buildingController.text,
                    countryId: countryId,
                    postalCode:
                        locationFetchController.postalCodeController.text,
                    isActive:
                        locationFetchController.createAddress?.isActive ?? true,
                    createdBy: "admin",
                    createdOn: currentDate,
                    changedBy: "admin",
                    changedOn: currentDate,
                  );
                  locationFetchController.createPostAddress();
                  clear();
                }
              },
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyColors.mainTheme,
                  // border: Border.all(color: MyColors.mainTheme, width: 2),
                ),
                child: Center(
                    child: Text(
                  'Submit',
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: MyColors.white,
                  ),
                )),
              ),
            ),
          ),
        ),
      );
    });
  }

  clear() {
    locationFetchController.landmarkAreaNameController.clear();
    locationFetchController.addAddressLabelController.clear();
    locationFetchController.addressController.clear();
    locationFetchController.buildingBlockNoController.clear();
    locationFetchController.floorUnitNoController.clear();
    locationFetchController.buildingController.clear();
    locationFetchController.postalCodeController.clear();
  }

  getUserData() async {
    await PreferenceHelper.getUserData().then((value) {
      customerId = value?.code;
      customerName = value?.name;
      emailId = value?.mail;
      mobile = value?.mobile;
      countryName = value?.countryName;
      countryId = value?.countryId;
      postalCode = value?.postalCode;
    });
  }
}
