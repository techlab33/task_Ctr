// To parse this JSON data, do
//
//     final categoryJobModel = categoryJobModelFromJson(jsonString);

import 'dart:convert';

CategoryJobModel categoryJobModelFromJson(String str) => CategoryJobModel.fromJson(json.decode(str));

String categoryJobModelToJson(CategoryJobModel data) => json.encode(data.toJson());

class CategoryJobModel {
  CategoryJobModel({
    this.error,
    this.msg,
  });

  int? error;
  List<Msg>? msg;

  factory CategoryJobModel.fromJson(Map<String, dynamic> json) => CategoryJobModel(
    error: json["error"],
    msg: json["msg"] == null ? [] : List<Msg>.from(json["msg"]!.map((x) => Msg.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg == null ? [] : List<dynamic>.from(msg!.map((x) => x.toJson())),
  };
}

class Msg {
  Msg({
    this.jobId,
    this.jobTitle,
    this.description,
    this.contactnumber,
    this.category,
    this.createdAt,
    this.status,
    this.createdBy,
    this.doc,
    this.sharelink,
    this.canapply,
    this.createdByName,
  });

  String? jobId;
  String? jobTitle;
  String? description;
  String? contactnumber;
  String? category;
  DateTime? createdAt;
  String? status;
  String? createdBy;
  Doc? doc;
  String? sharelink;
  int? canapply;
  String? createdByName;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    jobId: json["job_id"],
    jobTitle: json["job_title"],
    description: json["description"],
    contactnumber: json["contactnumber"],
    category: json["category"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    status: json["status"],
    createdBy: json["created_by"],
    doc: json["doc"] == null ? null : Doc.fromJson(json["doc"]),
    sharelink: json["sharelink"],
    canapply: json["canapply"],
    createdByName: json["created_by_name"],
  );

  Map<String, dynamic> toJson() => {
    "job_id": jobId,
    "job_title": jobTitle,
    "description": description,
    "contactnumber": contactnumber,
    "category": category,
    "created_at": createdAt?.toIso8601String(),
    "status": status,
    "created_by": createdBy,
    "doc": doc?.toJson(),
    "sharelink": sharelink,
    "canapply": canapply,
    "created_by_name": createdByName,
  };
}

class Doc {
  Doc({
    this.image,
    this.audio,
    this.video,
  });

  List<String>? image;
  List<String>? audio;
  List<String>? video;

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
    image: json["image"] == null ? [] : List<String>.from(json["image"]!.map((x) => x)),
    audio: json["audio"] == null ? [] : List<String>.from(json["audio"]!.map((x) => x)),
    video: json["video"] == null ? [] : List<String>.from(json["video"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
    "audio": audio == null ? [] : List<dynamic>.from(audio!.map((x) => x)),
    "video": video == null ? [] : List<dynamic>.from(video!.map((x) => x)),
  };
}
