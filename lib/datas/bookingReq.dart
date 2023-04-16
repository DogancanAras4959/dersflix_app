import 'dart:convert';

List<BookingReq> bookingReqFromJson(String str) =>
    List<BookingReq>.from(json.decode(str).map((x) => BookingReq.fromJson(x)));

String bookingReqToJson(List<BookingReq> data) =>
    jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingReq {
  int? id;
  String bookingTime;
  String studyName;
  String place;
  String teacherName;
  String studentName;
  String content;
  String tip;

  BookingReq({
    required this.id,
    required this.bookingTime,
    required this.studyName,
    required this.studentName,
    required this.teacherName,
    required this.tip,
    required this.place,
    required this.content,
  });

  factory BookingReq.fromJson(Map<String, dynamic> json) => BookingReq(
        id: json["id"],
        bookingTime: json["bookingTime"],
        studentName: json["studentName"],
        studyName: json["studyName"],
        teacherName: json["teacherName"],
        place: json["place"],
        tip: json["tip"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookingTime": bookingTime,
        "studentName": studentName,
        "studyName": studyName,
        "tip": tip,
        "teacherName": teacherName,
        "place": place,
        "content": content,
      };
}
