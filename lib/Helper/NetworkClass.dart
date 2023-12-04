import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:b2b/Helper/preferenceHelper.dart';

import 'package:get/get.dart';

import '../Model/ApiResponseModel.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  static Future<ApiResponse> get(
      {required String url, required Map<String, dynamic> parameters}) async {
    var uri = Uri.parse(url);
    // print("+++++++++++url: $url");
    print("url");
    print(uri);
    print("parameters");
    print(parameters);
    parameters["OrganizationId"] = "1";
    // print("+++++++++++params: $parameters");
    uri = Uri.http(uri.authority, uri.path, parameters);
    var response = await http.get(
      uri,
    );
    return _handleResponse(response);
  }

  static Future<ApiResponse> post(
      {required String URl, required Map<String, dynamic>? params}) async {
    final url = Uri.parse(URl);
    print("+++++++++++url: $url");
    print("+++++++++++params: $params");
    final response = await http.post(url,
        body: json.encode(params),
        headers: {"Content-Type": "application/json"});
    return _handleResponse(response);
  }

  static Future<ApiResponse> put(String path,
      {Map<String, String>? headers, dynamic body}) async {
    final url = Uri.parse('$path');
    final response =
        await http.put(url, headers: headers, body: json.encode(body));
    return _handleResponse(response);
  }

  static Future<ApiResponse> delete(String path,
      {Map<String, String>? headers}) async {
    final url = Uri.parse('$path');
    final response = await http.delete(url, headers: headers);
    return _handleResponse(response);
  }

  static Future<ApiResponse> _handleResponse(http.Response response) async {
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      if (data != null && data is Map<String, dynamic>) {
        return ApiResponse(
            apiResponseModel: ApiResponseModel.fromJson(data), error: null);
      } else {
        PreferenceHelper.log("******Response Error*****");
        PreferenceHelper.log(data);
        return ApiResponse(apiResponseModel: null, error: "Response Error");
      }
    } else {
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: statusCode.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
      throw Exception('Error: $statusCode');
    }
  }

  Future<bool> isNetworkAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

// Future<void> fetchData() async {
//   try {
//     bool isConnected = await isNetworkAvailable();
//     if (!isConnected) {
//       // Show a snackbar or dialog to inform the user about the network connection failure.
//       throw Exception('No internet connection.');
//     }
//
//     // // Replace this with your actual API endpoint
//     // var url = Uri.parse('https://api.example.com/data');
//     // var response = await http.get(url);
//     //
//     // if (response.statusCode == 200) {
//     //   // Successfully fetched data
//     //   // TODO: Handle and parse the response data
//     //   print(response.body);
//     // } else {
//     //   // Show a snackbar or dialog to inform the user about the request failure.
//     //   throw Exception('Failed to load data.');
//     // }
//   } catch (e) {
//     // Handle exceptions and show the error message to the user.
//     print('Error: $e');
//   }
// }

// static Future<ApiResponse> _mainCall(
//     {required HttpMethods httpMethods,
//     required String url,
//     required var params}) async {
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.none) {
//     return ApiResponse(
//         apiResponseModel: null, error: "No Internet Connection");
//   }
//   try {
//     late Response response;
//
//     if (httpMethods == HttpMethods.get) {
//       response = await _dio().get(url, queryParameters: params);
//     } else if (httpMethods == HttpMethods.post) {
//       response = await _dio().post(url, data: params);
//     } else if (httpMethods == HttpMethods.put) {
//       response = await _dio().put(url, data: params);
//     } else if (httpMethods == HttpMethods.delete) {
//       response = await _dio().delete(url, data: params);
//     }
//     if (response.statusCode == 200) {
//       if (response.data is String) {
//         PreferenceHelper.log("######Response######");
//         // if (Themes.navigatorKey.currentContext != null) {
//         // Themes.navigatorKey.currentContext!
//         //     .read<UserProvider>()
//         //     .callCheckMultiUserLogin();
//         // }
//         var data = json.decode(response.data);
//         if (data != null && data is Map<String, dynamic>) {
//           prettyPrintJson(data);
//           return ApiResponse(
//               apiResponseModel: ApiResponseModel.fromJson(data), error: null);
//         } else {
//           PreferenceHelper.log("******Response Error*****");
//           PreferenceHelper.log(response.data);
//           return ApiResponse(apiResponseModel: null, error: "Response Error");
//         }
//       } else if (response.data is Map<String, dynamic>) {
//         PreferenceHelper.log("******Response*****");
//         prettyPrintJson(response.data);
//         return ApiResponse(
//             apiResponseModel: ApiResponseModel.fromJson(response.data),
//             error: null);
//       } else {
//         PreferenceHelper.log("******Response*****");
//         PreferenceHelper.log(response.data);
//       }
//     } else if (response.statusCode == 401) {
//       await _generateToken();
//     }
//     return ApiResponse(apiResponseModel: null, error: "Response Error");
//   } on DioError catch (error) {
//     PreferenceHelper.log("DioError Exception occurred: $error");
//     return ApiResponse(apiResponseModel: null, error: "Response error");
//   } on FormatException catch (e) {
//     PreferenceHelper.log("FormatException occurred: ${e.source}");
//     return ApiResponse(apiResponseModel: null, error: "Response error");
//   } catch (e) {
//     PreferenceHelper.log("Exception occurred: $e");
//     return ApiResponse(apiResponseModel: null, error: "Response error");
//   }
// }
}

class ApiResponse {
  ApiResponseModel? apiResponseModel;
  String? error;

  ApiResponse({required this.apiResponseModel, required this.error});
}
