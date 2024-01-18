// To parse this JSON data, do
//
//     final districtDataTh = districtDataThFromJson(jsonString);

import 'dart:convert';

List<DistrictDataTh> districtDataThFromJson(String str) => List<DistrictDataTh>.from(json.decode(str).map((x) => DistrictDataTh.fromJson(x)));

String districtDataThToJson(List<DistrictDataTh> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DistrictDataTh {
  final District? district;
  final Amphure? amphure;
  final Province? province;
  final String? zipcode;

  DistrictDataTh({
    this.district,
    this.amphure,
    this.province,
    this.zipcode,
  });

  factory DistrictDataTh.fromJson(Map<String, dynamic> json) => DistrictDataTh(
        district: json["district"] == null ? null : District.fromJson(json["district"]),
        amphure: json["amphure"] == null ? null : Amphure.fromJson(json["amphure"]),
        province: json["province"] == null ? null : Province.fromJson(json["province"]),
        zipcode: json["zipcode"],
      );

  Map<String, dynamic> toJson() => {
        "district": district?.toJson(),
        "amphure": amphure?.toJson(),
        "province": province?.toJson(),
        "zipcode": zipcode,
      };
}

class Amphure {
  final int? amphureId;
  final String? nameTh;
  final String? nameEn;

  Amphure({
    this.amphureId,
    this.nameTh,
    this.nameEn,
  });

  factory Amphure.fromJson(Map<String, dynamic> json) => Amphure(
        amphureId: json["amphure_id"],
        nameTh: json["name_th"],
        nameEn: json["name_en"],
      );

  Map<String, dynamic> toJson() => {
        "amphure_id": amphureId,
        "name_th": nameTh,
        "name_en": nameEn,
      };
}

class District {
  final int? districtId;
  final String? nameTh;
  final String? nameEn;

  District({
    this.districtId,
    this.nameTh,
    this.nameEn,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
        districtId: json["district_id"],
        nameTh: json["name_th"],
        nameEn: json["name_en"],
      );

  Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "name_th": nameTh,
        "name_en": nameEn,
      };
}

class Province {
  final int? provinceId;
  final String? nameTh;
  final String? nameEn;

  Province({
    this.provinceId,
    this.nameTh,
    this.nameEn,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        provinceId: json["province_id"],
        nameTh: json["name_th"],
        nameEn: json["name_en"],
      );

  Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "name_th": nameTh,
        "name_en": nameEn,
      };
}
