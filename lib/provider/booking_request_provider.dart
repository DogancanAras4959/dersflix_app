import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../data_constants.dart';
import '../datas/bookingReq.dart';

const urlApi = url;

class BookingReqProvider with ChangeNotifier {
  List<BookingReq> bookingReqList = [];

  BookingReq? _bookingReqByBookingId;

  BookingReq? get bookingReqByBookingId => _bookingReqByBookingId;

  getBookingReqs() async {
    final url = Uri.http(urlApi, '/BookingRequest');
    final resp = await http.get(url, headers: {
      "Access.Control-Allow-Origin": "*",
      "Access.Control-Allow-Credentials": "true",
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    final response = bookingReqFromJson(resp.body);
    bookingReqList = response;
    notifyListeners();
  }

  getBookingReqById(String id) async {
    const bookingReqPath = '/BookingRequest/getBookingReq';
    final Map<String, String> queryParameters = <String, String>{
      'id': id,
    };

    final url = Uri.http(urlApi, bookingReqPath, queryParameters);
    final resp = await http.get(url, headers: {
      "Access.Control-Allow-Origin": "*",
      "Access.Control-Allow-Credentials": "true",
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (resp.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(resp.body);
      BookingReq bookingReqData = BookingReq.fromJson(responseData);
      return _bookingReqByBookingId = bookingReqData;
    } else {
      return null;
    }
  }

  insertBookingRequestProvider(BookingReq model) async {
    final url = Uri.https(urlApi, '/BookingRequest/PostBookingRequesting');

    String convertBookingTimeData() {
      String dateTimeData = model.bookingTime;
      DateFormat inputFormat = DateFormat("dd-MM-yyyy HH:mm");
      DateFormat outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
      DateTime datetime = inputFormat.parse(dateTimeData);
      String isoDateString = outputFormat.format(datetime.toUtc());
      return isoDateString;
    }

    Map<String, dynamic> body() {
      final Map<String, dynamic> data = <String, dynamic>{};

      data["createdTime"] = DateTime.now().toIso8601String();
      data["updatedTime"] = DateTime.now().toIso8601String();
      data["isActive"] = true;
      data["teacherName"] = model.teacherName.toString();
      data["studyName"] = model.studyName.toString();
      data["studentName"] = model.studentName.toString();
      data["bookingProcess"] = "Talep";
      data["bookingStatus"] = true;
      data["content"] = model.content.toString();
      data["bookingTime"] = convertBookingTimeData();
      data["place"] = model.place.toString();
      data["tip"] = model.tip.toString();
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
    }
  }
}
