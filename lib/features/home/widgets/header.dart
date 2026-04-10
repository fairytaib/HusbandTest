import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:husband/shared/style_constants.dart';

class Header extends StatelessWidget {
  final String title;
  final String emote;
  final String? subtitle;
  final DateTime? europeDateTime;
  final IconData? icon;
  final Widget? actions;

  const Header({
    super.key,
    required this.title,
    required this.emote,
    this.subtitle,
    this.europeDateTime,
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

      dateHeader =
          "${e.day}. ${e.month} · ${i.hDay} ${i.longMonthName} ${i.hYear}";
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
