import 'dart:convert';

import 'package:b2b/Helper/NetworkClass.dart';
import 'package:b2b/Helper/HttpUrl.dart';
import 'package:b2b/Model/sales_order/sales_order.dart';

class ApiService {
  static Future<ApiResponse> SalesOrders(
      {required SalesOrder salesOrderModel}) async {
    final apiResponse = await NetworkService.post(
        URl: HttpUrl.salesOrderCreate,
        params: json.decode(salesOrderModel.toJson()));
    return apiResponse;
  }
}
