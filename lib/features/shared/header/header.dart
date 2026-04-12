import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:husband/features/shared/css/style_constants.dart';

// The header widget used in the main screen of the app. It displays the title, an emote, a subtitle (which can be a date or a custom string), and an optional icon or actions on the right side. It is used in each tab of the main screen to provide context and navigation options.
class Header extends StatelessWidget {
  final String title;
  final String emote;
  final String? subtitle;
  final DateTime? europeDateTime;
  final String? weekday;
  final IconData? icon;
  final Widget? actions;

  const Header({
    super.key,
    required this.title,
    required this.emote,
    this.subtitle,
    this.europeDateTime,
    this.weekday,
    this.icon,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    String dateHeader = "";

    if (europeDateTime != null) {
      // Dank des Null-Checks oben können wir hier sicher sein
      final e = europeDateTime!;
      final i = HijriCalendar.fromDate(europeDateTime!);

      var dateTime = DateTime.now();
      List<String> weekdays = [
        "Montag",
        "Dienstag",
        "Mittwoch",
        "Donnerstag",
        "Freitag",
        "Samstag",
        "Sonntag",
      ];

      int weekdayNumber = dateTime.weekday;
      String todayName = weekdays[weekdayNumber - 1];

      dateHeader =
          "$todayName ${weekday ?? ''} ${e.day}. ${e.month} · ${i.hDay} ${i.longMonthName} ${i.hYear}";
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title $emote',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 24,
                    color: MainColors.ink,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle ?? dateHeader,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: MainColors.lightInk,
                  ),
                ),
              ],
            ),
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: MainColors.ink,
                shape: BoxShape.circle,
              ),
              child: icon != null
                  ? Icon(icon)
                  : (actions ?? const SizedBox.shrink()),
            ),
          ],
        ),
      ],
    );
  }
}
