// To parse this JSON data, do
//
//     final categoryList = categoryListFromJson(jsonString);

import 'dart:convert';

List<Category> categoryListFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryListToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  final int? categoryId;
  final String? categoryToken;
  final int? merchantId;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? status;
  final String? invisible;
  final DateTime? createDate;
  final DateTime? updateDate;

  Category({
    this.categoryId,
    this.categoryToken,
    this.merchantId,
    this.name,
    this.description,
    this.imageUrl,
    this.status,
    this.invisible,
    this.createDate,
    this.updateDate,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["categoryId"],
        categoryToken: json["categoryToken"],
        merchantId: json["merchantId"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        status: json["status"],
        invisible: json["invisible"],
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryToken": categoryToken,
        "merchantId": merchantId,
        "name": name,
        "description": description,
        "imageUrl": imageUrl,
        "status": status,
        "invisible": invisible,
        "createDate": createDate?.toIso8601String(),
        "updateDate": updateDate?.toIso8601String(),
      };
}
