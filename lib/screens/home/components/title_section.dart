import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({Key? key, required this.title, required this.color})
      : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            Container(
              height: 15,
              width: 15,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/bell.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
