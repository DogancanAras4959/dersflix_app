import 'package:flutter/material.dart';

class StudentItemList extends StatelessWidget {
  const StudentItemList({
    Key? key,
    required this.title,
    required this.imageAsset,
  }) : super(key: key);

  final String title;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Colors.black12,
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/avaters/avatar_logo.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.black),
            ),
            Container(
              height: 14,
              width: 14,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/icons/arrow-left.png"),
                fit: BoxFit.cover,
              )),
            )
          ],
        ),
      ),
    );
  }
}
