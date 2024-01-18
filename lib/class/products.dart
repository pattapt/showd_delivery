import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showd_delivery/model/categorylist.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/model/AccountProfile.dart';
import 'package:showd_delivery/model/MerchantList.dart';
import 'package:showd_delivery/model/product.dart' as productModel;
import 'package:showd_delivery/model/productV2.dart' as productV2Model;
import 'package:showd_delivery/model/productV2.dart';

class Product extends Chodee {
  static Future<MerchantList> getMerchant() async {
    try {
      String response = await Chodee.requestAPI('/api/store/v1/merchant/list', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return merchantListFromJson(jsonEncode(jsonResponse['data']));
      }
      return MerchantList();
    } catch (e) {
      return MerchantList();
    }
  }

  static Future<MerchantDetail> getMerchantDetail({required String merchantToken}) async {
    try {
      String response = await Chodee.requestAPI('/api/store/v1/merchant/$merchantToken/info', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return merchantDetailFromJson(jsonEncode(jsonResponse['data']));
      }
      return MerchantDetail();
    } catch (e) {
      return MerchantDetail();
    }
  }

  static Future<List<Category>> getCategoryOfMerchant({required String merchantToken}) async {
    try {
      String response = await Chodee.requestAPI('/api/store/v1/merchant/${merchantToken}/category/all', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        List<Category> x = categoryListFromJson(jsonEncode(jsonResponse['data']));
        return x;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<productModel.Product> getProductDetail({required String merchantToken, required String productToken}) async {
    try {
      String response = await Chodee.requestAPI('/api/store/v1/merchant/${merchantToken}/product/$productToken/Detail', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return productModel.productDataFromJson(jsonEncode(jsonResponse['data']));
      }
      return productModel.Product();
    } catch (e) {
      return productModel.Product();
    }
  }

  static Future<List<productModel.Product>> getProductOfCategoryInMerchant({required String merchantToken, required String categoryToken, int? page = 1, int? limit = 50}) async {
    try {
      String response = await Chodee.requestAPI('/api/store/v1/merchant/${merchantToken}/category/GetProductsFromCategory/${categoryToken}?page=${page}&limit=${limit}', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return productModel.productFromJson(jsonEncode(jsonResponse['data']));
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<ProductV2> getProductOfCategoryInMerchantV2({required String merchantToken, required String categoryToken, int? page = 1, int? limit = 50}) async {
    try {
      String response = await Chodee.requestAPI('/api/store/v1/merchant/${merchantToken}/category/GetProductsFromCategory/${categoryToken}?page=${page}&limit=${limit}', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return productV2Model.productV2FromJson(response);
      }
      return ProductV2();
    } catch (e) {
      return ProductV2();
    }
  }

  static Future<List<productModel.Product>> searchProductOfCategoryInMerchant({required String keyWords, required String merchantToken, int? page = 1, int? limit = 50}) async {
    try {
      String response = await Chodee.requestAPI('/api/store/v1/merchant/${merchantToken}/category/SearchProducts?keywords=${keyWords}&page=${page}&limit=${limit}', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return productModel.productFromJson(jsonEncode(jsonResponse['data']));
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // static Future<dynamic> initLoginEmail(String email, String password) async {
  //   try {
  //     String timestamp = Chodee.getTimestamp();
  //     String deviceID = await Chodee.getDeviceID();
  //     Map<String, dynamic> deviceData = await Chodee.getDevicePostData();
  //     Map<String, dynamic> postData = {
  //       "email": email.toString(),
  //       "password": password.toString(),
  //       "role": "owner",
  //       "app_version": Chodee.appVersion,
  //       "timestamp": timestamp,
  //       "device_id": deviceID,
  //       "platform": Platform.isIOS ? "ios" : "android",
  //       ...deviceData
  //     };
  //     String response = await Chodee.requestAPI('/api/store/v1/auth/Login', 'POST', postData);
  //     dynamic jsonResponse = jsonDecode(response);
  //     if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
  //       setAccessToken(jsonResponse["data"]["access_token"]);
  //       setRefreshToken(jsonResponse["data"]["refresh_token"]);
  //       Auth.setIsLogin(true);
  //       Navigator.of(Chodee.context!).pushNamed('/home', arguments: 0);
  //     }
  //     return response;
  //   } catch (e) {
  //     // Chodee.showDailogCSG(
  //     //     "ไม่สามารถทำรายการได้", e.toString().replaceAll("Exception: ", ""), "ปิด");
  //   }
  // }
}
