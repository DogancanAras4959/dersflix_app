import 'package:flutter/material.dart';

class Items {
  final String title;
  final AssetImage image;

  Items({required this.title, required this.image});
}

final List<Items> itemsHome = [
  Items(
    title: "Öğrenciler",
    image: const AssetImage("assets/icons/student.png"),
  ),
  Items(
    title: "Sınavlar",
    image: const AssetImage("assets/icons/exam.png"),
  ),
  Items(
    title: "Dersler",
    image: const AssetImage("assets/icons/lesson.png"),
  ),
  Items(
    title: "Randevular",
    image: const AssetImage("assets/icons/date.png"),
  ),
  Items(
    title: "Mesajlar",
    image: const AssetImage("assets/icons/messages.png"),
  ),
  Items(
    title: "Paketler",
    image: const AssetImage("assets/icons/choose.png"),
  ),
];
