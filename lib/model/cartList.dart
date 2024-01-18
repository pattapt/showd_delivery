// To parse this JSON data, do
//
//     final cartList = cartListFromJson(jsonString);

import 'dart:convert';

CartList cartListFromJson(String str) => CartList.fromJson(json.decode(str));

String cartListToJson(CartList data) => json.encode(data.toJson());

class CartList {
  final int? totalPrice;
  final int? amount;
  final List<CartData>? cart;

  CartList({
    this.totalPrice,
    this.amount,
    this.cart,
  });

  factory CartList.fromJson(Map<String, dynamic> json) => CartList(
        totalPrice: json["totalPrice"],
        amount: json["amount"],
        cart: json["cart"] == null ? [] : List<CartData>.from(json["cart"]!.map((x) => CartData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalPrice": totalPrice,
        "amount": amount,
        "cart": cart == null ? [] : List<dynamic>.from(cart!.map((x) => x.toJson())),
      };
}

class CartData {
  final int? cartId;
  final String? cartToken;
  final int? amount;
  final int? totalPrice;
  final String? status;
  final DateTime? createDate;
  final DateTime? updateDate;
  final ProductInCart? product;
  final String? note;

  CartData({
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

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
        cartId: json["cartId"],
        cartToken: json["cartToken"],
        amount: json["amount"],
        totalPrice: json["totalPrice"],
        status: json["status"],
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
        product: json["product"] == null ? null : ProductInCart.fromJson(json["product"]),
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

class ProductInCart {
  final int? productId;
  final String? productToken;
  final String? name;
  final String? description;
  final String? imageUrl;
  final int? price;
  final bool? available;
  final bool? visible;

  ProductInCart({
    this.productId,
    this.productToken,
    this.name,
    this.description,
    this.imageUrl,
    this.price,
    this.available,
    this.visible,
  });

  factory ProductInCart.fromJson(Map<String, dynamic> json) => ProductInCart(
        productId: json["productId"],
        productToken: json["productToken"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        price: json["price"],
        available: json["available"],
        visible: json["visible"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productToken": productToken,
        "name": name,
        "description": description,
        "imageUrl": imageUrl,
        "price": price,
        "available": available,
        "visible": visible,
      };
}
