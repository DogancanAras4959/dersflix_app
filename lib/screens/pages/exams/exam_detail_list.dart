import 'package:flutter/material.dart';

class Exams extends StatefulWidget {
  const Exams({Key? key}) : super(key: key);

  @override
  State<Exams> createState() => _ExamsState();
}

class _ExamsState extends State<Exams> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sınavlar",
        ),
        backgroundColor: const Color.fromARGB(250, 96, 40, 109),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [],
          ),
        ),
      ),
    );
  }
}
