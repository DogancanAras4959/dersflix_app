import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../data_constants.dart';
import '../datas/studies.dart';

const urlApi = url;

class StudyProvider with ChangeNotifier {
  List<Studies> studyList = [];

  Studies? _studyByStudyName;

  Studies? get studyByStudyName => _studyByStudyName;

  getStudies() async {
    final url = Uri.http(urlApi, '/Study');
    final resp = await http.get(url, headers: {
      "Access.Control-Allow-Origin": "*",
      "Access.Control-Allow-Credentials": "true",
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    final response = studyFromJson(resp.body);
    studyList = response;
    notifyListeners();
  }

  getStudiesByName(String studyName) async {
    const studiesPath = '/Study/getStudy';
    final Map<String, String> queryParameters = <String, String>{
      'studyName': studyName,
    };

    final url = Uri.http(urlApi, studiesPath, queryParameters);
    final resp = await http.get(url, headers: {
      "Access.Control-Allow-Origin": "*",
      "Access.Control-Allow-Credentials": "true",
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (resp.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(resp.body);
      Studies studyData = Studies.fromJson(responseData);
      return _studyByStudyName = studyData;
    } else {
      return null;
    }
  }
}
