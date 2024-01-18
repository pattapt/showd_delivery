// To parse this JSON data, do
//
//     final checkOutCart = checkOutCartFromJson(jsonString);

import 'dart:convert';

CheckOutCart checkOutCartFromJson(String str) => CheckOutCart.fromJson(json.decode(str));

String checkOutCartToJson(CheckOutCart data) => json.encode(data.toJson());

class CheckOutCart {
  final bool? success;
  final int? transactionId;
  final String? transactionToken;
  final String? qrCodePayment;
  final Chat? chat;

  CheckOutCart({
    this.success,
    this.transactionId,
    this.transactionToken,
    this.qrCodePayment,
    this.chat,
  });

  factory CheckOutCart.fromJson(Map<String, dynamic> json) => CheckOutCart(
        success: json["success"],
        transactionId: json["transactionId"],
        transactionToken: json["transactionToken"],
        qrCodePayment: json["qrCodePayment"],
        chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "transactionId": transactionId,
        "transactionToken": transactionToken,
        "qrCodePayment": qrCodePayment,
        "chat": chat?.toJson(),
      };
}

class Chat {
  final int? chatId;
  final String? chatToken;

  Chat({
    this.chatId,
    this.chatToken,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        chatId: json["chatId"],
        chatToken: json["chatToken"],
      );

  Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "chatToken": chatToken,
      };
}
