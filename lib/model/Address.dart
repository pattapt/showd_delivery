import 'dart:convert';

AddressDetail addressDetailFromJson(String str) => AddressDetail.fromJson(json.decode(str));
List<AddressDetail> addressListFromJson(String str) => List<AddressDetail>.from(json.decode(str).map((x) => AddressDetail.fromJson(x)));

String addressDetailToJson(AddressDetail data) => json.encode(data.toJson());

class AddressDetail {
  final int? destinationId;
  final String? destinationToken;
  final String? name;
  final String? phoneNumber;
  final String? status;
  final DateTime? createDate;
  final DateTime? updateDate;
  final AddressData? address;
  final String? note;

  AddressDetail({
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

  factory AddressDetail.fromJson(Map<String, dynamic> json) => AddressDetail(
        destinationId: json["destinationId"],
        destinationToken: json["destinationToken"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        status: json["status"],
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
        address: json["address"] == null ? null : AddressData.fromJson(json["address"]),
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

class AddressData {
  final String? address;
  final String? street;
  final String? building;
  final String? district;
  final int? districtId;
  final String? amphure;
  final String? province;
  final String? zipcode;

  AddressData({
    this.address,
    this.street,
    this.building,
    this.district,
    this.districtId,
    this.amphure,
    this.province,
    this.zipcode,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) => AddressData(
        address: json["address"],
        street: json["street"],
        building: json["building"],
        district: json["district"],
        districtId: json["district_id"],
        amphure: json["amphure"],
        province: json["province"],
        zipcode: json["zipcode"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "street": street,
        "building": building,
        "district": district,
        "district_id": districtId,
        "amphure": amphure,
        "province": province,
        "zipcode": zipcode,
      };
}
