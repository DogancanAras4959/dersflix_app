import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../data_constants.dart';
import '../datas/users.dart';

const urlApi = url;

class UserProvider with ChangeNotifier {
  List<Users> userList = [];

  Users? _userByUserName;
  Users? get userByUserName => _userByUserName;

  UserProvider() {
    getUsers();
    getUserByUserName("");
  }

  getUsers() async {
    final url1 = Uri.http(urlApi, 'User');
    final resp = await http.get(url1, headers: {
      "Access.Control-Allow-Origin": "*",
      "Access.Control-Allow-Credentials": "true",
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    final response = userFromJson(resp.body);
    userList = response;
    notifyListeners();
  }

  getUserByUserName(String userName) async {
    const userPath = 'User/getUser';
    final Map<String, String> queryParameters = <String, String>{
      'userName': userName,
    };

    final url1 = Uri.http(urlApi, userPath, queryParameters);
    final resp = await http.get(url1, headers: {
      "Access.Control-Allow-Origin": "*",
      "Access.Control-Allow-Credentials": "true",
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (resp.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(resp.body);
      Users userData = Users.fromJson(responseData);
      return _userByUserName = userData;
    } else {
      return null;
    }
  }
}
