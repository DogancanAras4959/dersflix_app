import 'dart:convert';

List<Booking> bookingFromJson(String str) =>
    List<Booking>.from(json.decode(str).map((x) => Booking.fromJson(x)));

String bookingToJson(List<Booking> data) =>
    jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

class Booking {
  int id;
  String bookingName;
  String bookingTime;
  String bookingCode;
  String studyName;
  String tip;
  String userName;
  String studentName;

  Booking({
    required this.id,
    required this.bookingName,
    required this.bookingTime,
    required this.tip,
    required this.bookingCode,
    required this.studyName,
    required this.studentName,
    required this.userName,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        bookingName: json["bookingName"],
        bookingTime: json["bookingTime"],
        bookingCode: json["bookingCode"],
        studentName: json["studentName"],
        studyName: json["studyName"],
        tip: json["tip"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookingName": bookingName,
        "bookingTime": bookingTime,
        "bookingCode": bookingCode,
        "tip": tip,
        "studentName": studentName,
        "studyName": studyName,
        "userName": userName
      };
}
