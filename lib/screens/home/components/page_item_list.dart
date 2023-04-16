import 'package:flutter/material.dart';

class PageItemList extends StatelessWidget {
  const PageItemList({
    Key? key,
    required this.title,
    required this.imageAsset,
  }) : super(key: key);

  final String title;
  final AssetImage imageAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Colors.black12,
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageAsset,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.black),
            ),
            Container(
              height: 8,
              width: 8,
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
