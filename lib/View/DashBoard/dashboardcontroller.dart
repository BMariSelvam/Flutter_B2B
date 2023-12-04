import 'package:b2b/Helper/HttpUrl.dart';
import 'package:b2b/Helper/NetworkClass.dart';
import 'package:b2b/Helper/preferenceHelper.dart';
import 'package:b2b/Model/BannerModel.dart';
import 'package:b2b/Model/DashBoardModels/CustomerDashBoardModel.dart';
import 'package:b2b/Model/OrderModel.dart';
import 'package:b2b/Model/PaymentModel.dart';
import 'package:b2b/Model/invoiceModel.dart';
import 'package:b2b/Model/login_model1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController with StateMixin {
  String dropDownValue = 'index 0';
  int serial = 1;

  // Rx<List<BannerModel>?> bannerImageList = (null as List<BannerModel>?).obs;
  List<BannerModel> bannerImageList = [];

  Rx<bool> isLoading = false.obs;

  List<OrderModel> ordersModelList = [];

  // Rx<List<OrderModel>?> ordersModelList = (null as List<OrderModel>?).obs;
  LoginUser? loginUser;

  List<PaymentModel> PaymentModelList = [];

  // Rx<List<PaymentModel>?> PaymentModelList = (null as List<PaymentModel>?).obs;

  var selectedValue;
  double salesOrderTotal = 0;
  double invoiceTotal = 0;
  double receiptTotal = 5;
  double outStandingTotal = 0;

  // Rx<List<InvoiceModel>?> InvoiceModelList = (null as List<InvoiceModel>?).obs;
  List<InvoiceModel> InvoiceModelList = [];
  List<CustomerDashBoardModel> customerDashBoardModel = [];
  InvoiceModel? InvoiceModel1;

  @override
  onInit() async {
    super.onInit();
    getOrderList();
    getPaymentList();
    getInvoiceList();
    bannerGet();
    // getCustomerDashBoard();
  }

  bannerGet() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkService.get(
      url: HttpUrl.bannerImage,
      parameters: {},
    ).then((apiResponse) async {
      isLoading.value = false;

      print("000000000000000000");
      print(apiResponse.apiResponseModel!.result);
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          // logic for api call success

          bannerImageList = (apiResponse.apiResponseModel!.data as List)
              .map((e) => BannerModel.fromJson(e))
              .toList();
          change(bannerImageList);

          change(bannerImageList, status: RxStatus.success());
          print("+++++++++++++");
          print("bannerImageList is $bannerImageList");
          print("+++++++++++++");
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        change(null, status: RxStatus.error());
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }

  getOrderList() async {
    isLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    NetworkService.get(url: HttpUrl.salesOrderGetHeaderSearch, parameters: {
      "searchModel.organisationId": "1",
      "searchModel.customerCode": loginUser?.code ?? '',
    }).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            ordersModelList = (response.apiResponseModel!.data as List)
                .map((e) => OrderModel.fromJson(e))
                .toList();
            change(ordersModelList);
          }
        } else {
          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: response.apiResponseModel!.message ?? '',
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "ee",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }

  getPaymentList() async {
    isLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    NetworkService.get(
      url: HttpUrl.receiptGetHeaderSearch,
      parameters: {
        "searchModel.organisationId": "1",
        "searchModel.customerCode": loginUser!.code,
      },
    ).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            PaymentModelList = (response.apiResponseModel!.data as List)
                .map((e) => PaymentModel.fromJson(e))
                .toList();
            change(PaymentModelList);
          }
        } else {
          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: response.apiResponseModel!.message ?? '',
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "ee",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }

  getInvoiceList() async {
    isLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    NetworkService.get(url: HttpUrl.invoiceGetHeaderSearch, parameters: {
      "searchModel.organisationId": "1",
      "searchModel.customerCode": loginUser!.code,
    }).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            InvoiceModelList = (response.apiResponseModel!.data as List)
                .map((e) => InvoiceModel.fromJson(e))
                .toList();
            change(InvoiceModelList);
          }
        } else {
          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: response.apiResponseModel!.message ?? '',
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }

  getCustomerDashBoard() async {
    isLoading.value = true;
    LoginUser? loginUser = await PreferenceHelper.getUserData();
    change(null, status: RxStatus.loading());
    await NetworkService.get(
      url: HttpUrl.getCustomerDashBoard,
      parameters: {
        "OrganizationId": 1,
        "CustomerCode": loginUser?.code,
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          if (resJson != null) {
            List<CustomerDashBoardModel> list =
                resJson.map<CustomerDashBoardModel>((value) {
              return CustomerDashBoardModel.fromJson(value);
            }).toList();
            customerDashBoardModel = list;
            receiptTotal = customerDashBoardModel.first.receiptTotal!;
            outStandingTotal = customerDashBoardModel.first.outStandingTotal!;
            salesOrderTotal = customerDashBoardModel.first.salesorderTotal!;
            invoiceTotal = customerDashBoardModel.first.invoiceTotal!;
            change(receiptTotal);
            change(outStandingTotal);
            change(salesOrderTotal);
            change(invoiceTotal);
            change(null, status: RxStatus.success());
            return;
          }
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        change(null, status: RxStatus.error());
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }
}
