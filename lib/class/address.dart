import 'dart:convert';
import 'dart:io';
import 'package:showd_delivery/model/Address.dart';
import 'package:showd_delivery/model/CheckOutCart.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/model/DistrictDataTh.dart';
import 'package:showd_delivery/model/addAddress.dart';

class Address extends Chodee {
  static Future<List<AddressDetail>> getMyAddress() async {
    try {
      String response = await Chodee.requestAPI('/api/store/v1/profile/address/list', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return addressListFromJson(jsonEncode(jsonResponse['data']));
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<List<DistrictDataTh>> getDristrictFromZipcode({required String zipcode}) async {
    try {
      String response = await Chodee.requestAPI('/api/store/v1/Util/GetProvince?zipcode=$zipcode', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return districtDataThFromJson(jsonEncode(jsonResponse['data']));
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<AddressDetail> getAddressDetail({required String addressToken}) async {
    try {
      String response = await Chodee.requestAPI('/api/store/v1/profile/address/$addressToken/Detail', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return addressDetailFromJson(jsonEncode(jsonResponse['data']));
      }
      return AddressDetail();
    } catch (e) {
      return AddressDetail();
    }
  }

  static Future<bool> updateAddress(
      {required String addressToken,
      required String name,
      required String phoneNumber,
      bool? show = true,
      required String address,
      String? street,
      String? building,
      required int district,
      String? zipCode = "000000",
      String? note}) async {
    try {
      Map<String, dynamic> deviceData = await Chodee.getDevicePostData();
      Map<String, dynamic> postData = {
        "name": name,
        "phoneNumber": phoneNumber,
        "status": ((show ?? true) ? "show" : "delete"),
        "address": address,
        "street": street,
        "building": building,
        "district": district,
        "amphure": 1,
        "province": 1,
        "zipcode": zipCode,
        "note": note,
        ...deviceData
      };
      String response = await Chodee.requestAPI('/api/store/v1/profile/address/$addressToken/Update', 'POST', postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<AddAddress> createAddress(
      {required String name,
      required String phoneNumber,
      required String address,
      required String street,
      required String building,
      required int district,
      required String zipCode,
      required String note}) async {
    try {
      Map<String, dynamic> deviceData = await Chodee.getDevicePostData();
      Map<String, dynamic> postData = {
        "name": name,
        "phoneNumber": phoneNumber,
        "address": address,
        "street": street,
        "building": building,
        "district": district,
        "amphure": 1,
        "province": 1,
        "zipcode": zipCode,
        "note": note,
        ...deviceData
      };
      String response = await Chodee.requestAPI('/api/store/v1/profile/address/Create', 'POST', postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return addAddressFromJson(jsonEncode(jsonResponse['data']));
      }
      return AddAddress();
    } catch (e) {
      return AddAddress();
    }
  }
}
