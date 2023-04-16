import 'dart:convert';

import 'package:dersflix_app/datas/users.dart';

List<StudentsModel> studentFromJson(String str) => List<StudentsModel>.from(
    json.decode(str).map((x) => StudentsModel.fromJson(x)));

String studentToJson(List<StudentsModel> data) =>
    jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentsModel {
  int? id;
  String studentName;
  String image;
  String userName;
  String password;
  String classLevel;
  String countryId;
  String branch;
  String phone;
  String area;
  String school;
  String parentName;
  String parentPhone;
  String parentAddress;
  Users? user;
  int userId;
  bool isActive;

  StudentsModel({
    required this.id,
    required this.isActive,
    required this.userName,
    required this.password,
    required this.image,
    required this.studentName,
    required this.countryId,
    required this.classLevel,
    required this.branch,
    required this.phone,
    required this.area,
    required this.user,
    required this.school,
    required this.parentName,
    required this.parentPhone,
    required this.parentAddress,
    required this.userId,
  });

  factory StudentsModel.fromJson(Map<String, dynamic> json) => StudentsModel(
      id: json["id"],
      isActive: json["isActive"],
      studentName: json["studentName"],
      image: json["image"],
      countryId: json["countryId"],
      classLevel: json["classLevel"],
      branch: json["branch"],
      userName: json["userName"],
      password: json["password"],
      phone: json["phone"],
      area: json["area"],
      school: json["school"],
      parentName: json["parentName"],
      user: json["user"] != null ? Users.fromJson(json["user"]) : null,
      parentPhone: json["parentPhone"],
      parentAddress: json["parentAddress"],
      userId: json["userId"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "studentName": studentName,
        "isActive": isActive,
        "image": image,
        "countryId": countryId,
        "classLevel": classLevel,
        "branch": branch,
        "phone": phone,
        "username": userName,
        "password": password,
        "area": area,
        "school": school,
        "user": user,
        "parentName": parentName,
        "parentPhone": parentPhone,
        "parentAddress": parentAddress,
        "userId": userId,
      };
}
