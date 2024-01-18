// To parse this JSON data, do
//
//     final transactionDetail = transactionDetailFromJson(jsonString);

import 'dart:convert';

TransactionDetail transactionDetailFromJson(String str) => TransactionDetail.fromJson(json.decode(str));

String transactionDetailToJson(TransactionDetail data) => json.encode(data.toJson());

class TransactionDetail {
  final int? orderId;
  final String? orderToken;
  final String? paymentMethod;
  final int? totalPay;
  final String? status;
  final String? note;
  final int? destinationId;
  final int? chatId;
  final DateTime? createDate;
  final DateTime? updateDate;
  final Merchant? merchant;
  final Chat? chat;
  final ChatProfile? chatProfile;
  final Destination? destination;
  final Items? items;

  TransactionDetail({
    this.orderId,
    this.orderToken,
    this.paymentMethod,
    this.totalPay,
    this.status,
    this.note,
    this.destinationId,
    this.chatId,
    this.createDate,
    this.updateDate,
    this.merchant,
    this.chat,
    this.chatProfile,
    this.destination,
    this.items,
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) => TransactionDetail(
        orderId: json["orderId"],
        orderToken: json["orderToken"],
        paymentMethod: json["paymentMethod"],
        totalPay: json["totalPay"],
        status: json["status"],
        note: json["note"],
        destinationId: json["destinationId"],
        chatId: json["chatId"],
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
        merchant: json["merchant"] == null ? null : Merchant.fromJson(json["merchant"]),
        chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
        chatProfile: json["chatProfile"] == null ? null : ChatProfile.fromJson(json["chatProfile"]),
        destination: json["destination"] == null ? null : Destination.fromJson(json["destination"]),
        items: json["items"] == null ? null : Items.fromJson(json["items"]),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "orderToken": orderToken,
        "paymentMethod": paymentMethod,
        "totalPay": totalPay,
        "status": status,
        "note": note,
        "destinationId": destinationId,
        "chatId": chatId,
        "createDate": createDate?.toIso8601String(),
        "updateDate": updateDate?.toIso8601String(),
        "merchant": merchant?.toJson(),
        "chat": chat?.toJson(),
        "chatProfile": chatProfile?.toJson(),
        "destination": destination?.toJson(),
        "items": items?.toJson(),
      };
}

class ChatProfile {
  final int? memberId;
  final String? memberUUID;

  ChatProfile({
    this.memberId,
    this.memberUUID,
  });

  factory ChatProfile.fromJson(Map<String, dynamic> json) => ChatProfile(
        memberId: json["memberId"],
        memberUUID: json["memberUUID"],
      );

  Map<String, dynamic> toJson() => {
        "memberId": memberId,
        "memberUUID": memberUUID,
      };
}

class Chat {
  final int? chatId;
  final String? chatToken;
  final bool? open;
  final DateTime? createDate;
  final DateTime? lastTalkDate;

  Chat({
    this.chatId,
    this.chatToken,
    this.open,
    this.createDate,
    this.lastTalkDate,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        chatId: json["chatId"],
        chatToken: json["chatToken"],
        open: json["open"],
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        lastTalkDate: json["lastTalkDate"] == null ? null : DateTime.parse(json["lastTalkDate"]),
      );

  Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "chatToken": chatToken,
        "open": open,
        "createDate": createDate?.toIso8601String(),
        "lastTalkDate": lastTalkDate?.toIso8601String(),
      };
}

class Destination {
  final int? destinationId;
  final String? destinationToken;
  final String? name;
  final String? phoneNumber;
  final String? status;
  final DateTime? createDate;
  final DateTime? updateDate;
  final Address? address;
  final String? note;

  Destination({
    this.destinationId,
    this.destinationToken,
    this.name,
    this.phoneNumber,
    this.status,
    this.createDate,
    this.updateDate,
    this.address,
    this.note,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        destinationId: json["destinationId"],
        destinationToken: json["destinationToken"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        status: json["status"],
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "destinationId": destinationId,
        "destinationToken": destinationToken,
        "name": name,
        "phoneNumber": phoneNumber,
        "status": status,
        "createDate": createDate?.toIso8601String(),
        "updateDate": updateDate?.toIso8601String(),
        "address": address?.toJson(),
        "note": note,
      };
}

class Address {
  final String? address;
  final String? street;
  final String? building;
  final String? district;
  final String? amphure;
  final String? province;
  final String? zipcode;

  Address({
    this.address,
    this.street,
    this.building,
    this.district,
    this.amphure,
    this.province,
    this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        street: json["street"],
        building: json["building"],
        district: json["district"],
        amphure: json["amphure"],
        province: json["province"],
        zipcode: json["zipcode"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "street": street,
        "building": building,
        "district": district,
        "amphure": amphure,
        "province": province,
        "zipcode": zipcode,
      };
}

class Items {
  final int? totalPrice;
  final int? amount;
  final List<Cart>? cart;

  Items({
    this.totalPrice,
    this.amount,
    this.cart,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        totalPrice: json["totalPrice"],
        amount: json["amount"],
        cart: json["cart"] == null ? [] : List<Cart>.from(json["cart"]!.map((x) => Cart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalPrice": totalPrice,
        "amount": amount,
        "cart": cart == null ? [] : List<dynamic>.from(cart!.map((x) => x.toJson())),
      };
}

class Cart {
  final int? cartId;
  final String? cartToken;
  final int? amount;
  final int? totalPrice;
  final String? status;
  final DateTime? createDate;
  final DateTime? updateDate;
  final Product? product;
  final String? note;

  Cart({
    this.cartId,
    this.cartToken,
    this.amount,
    this.totalPrice,
    this.status,
    this.createDate,
    this.updateDate,
    this.product,
    this.note,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        cartId: json["cartId"],
        cartToken: json["cartToken"],
        amount: json["amount"],
        totalPrice: json["totalPrice"],
        status: json["status"],
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "cartId": cartId,
        "cartToken": cartToken,
        "amount": amount,
        "totalPrice": totalPrice,
        "status": status,
        "createDate": createDate?.toIso8601String(),
        "updateDate": updateDate?.toIso8601String(),
        "product": product?.toJson(),
        "note": note,
      };
}

class Product {
  final int? productId;
  final String? productToken;
  final String? name;
  final String? imageUrl;
  final int? price;
  final bool? available;
  final bool? visible;

  Product({
    this.productId,
    this.productToken,
    this.name,
    this.imageUrl,
    this.price,
    this.available,
    this.visible,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        productToken: json["productToken"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        price: json["price"],
        available: json["available"],
        visible: json["visible"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productToken": productToken,
        "name": name,
        "imageUrl": imageUrl,
        "price": price,
        "available": available,
        "visible": visible,
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
