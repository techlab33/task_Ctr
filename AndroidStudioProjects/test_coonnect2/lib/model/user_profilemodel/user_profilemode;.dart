// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
  UserProfileModel({
    this.error,
    this.msg,
  });

  int? error;
  Msg? msg;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
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
    this.userData,
    this.membership,
  });

  UserData? userData;
  Membership? membership;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    userData: json["user_data"] == null ? null : UserData.fromJson(json["user_data"]),
    membership: json["membership"] == null ? null : Membership.fromJson(json["membership"]),
  );

  Map<String, dynamic> toJson() => {
    "user_data": userData?.toJson(),
    "membership": membership?.toJson(),
  };
}

class Membership {
  Membership({
    this.membershipId,
    this.userId,
    this.packageId,
    this.packageName,
    this.startDate,
    this.endDate,
    this.status,
    this.payHistoryId,
    this.paymentStatus,
    this.paymentDetails,
    this.nextBillDate,
    this.createdAt,
  });

  String? membershipId;
  String? userId;
  String? packageId;
  String? packageName;
  String? startDate;
  String? endDate;
  String? status;
  String? payHistoryId;
  String? paymentStatus;
  String? paymentDetails;
  String? nextBillDate;
  String? createdAt;

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
    membershipId: json["membership_id"],
    userId: json["user_id"],
    packageId: json["package_id"],
    packageName: json["package_name"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    status: json["status"],
    payHistoryId: json["pay_history_id"],
    paymentStatus: json["payment_status"],
    paymentDetails: json["payment_details"],
    nextBillDate: json["next_bill_date"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "membership_id": membershipId,
    "user_id": userId,
    "package_id": packageId,
    "package_name": packageName,
    "start_date": startDate,
    "end_date": endDate,
    "status": status,
    "pay_history_id": payHistoryId,
    "payment_status": paymentStatus,
    "payment_details": paymentDetails,
    "next_bill_date": nextBillDate,
    "created_at": createdAt,
  };
}

class UserData {
  UserData({
    this.userId,
    this.fullName,
    this.companyName,
    this.phone,
    this.email,
    this.userName,
    this.password,
    this.typeReg,
    this.serviceArea,
    this.status,
    this.createdAt,
    this.pic,
    this.nidStatus,
    this.nidFront,
    this.nidBack,
    this.address,
    this.verifiedMember,
    this.profileTagline,
    this.nidName,
    this.favorite,
  });

  String? userId;
  String? fullName;
  String? companyName;
  String? phone;
  String? email;
  dynamic userName;
  String? password;
  dynamic typeReg;
  List<String>? serviceArea;
  String? status;
  DateTime? createdAt;
  String? pic;
  String? nidStatus;
  String? nidFront;
  String? nidBack;
  dynamic address;
  String? verifiedMember;
  String? profileTagline;
  dynamic nidName;
  dynamic favorite;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    userId: json["user_id"],
    fullName: json["full_name"],
    companyName: json["company_name"],
    phone: json["phone"],
    email: json["email"],
    userName: json["user_name"],
    password: json["password"],
    typeReg: json["type_reg"],
    serviceArea: json["service_area"] == null ? [] : List<String>.from(json["service_area"]!.map((x) => x)),
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    pic: json["pic"],
    nidStatus: json["nid_status"],
    nidFront: json["nid_front"],
    nidBack: json["nid_back"],
    address: json["address"],
    verifiedMember: json["verified_member"],
    profileTagline: json["profile_tagline"],
    nidName: json["nid_name"],
    favorite: json["favorite"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "full_name": fullName,
    "company_name": companyName,
    "phone": phone,
    "email": email,
    "user_name": userName,
    "password": password,
    "type_reg": typeReg,
    "service_area": serviceArea == null ? [] : List<dynamic>.from(serviceArea!.map((x) => x)),
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "pic": pic,
    "nid_status": nidStatus,
    "nid_front": nidFront,
    "nid_back": nidBack,
    "address": address,
    "verified_member": verifiedMember,
    "profile_tagline": profileTagline,
    "nid_name": nidName,
    "favorite": favorite,
  };
}
