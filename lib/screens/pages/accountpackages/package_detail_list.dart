import 'package:flutter/material.dart';

class Package extends StatefulWidget {
  const Package({Key? key}) : super(key: key);

  @override
  State<Package> createState() => _ExamsState();
}

class _ExamsState extends State<Package> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Paketler",
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
