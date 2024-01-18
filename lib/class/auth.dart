import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/model/AccountProfile.dart';

class Auth extends Chodee {
  static void setRefreshToken(String refreshToken) {
    final storage = FlutterSecureStorage();
    storage.write(key: 'refreshToken', value: refreshToken);
  }

  static Future<String?> getRefreshToken() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: 'refreshToken');
  }

  static void setAccessToken(String accessToken) {
    final storage = FlutterSecureStorage();
    storage.write(key: 'accessToken', value: accessToken);
  }

  static Future<String?> getAccessToken() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: 'accessToken');
  }

  static void setIsLogin(bool isLogin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLogin", isLogin);
  }

  static Future<bool?> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? false;
  }

  static Future<bool> grantAccessToken() async {
    try {
      String timestamp = Chodee.getTimestamp();
      String deviceID = await Chodee.getDeviceID();
      Map<String, dynamic> deviceData = await Chodee.getDevicePostData();
      Map<String, dynamic> postData = {
        "refreshToken": await Auth.getRefreshToken() ?? "",
        "uuid": "-",
        "type": "grantAccess",
        "app_version": Chodee.appVersion,
        "timestamp": timestamp,
        "device_id": deviceID,
        "platform": Platform.isIOS ? "ios" : "android",
        ...deviceData
      };
      String response = await Chodee.requestAPI('/api/store/v1/auth/InvokeAccessToken', 'POST', postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        setAccessToken(jsonResponse["data"]["access_token"]);
        return true;
      }
      return false;
    } catch (e) {
      Chodee.showDailogCSG("ไม่สามารถทำรายการได้", e.toString().replaceAll("Exception: ", ""), "ปิด");
      return false;
    }
  }

  static Future<bool> initRegisterEmail(String email, String password, String username) async {
    try {
      String timestamp = Chodee.getTimestamp();
      String deviceID = await Chodee.getDeviceID();
      Map<String, dynamic> deviceData = await Chodee.getDevicePostData();
      Map<String, dynamic> postData = {
        "email": email.toString(),
        "password": password.toString(),
        "username": username,
        "app_version": Chodee.appVersion,
        "timestamp": timestamp,
        "device_id": deviceID,
        "platform": Platform.isIOS ? "ios" : "android",
        ...deviceData
      };

      String response = await Chodee.requestAPI('/api/store/v1/auth/registerAccount', 'POST', postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        Chodee.showDailogCSG("สมัครสมาชิกสำเร็จ", "ท่านได้ทำการสมัครสมาชิกสำเร็จแล้วกรูณาทำการเข้าสู่ระบบเพื่อใช้งาน", "เข้าสู่ระบบ", () {
          Navigator.of(Chodee.context!).pop();
          Navigator.of(Chodee.context!).pop();
        });
        return true;
      }
      return false;
    } catch (e) {
      Chodee.showDailogCSG("ไม่สามารถทำรายการได้", e.toString().replaceAll("Exception: ", ""), "ปิด");
      return false;
    }
  }

  static Future<dynamic> initLoginEmail(String email, String password) async {
    try {
      String timestamp = Chodee.getTimestamp();
      String deviceID = await Chodee.getDeviceID();
      Map<String, dynamic> deviceData = await Chodee.getDevicePostData();
      Map<String, dynamic> postData = {
        "email": email.toString(),
        "password": password.toString(),
        "role": "owner",
        "app_version": Chodee.appVersion,
        "timestamp": timestamp,
        "device_id": deviceID,
        "platform": Platform.isIOS ? "ios" : "android",
        ...deviceData
      };
      String response = await Chodee.requestAPI('/api/store/v1/auth/Login', 'POST', postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        setAccessToken(jsonResponse["data"]["access_token"]);
        setRefreshToken(jsonResponse["data"]["refresh_token"]);
        Auth.setIsLogin(true);
        Navigator.of(Chodee.context!).pushNamed('/home', arguments: 0);
      }
      return response;
    } catch (e) {
      // Chodee.showDailogCSG(
      //     "ไม่สามารถทำรายการได้", e.toString().replaceAll("Exception: ", ""), "ปิด");
    }
  }

  static Future<AccountProfileModel> getProfile() async {
    try {
      String response = await Chodee.requestAPI('/api/store/v1/profile/GetProfile', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return accountProfileModelFromJson(jsonEncode(jsonResponse['data']));
      }
      return AccountProfileModel();
    } catch (e) {
      return AccountProfileModel();
    }
  }
}
