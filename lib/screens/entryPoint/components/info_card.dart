import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.name,
    required this.bio,
  }) : super(key: key);

  final String name, bio;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          image: const DecorationImage(
            image: AssetImage("assets/avaters/Avatar 1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      subtitle: Text(
        name,
        style: const TextStyle(
            color: Colors.black45, fontSize: 22, fontWeight: FontWeight.w700),
      ),
      title: Text(
        bio,
        style: const TextStyle(
            color: Colors.black38, fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
