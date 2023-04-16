import 'package:flutter/material.dart';

class LessonList extends StatelessWidget {
  const LessonList(
      {Key? key,
      required this.Name,
      required this.assetImage,
      required this.TextColor})
      : super(key: key);

  final String Name;
  final AssetImage assetImage;
  final Color TextColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Colors.black38),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: assetImage, fit: BoxFit.cover)),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          overflow: TextOverflow.clip,
          Name,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: TextColor, fontSize: 14, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
