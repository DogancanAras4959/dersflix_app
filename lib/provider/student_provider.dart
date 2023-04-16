import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../data_constants.dart';
import '../datas/students.dart';

const urlApi = url;

class StudentProvider with ChangeNotifier {
  List<StudentsModel> studentList = [];

  StudentsModel? _studentsByStudentName;
  StudentsModel? get studentsByStudentName => _studentsByStudentName;

  getStudents() async {
    final url = Uri.http(urlApi, 'Student');
    final resp = await http.get(url, headers: {
      "Access.Control-Allow-Origin": "*",
      "Access.Control-Allow-Credentials": "true",
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    final response = studentFromJson(resp.body);
    studentList = response;
    notifyListeners();
  }

  getStudentsByName(String studentName) async {
    const studentPath = 'Student/getStudent';
    final Map<String, String> queryParameters = <String, String>{
      'studentName': studentName,
    };

    final url = Uri.http(urlApi, studentPath, queryParameters);
    final resp = await http.get(url, headers: {
      "Access.Control-Allow-Origin": "*",
      "Access.Control-Allow-Credentials": "true",
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (resp.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(resp.body);
      StudentsModel studentData = StudentsModel.fromJson(responseData);
      return _studentsByStudentName = studentData;
    } else {
      return null;
    }
  }

  insertStudentProvider(StudentsModel model) async {
    final url = Uri.https(urlApi, '/Student/PostStudent');

    Map<String, dynamic> body() {
      final Map<String, dynamic> data = <String, dynamic>{};

      data["isActive"] = true;
      data["image"] = model.image.toString();
      data["createdTime"] = DateTime.now().toIso8601String();
      data["updatedTime"] = DateTime.now().toIso8601String();
      data["countryId"] = model.countryId.toString();
      data["phone"] = model.phone.toString();
      data["studentName"] = model.studentName.toString();
      data["area"] = model.area.toString();
      data["branch"] = model.branch.toString();
      data["classLevel"] = model.classLevel.toString();
      data["school"] = model.school.toString();
      data["classLevel"] = model.classLevel.toString();
      data["parentName"] = model.parentName.toString();
      data["username"] = model.userName.toString();
      data["password"] = model.password.toString();
      data["parentAddress"] = model.parentAddress.toString();
      data["parentPhone"] = model.parentPhone.toString();
      data["userId"] = 1;
      data["user"] = null;
      data["placeId"] = 2;
      return data;
    }

    final resp = await http
        .post(
          url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode(body()),
          encoding: Encoding.getByName("utf-8"),
        )
        .timeout(const Duration(seconds: 10));

    if (resp.statusCode == 201) {
      print(resp.statusCode);
    } else {
      print(resp.body);
      throw Exception();
    }
  }
}
