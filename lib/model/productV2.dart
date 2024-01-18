// To parse this JSON data, do
//
//     final productV2 = productV2FromJson(jsonString);

import 'dart:convert';

ProductV2 productV2FromJson(String str) => ProductV2.fromJson(json.decode(str));

String productV2ToJson(ProductV2 data) => json.encode(data.toJson());

class ProductV2 {
  final int? statusCode;
  final String? status;
  final String? msg;
  final List<Datum>? data;

  ProductV2({
    this.statusCode,
    this.status,
    this.msg,
    this.data,
  });

  factory ProductV2.fromJson(Map<String, dynamic> json) => ProductV2(
        statusCode: json["status_code"],
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final int? productId;
  final String? productToken;
  final String? barcode;
  final int? productCategoryId;
  final String? name;
  final String? description;
  final String? imageUrl;
  final double? price;
  final int? quantity;
  final Status? status;
  final DateTime? createDate;
  final DateTime? updateDate;

  Datum({
    this.productId,
    this.productToken,
    this.barcode,
    this.productCategoryId,
    this.name,
    this.description,
    this.imageUrl,
    this.price,
    this.quantity,
    this.status,
    this.createDate,
    this.updateDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        productId: json["productId"],
        productToken: json["productToken"],
        barcode: json["barcode"],
        productCategoryId: json["productCategoryId"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        price: json["price"]?.toDouble(),
        quantity: json["quantity"],
        status: statusValues.map[json["status"]]!,
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productToken": productToken,
        "barcode": barcode,
        "productCategoryId": productCategoryId,
        "name": name,
        "description": description,
        "imageUrl": imageUrl,
        "price": price,
        "quantity": quantity,
        "status": statusValues.reverse[status],
        "createDate": createDate?.toIso8601String(),
        "updateDate": updateDate?.toIso8601String(),
      };
}

enum Status { AVAILABLE }

final statusValues = EnumValues({"available": Status.AVAILABLE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
