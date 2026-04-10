import 'package:flutter/material.dart';
import 'package:husband/shared/style_constants.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Assalamu ʿalaykum 🌙',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 24,
                    color: MainColors.ink,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Current Date.',
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
              child: const Icon(Icons.account_circle, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
