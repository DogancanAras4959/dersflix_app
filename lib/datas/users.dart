import 'dart:convert';

List<Users> userFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String userToJson(List<Users> data) =>
    jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  int id;
  String userName;
  String password;
  String displayName;
  String image;
  bool isActive;
  int roleId;

  Users({
    required this.id,
    required this.userName,
    required this.password,
    required this.displayName,
    required this.image,
    required this.isActive,
    required this.roleId,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        userName: json["userName"],
        password: json["password"],
        displayName: json["displayName"],
        image: json["image"],
        roleId: json["roleId"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "password": password,
        "displayName": displayName,
        "image": image,
        "roleId": roleId,
        "isActive": isActive,
      };
}
