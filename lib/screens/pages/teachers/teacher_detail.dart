import 'package:flutter/material.dart';

class TeacherDetail extends StatefulWidget {
  const TeacherDetail({Key? key}) : super(key: key);

  @override
  State<TeacherDetail> createState() => _TeacherDetailState();
}

class _TeacherDetailState extends State<TeacherDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Öğretmen",
        ),
        backgroundColor: const Color.fromARGB(250, 96, 40, 109),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
