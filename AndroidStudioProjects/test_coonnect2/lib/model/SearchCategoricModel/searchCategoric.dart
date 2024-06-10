// To parse this JSON data, do
//
//     final scarchCategoricModel = scarchCategoricModelFromJson(jsonString);

import 'dart:convert';

ScarchCategoricModel scarchCategoricModelFromJson(String str) => ScarchCategoricModel.fromJson(json.decode(str));

String scarchCategoricModelToJson(ScarchCategoricModel data) => json.encode(data.toJson());

class ScarchCategoricModel {
  ScarchCategoricModel({
    this.error,
    this.type,
    this.msg,
  });

  int? error;
  String? type;
  List<Msg>? msg;

  factory ScarchCategoricModel.fromJson(Map<String, dynamic> json) => ScarchCategoricModel(
    error: json["error"],
    type: json["type"],
    msg: json["msg"] == null ? [] : List<Msg>.from(json["msg"]!.map((x) => Msg.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "type": type,
    "msg": msg == null ? [] : List<dynamic>.from(msg!.map((x) => x.toJson())),
  };
}

class Msg {
  Msg({
    this.catId,
    this.catName,
    this.catNameUrl,
    this.image,
    this.status,
    this.createdAt,
  });

  String? catId;
  String? catName;
  String? catNameUrl;
  String? image;
  String? status;
  dynamic createdAt;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    catId: json["cat_id"],
    catName: json["cat_name"],
    catNameUrl: json["cat_name_url"],
    image: json["image"],
    status: json["status"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "cat_name": catName,
    "cat_name_url": catNameUrl,
    "image": image,
    "status": status,
    "created_at": createdAt,
  };
}
