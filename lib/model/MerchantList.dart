// To parse this JSON data, do
//
//     final merchantList = merchantListFromJson(jsonString);

import 'dart:convert';

MerchantList merchantListFromJson(String str) => MerchantList.fromJson(json.decode(str));

String merchantListToJson(MerchantList data) => json.encode(data.toJson());

class MerchantList {
  final int? pageId;
  final int? totalPage;
  final int? totalItem;
  final List<MerchantDetail>? merchants;

  MerchantList({
    this.pageId,
    this.totalPage,
    this.totalItem,
    this.merchants,
  });

  factory MerchantList.fromJson(Map<String, dynamic> json) => MerchantList(
        pageId: json["pageId"],
        totalPage: json["totalPage"],
        totalItem: json["totalItem"],
        merchants: json["merchants"] == null ? [] : List<MerchantDetail>.from(json["merchants"]!.map((x) => MerchantDetail.fromJson(x))),
      );

  get length => null;

  Map<String, dynamic> toJson() => {
        "pageId": pageId,
        "totalPage": totalPage,
        "totalItem": totalItem,
        "merchants": merchants == null ? [] : List<dynamic>.from(merchants!.map((x) => x.toJson())),
      };
}

MerchantDetail merchantDetailFromJson(String str) => MerchantDetail.fromJson(json.decode(str));

String merchantDetailToJson(MerchantDetail data) => json.encode(data.toJson());

class MerchantDetail {
  final int? id;
  final String? uuid;
  final String? name;
  final String? description;
  final bool? open;
  final bool? visible;
  final String? imageUrl;
  final Address? address;
  final DateTime? createDate;
  final DateTime? updateDate;

  MerchantDetail({
    this.id,
    this.uuid,
    this.name,
    this.description,
    this.open,
    this.visible,
    this.imageUrl,
    this.address,
    this.createDate,
    this.updateDate,
  });

  factory MerchantDetail.fromJson(Map<String, dynamic> json) => MerchantDetail(
        id: json["id"],
        uuid: json["uuid"],
        name: json["name"],
        description: json["description"],
        open: json["open"],
        visible: json["visible"],
        imageUrl: json["image_url"],
        address: json["Address"] == null ? null : Address.fromJson(json["Address"]),
        createDate: json["CreateDate"] == null ? null : DateTime.parse(json["CreateDate"]),
        updateDate: json["UpdateDate"] == null ? null : DateTime.parse(json["UpdateDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "name": name,
        "description": description,
        "open": open,
        "visible": visible,
        "image_url": imageUrl,
        "Address": address?.toJson(),
        "CreateDate": createDate?.toIso8601String(),
        "UpdateDate": updateDate?.toIso8601String(),
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
