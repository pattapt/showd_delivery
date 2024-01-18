// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

List<Message> messageFromJson(String str) => List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));
Message messageDetaillFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(List<Message> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
  final int? messageId;
  final Type? type;
  final DateTime? createAt;
  final Source? source;
  final MessageClass? message;

  Message({
    this.messageId,
    this.type,
    this.createAt,
    this.source,
    this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        messageId: json["messageId"],
        type: typeValues.map[json["type"]]!,
        createAt: json["createAt"] == null ? null : DateTime.parse(json["createAt"]),
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
        message: json["message"] == null ? null : MessageClass.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "type": typeValues.reverse[type],
        "createAt": createAt?.toIso8601String(),
        "source": source?.toJson(),
        "message": message?.toJson(),
      };
}

class MessageClass {
  final String? messageToken;
  final MessageType? messageType;
  final String? message;

  MessageClass({
    this.messageToken,
    this.messageType,
    this.message,
  });

  factory MessageClass.fromJson(Map<String, dynamic> json) => MessageClass(
        messageToken: json["messageToken"],
        messageType: messageTypeValues.map[json["messageType"]]!,
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "messageToken": messageToken,
        "messageType": messageTypeValues.reverse[messageType],
        "message": message,
      };
}

enum MessageType { IMAGE, MESSAGE }

final messageTypeValues = EnumValues({"Image": MessageType.IMAGE, "Message": MessageType.MESSAGE});

class Source {
  final int? chatMemberId;
  final String? memberUuid;
  final String? accountUuid;
  final int? accountId;
  final String? chatToken;
  final String? accountName;
  final AccountType? accountType;

  Source({
    this.chatMemberId,
    this.memberUuid,
    this.accountUuid,
    this.accountId,
    this.chatToken,
    this.accountName,
    this.accountType,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        chatMemberId: json["chatMemberId"],
        memberUuid: json["memberUUID"],
        accountUuid: json["accountUUID"],
        accountId: json["accountId"],
        chatToken: json["chatToken"],
        accountName: json["accountName"],
        accountType: accountTypeValues.map[json["accountType"]]!,
      );

  Map<String, dynamic> toJson() => {
        "chatMemberId": chatMemberId,
        "memberUUID": memberUuid,
        "accountUUID": accountUuid,
        "accountId": accountId,
        "chatToken": chatToken,
        "accountName": accountName,
        "accountType": accountTypeValues.reverse[accountType],
      };
}

enum AccountType { CUSTOMER, SELLER }

final accountTypeValues = EnumValues({"customer": AccountType.CUSTOMER, "seller": AccountType.SELLER});

enum Type { MESSAGE_RECEIVE, MESSAGE_SEND }

final typeValues = EnumValues({"messageReceive": Type.MESSAGE_RECEIVE, "messageSend": Type.MESSAGE_SEND});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
