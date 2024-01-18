import 'dart:convert';
import 'package:showd_delivery/model/TransactionDetail.dart';
import 'package:showd_delivery/model/categorylist.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/model/TransactionList.dart' as transactionModel;

class Transaction extends Chodee {
  static Future<List<transactionModel.Transaction>> getAllTransactionList({int? page = 1, int? limit = 50}) async {
    try {
      String response = await Chodee.requestAPI('/api/store/v1/transaction/list?page=$page&limit=$limit', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return transactionModel.transactionFromJson(jsonEncode(jsonResponse['data']));
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<TransactionDetail> getTransactionDetail({required String orderToken}) async {
    try {
      String response = await Chodee.requestAPI('/api/store/v1/transaction/$orderToken/Detail', 'GET');
      dynamic jsonResponse = jsonDecode(response);
      if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
        return transactionDetailFromJson(jsonEncode(jsonResponse['data']));
      }
      return TransactionDetail();
    } catch (e) {
      return TransactionDetail();
    }
  }
}
