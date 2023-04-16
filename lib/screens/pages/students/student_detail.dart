import 'package:flutter/material.dart';

class StudentDetail extends StatefulWidget {
  const StudentDetail({Key? key, required this.username}) : super(key: key);
  final String username;

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Öğrenci",
        ),
        backgroundColor: const Color.fromARGB(250, 96, 40, 109),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [],
          ),
        ),
      ),
    );
  }
}
