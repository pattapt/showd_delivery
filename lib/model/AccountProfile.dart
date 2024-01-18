// To parse this JSON data, do
//
//     final accountProfileModel = accountProfileModelFromJson(jsonString);

import 'dart:convert';

AccountProfileModel accountProfileModelFromJson(String str) => AccountProfileModel.fromJson(json.decode(str));

String accountProfileModelToJson(AccountProfileModel data) => json.encode(data.toJson());

class AccountProfileModel {
  final int? accountId;
  final String? accountUuid;
  final String? username;
  final String? email;
  final String? profileImageUrl;
  final DateTime? registerDate;
  final DateTime? lastLoginDate;

  AccountProfileModel({
    this.accountId,
    this.accountUuid,
    this.username,
    this.email,
    this.profileImageUrl,
    this.registerDate,
    this.lastLoginDate,
  });

  factory AccountProfileModel.fromJson(Map<String, dynamic> json) => AccountProfileModel(
        accountId: json["account_id"],
        accountUuid: json["account_uuid"],
        username: json["username"],
        email: json["email"],
        profileImageUrl: json["profile_image_url"],
        registerDate: json["RegisterDate"] == null ? null : DateTime.parse(json["RegisterDate"]),
        lastLoginDate: json["LastLoginDate"] == null ? null : DateTime.parse(json["LastLoginDate"]),
      );

  Map<String, dynamic> toJson() => {
        "account_id": accountId,
        "account_uuid": accountUuid,
        "username": username,
        "email": email,
        "profile_image_url": profileImageUrl,
        "RegisterDate": registerDate?.toIso8601String(),
        "LastLoginDate": lastLoginDate?.toIso8601String(),
      };
}
