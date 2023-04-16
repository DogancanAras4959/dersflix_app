import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class BookingItemList extends StatelessWidget {
  const BookingItemList({
    Key? key,
    required this.title,
    required this.bookingTime,
    required this.type,
    this.iconSrc = "assets/icons/ios.svg",
  }) : super(key: key);

  final String iconSrc;
  final String type;
  final String title;
  final DateTime bookingTime;

  @override
  Widget build(BuildContext context) {
    var tag = Localizations.maybeLocaleOf(context)?.toLanguageTag();
    var bookingTimeAssign = bookingTime;
    var valueConvertedDate = DateFormat.yMd(tag).format(bookingTimeAssign);
    var valueConvertedTime = DateFormat("HH:mm").format(bookingTimeAssign);

    var colorBackground = const Color.fromARGB(0, 0, 0, 0);
    var colorText = const Color.fromARGB(250, 30, 0, 30);
    var colorButton = const Color.fromARGB(190, 30, 100, 40);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: colorBackground,
        border: const Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(iconSrc),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: colorText,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "$valueConvertedDate - $valueConvertedTime",
                  style: TextStyle(
                    color: colorText,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                alignment: Alignment.centerRight,
                icon: const Icon(
                  Icons.keyboard_arrow_right,
                  size: 30,
                  color: Colors.black45,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
