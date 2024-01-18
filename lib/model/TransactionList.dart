// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

List<Transaction> transactionFromJson(String str) => List<Transaction>.from(json.decode(str).map((x) => Transaction.fromJson(x)));

String transactionToJson(List<Transaction> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transaction {
  final int? orderId;
  final String? orderToken;
  final String? paymentMethod;
  final int? totalPay;
  final String? status;
  final String? note;
  final int? chatId;
  final DateTime? createDate;
  final DateTime? updateDate;
  final Merchant? merchant;

  Transaction({
    this.orderId,
    this.orderToken,
    this.paymentMethod,
    this.totalPay,
    this.status,
    this.note,
    this.chatId,
    this.createDate,
    this.updateDate,
    this.merchant,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        orderId: json["orderId"],
        orderToken: json["orderToken"],
        paymentMethod: json["paymentMethod"],
        totalPay: json["totalPay"],
        status: json["status"],
        note: json["note"],
        chatId: json["chatId"],
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
        merchant: json["merchant"] == null ? null : Merchant.fromJson(json["merchant"]),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "orderToken": orderToken,
        "paymentMethod": paymentMethod,
        "totalPay": totalPay,
        "status": status,
        "note": note,
        "chatId": chatId,
        "createDate": createDate?.toIso8601String(),
        "updateDate": updateDate?.toIso8601String(),
        "merchant": merchant?.toJson(),
      };
}

class Merchant {
  final int? merchantId;
  final String? merchantUuid;
  final int? ownerSellerId;
  final String? name;
  final String? description;
  final String? promptpayPhone;
  final bool? open;
  final bool? visible;
  final String? imageUrl;
  final String? address;
  final String? street;
  final String? building;
  final String? district;
  final String? amphure;
  final String? province;
  final String? zipcode;

  Merchant({
    this.merchantId,
    this.merchantUuid,
    this.ownerSellerId,
    this.name,
    this.description,
    this.promptpayPhone,
    this.open,
    this.visible,
    this.imageUrl,
    this.address,
    this.street,
    this.building,
    this.district,
    this.amphure,
    this.province,
    this.zipcode,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        merchantId: json["merchantId"],
        merchantUuid: json["merchantUUID"],
        ownerSellerId: json["ownerSellerId"],
        name: json["name"],
        description: json["description"],
        promptpayPhone: json["promptpayPhone"],
        open: json["open"],
        visible: json["visible"],
        imageUrl: json["imageUrl"],
        address: json["address"],
        street: json["street"],
        building: json["building"],
        district: json["district"],
        amphure: json["amphure"],
        province: json["province"],
        zipcode: json["zipcode"],
      );

  Map<String, dynamic> toJson() => {
        "merchantId": merchantId,
        "merchantUUID": merchantUuid,
        "ownerSellerId": ownerSellerId,
        "name": name,
        "description": description,
        "promptpayPhone": promptpayPhone,
        "open": open,
        "visible": visible,
        "imageUrl": imageUrl,
        "address": address,
        "street": street,
        "building": building,
        "district": district,
        "amphure": amphure,
        "province": province,
        "zipcode": zipcode,
      };
}
