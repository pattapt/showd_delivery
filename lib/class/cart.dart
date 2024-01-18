import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showd_delivery/model/CheckOutCart.dart';
import 'package:showd_delivery/model/cartList.dart';
import 'package:showd_delivery/model/categorylist.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/model/AccountProfile.dart';
import 'package:showd_delivery/model/MerchantList.dart';
import 'package:showd_delivery/model/product.dart' as productModel;

class Cart extends Chodee {
  static Future<CartList> getMyCart() async {
    try {
      String response = await Chodee.requestAPI('/api/store/v1/cart/list', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return cartListFromJson(jsonEncode(jsonResponse['data']));
      }
      return CartList();
    } catch (e) {
      return CartList();
    }
  }

  static Future<bool> addItemCart({required int productId, required String productToken, required int amount, String? note}) async {
    try {
      Map<String, dynamic> deviceData = await Chodee.getDevicePostData();
      Map<String, dynamic> postData = {"itemId": productId, "amount": amount, "note": note, "platform": Platform.isIOS ? "ios" : "android", ...deviceData};
      String response = await Chodee.requestAPI('/api/store/v1/cart/add/$productToken', 'POST', postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateMyCart({required int cartId, required String cartToken, required int amount, String? note}) async {
    try {
      Map<String, dynamic> deviceData = await Chodee.getDevicePostData();
      Map<String, dynamic> postData = {"cartId": cartId, "amount": amount, "note": note, ...deviceData};
      String response = await Chodee.requestAPI('/api/store/v1/cart/update/$cartToken', 'POST', postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<CheckOutCart> checkOutMyCart({required int destinationId, required String paymentMethod, String? note}) async {
    try {
      Map<String, dynamic> deviceData = await Chodee.getDevicePostData();
      Map<String, dynamic> postData = {"paymentMethod": paymentMethod, "destinationId": destinationId, "note": note, ...deviceData};
      String response = await Chodee.requestAPI('/api/store/v1/cart/checkOut', 'POST', postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return checkOutCartFromJson(jsonEncode(jsonResponse['data']));
      }
      return CheckOutCart();
    } catch (e) {
      return CheckOutCart();
    }
  }
}
