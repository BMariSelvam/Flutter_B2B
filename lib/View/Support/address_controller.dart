import 'dart:convert';

import 'package:b2b/Helper/HttpUrl.dart';
import 'package:b2b/Helper/NetworkClass.dart';
import 'package:b2b/Helper/colors.dart';
import 'package:b2b/Model/login_model1.dart';
import 'package:b2b/Model/postal_code_model.dart';
import 'package:b2b/Model/shipping_address_screen_model.dart';
import 'package:b2b/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LocationFetchController extends GetxController with StateMixin {
  TextEditingController locationSearchController = TextEditingController();

  TextEditingController postalCodeController = TextEditingController();
  TextEditingController buildingBlockNoController = TextEditingController();
  TextEditingController floorUnitNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController landmarkAreaNameController = TextEditingController();
  TextEditingController addAddressLabelController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool createIsLoading = false.obs;

  Rx<List<ShippingAddressModel>?> addressList =
      (null as List<ShippingAddressModel>?).obs;
  LoginUser? loginUser;
  ShippingAddressModel? createAddress;
  String? messages;

  RxBool fetchIsLoading = false.obs;
  List<PostalModel> postalModel = [];

  createPostAddress() async {
    createIsLoading.value = true;
    change(null, status: RxStatus.loading());
    print("lllllllllllll");
    await NetworkService.post(
            URl: HttpUrl.getCreateAddress, params: createAddress?.toJson())
        .then((apiResponse) async {
      createIsLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        print("mmmmmmmmmmmm");
        print(apiResponse.apiResponseModel!.status);
        Get.snackbar(
          margin: EdgeInsets.all(20),
          backgroundColor: MyColors.mainTheme.withOpacity(0.5),
          "Success",
          "address successfully added",
          colorText: MyColors.black,
          icon: const Icon(Icons.task_alt_rounded),
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
        );
        await Get.offAndToNamed(AppRoutes.shippingAddressScreen);
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
        String? message = apiResponse.apiResponseModel?.message.toString();
        message = messages;
        print("API Response Message (Error): $message");
        print("bbbbbbbbbbbbb");
        Get.snackbar(
          margin: EdgeInsets.all(20),
          backgroundColor: MyColors.red,
          "Attention",
          message ?? apiResponse.apiResponseModel!.message.toString(),
          icon: const Icon(Icons.emergency),
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }

  getPostal(String postalNo) async {
    fetchIsLoading.value = true;
    final Uri url = Uri.parse(
        "https://developers.onemap.sg/commonapi/search?searchVal=%22$postalNo%22&returnGeom=N&getAddrDetails=Y");
    fetchIsLoading.value = false;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData != null) {
        postalModel = (jsonData['results'] as List)
            .map((e) => PostalModel.fromJson(e))
            .toList();
        String statusName = "";
        buildingBlockNoController.text =
            "${postalModel.first.BLKNO!},${postalModel.first.ROADNAME!}";
        addressController.text = postalModel.first.ADDRESS!;
        buildingController.text = postalModel.first.BUILDING!;
        // if (landmarkAreaNameController.text == null &&
        //     landmarkAreaNameController.text == "NIl") {
        //   landmarkAreaNameController.text = "";
        // } else {
        //   landmarkAreaNameController.text = postalModel.first.BUILDING!;
        // }
        change(postalModel);
      }
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
      Get.snackbar(
        margin: const EdgeInsets.all(20),
        backgroundColor: MyColors.red,
        "Attention",
        "Please enter postal code",
        icon: const Icon(Icons.emergency),
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
