import 'dart:convert';

List<Studies> studyFromJson(String str) =>
    List<Studies>.from(json.decode(str).map((x) => Studies.fromJson(x)));

String studyToJson(List<Studies> data) =>
    jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

class Studies {
  int id;
  String studyName;
  String type;

  Studies({
    required this.id,
    required this.studyName,
    required this.type,
  });

  factory Studies.fromJson(Map<String, dynamic> json) =>
      Studies(id: json["id"], studyName: json["studyName"], type: json["type"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "studyName": studyName, "type": type};
}
