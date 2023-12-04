import 'dart:convert';

import 'package:b2b/Model/ProductModel1.dart';
import 'package:b2b/Model/login_model1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static void log(dynamic value) {
    if (value != null && true) {
      final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
      pattern.allMatches(value).forEach((match) => debugPrint(match.group(0)));
    }
  }

  static showSnackBar(
      {required BuildContext context, String? msg, Duration? duration}) {
    if (msg != null && msg.isNotEmpty) {
      final messenger = ScaffoldMessenger.of(context);
      Get.showSnackbar(GetSnackBar(
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        backgroundColor: Colors.red,
        title: "Error",
        message: msg,
        icon: const Icon(Icons.error, color: Colors.white),
        duration: const Duration(seconds: 3),
      ));
    }
  }

  static Future<LoginUser?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'user_data';
    if (prefs.containsKey(key)) {
      final value = json.decode(prefs.getString(key)!);
      if (value != null) {
        PreferenceHelper.log('Get User Data: $value');
        return LoginUser.fromJson(value);
      }
    }
    return null;
  }

  static Future<bool> saveUserData(Map userData) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'user_data';
    final value = json.encode(userData);
    PreferenceHelper.log('Save User Data $value');
    return prefs.setString(key, value);
  }

  static Future<void> saveEmail(
      {required String key, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getEmail({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'user_data';
    await prefs.clear();
    return true;
  }

  // static Future<void> saveCartData(List<Product> cartItems) async {
  //   String? email = await PreferenceHelper.getEmail(key: 'my_key');
  //   final prefs = await SharedPreferences.getInstance();
  //   const key = email;
  //   final cartItemsJson = cartItems.map((item) => item.toJson(forSharedPreference: true)).toList();
  //   print(cartItemsJson);
  //   prefs.setString(key, json.encode(cartItemsJson));
  //   PreferenceHelper.log('Saved cart_data: $cartItemsJson');
  // }

  static Future<void> saveCartData(List<Product> cartItems) async {
    String? email = await PreferenceHelper.getEmail(key: 'my_key');
    final prefs = await SharedPreferences.getInstance();
    final key = email; // Use a regular variable here
    final cartItemsJson = cartItems
        .map((item) => item.toJson(forSharedPreference: true))
        .toList();
    print(cartItemsJson);
    prefs.setString(key!, json.encode(cartItemsJson));
    PreferenceHelper.log('Saved cart_data: $cartItemsJson');
  }

  static Future<List<Product>> getCartData() async {
    String? email = await PreferenceHelper.getEmail(key: 'my_key');
    final prefs = await SharedPreferences.getInstance();
    final key = email;
    if (prefs.containsKey(key!)) {
      final value = json.decode(prefs.getString(key)!);
      if (value != null) {
        return (value as List)
            .map((item) => Product.fromJson(item, forSharedPreference: true))
            .toList();
      }
    }
    return [];
  }

  static Future<void> removeCartData() async {
    String? email = await PreferenceHelper.getEmail(key: 'my_key');
    final prefs = await SharedPreferences.getInstance();
    final key = email;
    await prefs.remove(key!);
    log('Cart data removed.');
  }
}
