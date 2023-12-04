import 'dart:async';

import 'package:b2b/Model/ProductModel1.dart';
import 'package:get/get.dart';

class CartService {
  final List<Product> _cartItems = [];

  void addToCart({required Product product, bool? isBox, bool? isWeight}) {
    // Check if the item is already in the cart
    var existingItem = _cartItems
        .firstWhereOrNull((item) => item.productCode == product.productCode);

    if (existingItem != null) {
      // If item exists, update the quantity
      if (isBox == true) {
        existingItem.boxcountincrement();
      } else if (isWeight == true) {
        existingItem.Weightincrement();
      } else {
        existingItem.unitincrement();
      }
    } else {
      // If item doesn't exist, add it to the cart
      if (isBox == true) {
        product.boxcountincrement();
      }
      if (isWeight == true) {
        product.Weightincrement();
      } else {
        product.unitincrement();
      }
      _cartItems.add(product);
    }
    // Notify listeners that the cart has changed
    _cartChangeController.add(true);
  }

  void removeFromCart({required Product product, bool? isBox, bool? isWeight}) {
    // Check if the item is already in the cart
    var existingItem = _cartItems
        .firstWhereOrNull((item) => item.productCode == product.productCode);

    if (existingItem != null) {
      // If item exists, update the quantity
      if (isBox == true) {
        existingItem.boxcountdecrement();
      } else if (isBox == true) {
        existingItem.Weightdecrement();
      } else {
        existingItem.unitdecrement();
      }
    }

    if (product.boxcount < 1 &&
        product.unitcount < 1 &&
        product.weightCount < 1) {
      _cartItems.removeWhere((item) => item.productCode == product.productCode);
    }
    // Notify listeners that the cart has changed
    _cartChangeController.add(true);
  }

  List<Product> get cartItems => _cartItems;

  final _cartChangeController = StreamController<bool>.broadcast();

  Stream<bool> get cartChangeStream => _cartChangeController.stream;

  void clearCart() {
    _cartItems.clear();
    _cartChangeController.add(true);
  }

  // Dispose the stream controller
  void dispose() {
    _cartChangeController.close();
  }
}
