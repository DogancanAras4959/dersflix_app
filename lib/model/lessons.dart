import 'package:flutter/material.dart';

class Lessons {
  final String Name;
  final AssetImage Image;
  final Color TextColor;
  Lessons({required this.Name, required this.Image, required this.TextColor});
}

final List<Lessons> lessonList = [
  Lessons(
    Name: "Matematik",
    Image: AssetImage("assets/icons/matematik.png"),
    TextColor: Colors.indigo,
  ),
  Lessons(
    Name: "Geometri",
    Image: AssetImage("assets/icons/geometri.png"),
    TextColor: Colors.deepOrange,
  ),
  Lessons(
    Name: "Kimya",
    Image: AssetImage("assets/icons/kimya.png"),
    TextColor: Colors.indigo,
  ),
  Lessons(
    Name: "Fizik",
    Image: AssetImage("assets/icons/fizik.png"),
    TextColor: Colors.deepOrange,
  ),
];
