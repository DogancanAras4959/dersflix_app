import 'package:flutter/material.dart' show Color;

class Course {
  final String title, description, iconSrc;
  final Color color;

  Course({
    required this.title,
    this.description = 'Sıfırdan bir iOS uygulaması oluşturun ve canlandırın',
    this.iconSrc = "assets/icons/ios.svg",
    this.color = const Color(0xFF7553F6),
  });
}

final List<Course> courses = [
  Course(
    title: "SwiftUI'deki animasyonlar",
  ),
  Course(
    title: "SwiftUI'deki animasyonlar",
    iconSrc: "assets/icons/code.svg",
    color: const Color(0xFF80A4FF),
  ),
];

final List<Course> recentCourses = [
  Course(title: "Durum Makinesi"),
  Course(
    title: "Hareketli Menü",
    color: const Color(0xFF9CC5FF),
    iconSrc: "assets/icons/code.svg",
  ),
  Course(title: "Rive ile Flutter"),
  Course(
    title: "Hareketli Menü",
    color: const Color(0xFF9CC5FF),
    iconSrc: "assets/icons/code.svg",
  ),
];
