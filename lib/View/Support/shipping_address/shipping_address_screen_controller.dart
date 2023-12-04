import 'package:b2b/Helper/HttpUrl.dart';
import 'package:b2b/Helper/NetworkClass.dart';
import 'package:b2b/Helper/preferenceHelper.dart';
import 'package:b2b/Model/login_model1.dart';
import 'package:b2b/Model/shipping_address_screen_model.dart';
import 'package:get/get.dart';

class ShippingAddressController extends GetxController with StateMixin {
  List<ShippingAddressModel> shippingAddressModel = [];
  LoginUser? loginUser;
  Rx<bool> isLoading = false.obs;
  String? address1;
  String? address2;
  String? address3;
  String? address;

  @override
  onInit() async {
    super.onInit();
    getCustomerDeliveryAddress();
    // getCustomerDashBoard();
  }

  @override
  getCustomerDeliveryAddress() async {
    print("lllllllll");
    isLoading.value = true;
    LoginUser? loginUser = await PreferenceHelper.getUserData();
    change(null, status: RxStatus.loading());
    NetworkService.get(
      url: HttpUrl.getCustomerDeliveryAddress,
      parameters: {
        "OrganizationId": 1,
        "CustomerId": loginUser!.code,
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          List? resJson = apiResponse.apiResponseModel!.data!;
          print("ooooooooo");
          if (resJson != null) {
            List<ShippingAddressModel> list =
                resJson.map<ShippingAddressModel>((value) {
              return ShippingAddressModel.fromJson(value);
            }).toList();
            shippingAddressModel = list;
            print("kkkkkkkkkkkkkkkkkkkkk");
            print(shippingAddressModel);
            // address1 = shippingAddressModel.first.addressLine1!;
            // address2 = shippingAddressModel.first.addressLine2!;
            // address3 = shippingAddressModel.first.addressLine3!;
            //
            // address = "$address1,$address2,$address3";

            change(null, status: RxStatus.success());

            return;
          }
        } else {
          print("bbbbbbbbbbb");
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        print("mmmmmmmmmmmm");
        change(null, status: RxStatus.error());
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }
}
