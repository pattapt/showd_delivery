// To parse this JSON data, do
//
//     final addAddress = addAddressFromJson(jsonString);

import 'dart:convert';

AddAddress addAddressFromJson(String str) => AddAddress.fromJson(json.decode(str));

String addAddressToJson(AddAddress data) => json.encode(data.toJson());

class AddAddress {
  final bool? success;
  final int? destinationId;
  final String? destinationToken;

  AddAddress({
    this.success,
    this.destinationId,
    this.destinationToken,
  });

  factory AddAddress.fromJson(Map<String, dynamic> json) => AddAddress(
        success: json["success"],
        destinationId: json["destinationId"],
        destinationToken: json["destinationToken"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "destinationId": destinationId,
        "destinationToken": destinationToken,
      };
}
