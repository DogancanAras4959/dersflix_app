import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../model/photo_hero.dart';

class TeacherList extends StatelessWidget {
  const TeacherList({Key? key, required this.image, required this.title})
      : super(key: key);

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;

    return ClipOval(
      child: PhotoHero(
          photo: 'https://kocluk.ikifikir.net/$image',
          width: 75.0,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (BuildContext context) {
                return Scaffold(
                    appBar: AppBar(
                      title: Text(title),
                    ),
                    body: Column(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          child: PhotoHero(
                            photo: 'https://kocluk.ikifikir.net/$image',
                            width: double.infinity,
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ));
              }),
            );
          }),
    );
  }
}
