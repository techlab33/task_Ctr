// To parse this JSON data, do
//
//     final followerModel = followerModelFromJson(jsonString);

import 'dart:convert';

FollowerModel followerModelFromJson(String str) => FollowerModel.fromJson(json.decode(str));

String followerModelToJson(FollowerModel data) => json.encode(data.toJson());

class FollowerModel {
  FollowerModel({
    this.error,
    this.msg,
  });

  int? error;
  Msg? msg;

  factory FollowerModel.fromJson(Map<String, dynamic> json) => FollowerModel(
    error: json["error"],
    msg: json["msg"] == null ? null : Msg.fromJson(json["msg"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg?.toJson(),
  };
}

class Msg {
  Msg({
    this.limit,
    this.offset,
    this.type,
    this.result,
  });

  String? limit;
  int? offset;
  String? type;
  List<Result>? result;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    limit: json["limit"],
    offset: json["offset"],
    type: json["type"],
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "limit": limit,
    "offset": offset,
    "type": type,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.followId,
    this.followingId,
    this.followerId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.fullName,
    this.companyName,
    this.phone,
    this.email,
    this.userName,
    this.password,
    this.typeReg,
    this.serviceArea,
    this.pic,
    this.nidStatus,
    this.nidFront,
    this.nidBack,
    this.address,
    this.verifiedMember,
    this.profileTagline,
    this.nidName,
    this.favorite,
    this.followStatus,
  });

  String? followId;
  String? followingId;
  String? followerId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;
  String? fullName;
  String? companyName;
  String? phone;
  String? email;
  dynamic userName;
  String? password;
  dynamic typeReg;
  String? serviceArea;
  dynamic pic;
  String? nidStatus;
  String? nidFront;
  String? nidBack;
  dynamic address;
  String? verifiedMember;
  String? profileTagline;
  dynamic nidName;
  dynamic favorite;
  String? followStatus;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    followId: json["follow_id"],
    followingId: json["following_id"],
    followerId: json["follower_id"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    userId: json["user_id"],
    fullName: json["full_name"],
    companyName: json["company_name"],
    phone: json["phone"],
    email: json["email"],
    userName: json["user_name"],
    password: json["password"],
    typeReg: json["type_reg"],
    serviceArea: json["service_area"],
    pic: json["pic"],
    nidStatus: json["nid_status"],
    nidFront: json["nid_front"],
    nidBack: json["nid_back"],
    address: json["address"],
    verifiedMember: json["verified_member"],
    profileTagline: json["profile_tagline"],
    nidName: json["nid_name"],
    favorite: json["favorite"],
    followStatus: json["follow_status"],
  );

  Map<String, dynamic> toJson() => {
    "follow_id": followId,
    "following_id": followingId,
    "follower_id": followerId,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user_id": userId,
    "full_name": fullName,
    "company_name": companyName,
    "phone": phone,
    "email": email,
    "user_name": userName,
    "password": password,
    "type_reg": typeReg,
    "service_area": serviceArea,
    "pic": pic,
    "nid_status": nidStatus,
    "nid_front": nidFront,
    "nid_back": nidBack,
    "address": address,
    "verified_member": verifiedMember,
    "profile_tagline": profileTagline,
    "nid_name": nidName,
    "favorite": favorite,
    "follow_status": followStatus,
  };
}

