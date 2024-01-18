// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));
Product productDataFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  final int? productId;
  final String? productToken;
  final String? barcode;
  final int? productCategoryId;
  final String? name;
  final String? description;
  final String? imageUrl;
  final int? price;
  final int? quantity;
  final String? status;
  final DateTime? createDate;
  final DateTime? updateDate;

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        productToken: json["productToken"],
        barcode: json["barcode"],
        productCategoryId: json["productCategoryId"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        price: json["price"],
        quantity: json["quantity"],
        status: json["status"],
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
        "status": status,
        "createDate": createDate?.toIso8601String(),
        "updateDate": updateDate?.toIso8601String(),
      };
}
