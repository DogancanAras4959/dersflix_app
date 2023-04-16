import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../data_constants.dart';
import '../datas/booking.dart';

const urlApi = url;

class BookingProvider with ChangeNotifier {
  List<Booking> bookingList = [];

  Booking? _bookingByBookingName;

  Booking? get bookingByBookingName => _bookingByBookingName;

  getBookings() async {
    final url = Uri.http(urlApi, '/Booking');
    final resp = await http.get(url, headers: {
      "Access.Control-Allow-Origin": "*",
      "Access.Control-Allow-Credentials": "true",
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    final response = bookingFromJson(resp.body);
    bookingList = response;
    notifyListeners();
  }

  getBookingByName(String studyName) async {
    const bookingPath = '/Booking/getBooking';
    final Map<String, String> queryParameters = <String, String>{
      'studyName': studyName,
    };

    final url = Uri.http(urlApi, bookingPath, queryParameters);
    final resp = await http.get(url, headers: {
      "Access.Control-Allow-Origin": "*",
      "Access.Control-Allow-Credentials": "true",
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (resp.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(resp.body);
      Booking bookingData = Booking.fromJson(responseData);
      return _bookingByBookingName = bookingData;
    } else {
      return null;
    }
  }
}
