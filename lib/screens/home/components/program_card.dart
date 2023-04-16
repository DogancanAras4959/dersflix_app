import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ProgramCard extends StatelessWidget {
  const ProgramCard({
    Key? key,
    this.color = const Color(0xFFCFBCDA),
    this.iconSrc = "assets/icons/ios.svg",
    required this.title,
    required this.time,
  }) : super(key: key);

  final String iconSrc;
  final Color color;
  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    String timeData = convertBookingTimeData(time);
    String dateData = convertBookingDateData(time);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(iconSrc, alignment: Alignment.center),
          const SizedBox(
            width: 8,
          ),
          const SizedBox(
            width: 10,
            child: VerticalDivider(
              // thickness: 5,
              color: Colors.white70,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: const Color.fromARGB(250, 96, 40, 109),
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Tarih: $dateData",
                  style: const TextStyle(
                    color: Color.fromARGB(250, 96, 40, 109),
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Saat: $timeData",
                  style: const TextStyle(
                    color: Color.fromARGB(250, 96, 40, 109),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(250, 96, 40, 109),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: SizedBox(
                    height: 50,
                    width: 70,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Detay",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String convertBookingTimeData(time) {
  String dateTimeData = time;
  DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'");
  DateFormat outputFormat = DateFormat("HH:mm");
  DateTime datetime = inputFormat.parse(dateTimeData);
  String isoDateString = outputFormat.format(datetime.toUtc());
  return isoDateString;
}

String convertBookingDateData(time) {
  String dateTimeData = time;
  DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  DateFormat outputFormat = DateFormat("dd-MM-yyyy");
  DateTime datetime = inputFormat.parse(dateTimeData);
  String isoDateString = outputFormat.format(datetime.toUtc());
  return isoDateString;
}
