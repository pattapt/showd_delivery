import 'dart:convert';
import 'dart:io';
import 'package:showd_delivery/model/Address.dart';
import 'package:showd_delivery/model/CheckOutCart.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/model/MessageList.dart';
import 'package:showd_delivery/model/addAddress.dart';

class Chat extends Chodee {
  static Future<List<Message>> getMessage({required String chatToken, int? page = 1, int? limit = 50}) async {
    try {
      String response = await Chodee.requestAPI('/api/store/v1/chat/$chatToken/Message?page=${page}&limit=${limit}', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return messageFromJson(jsonEncode(jsonResponse['data']));
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> sendTextMessage({required String chatToken, required int chatId, required String text}) async {
    try {
      Map<String, dynamic> deviceData = await Chodee.getDevicePostData();
      Map<String, dynamic> postData = {"chatId": chatId, "type": "Message", "message": text, ...deviceData};
      String response = await Chodee.requestAPI('/api/store/v1/chat/$chatToken/Send', 'POST', postData);
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
