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

class CardSceleton extends StatelessWidget {
  final List<Widget> child;
  final Color backgroundColor;

  const CardSceleton({
    super.key,
    required this.child,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Übersicht',
          style: TextStyle(
            fontFamily: 'Cormorant Garamond',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: MainColors.lightInk,
          ),
        ),
        SizedBox(
          height: 250,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 10,
                right: 10,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: MainColors.emerald,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 5,
                right: 5,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: MainColors.brown,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: MainColors.gold,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Card extends StatelessWidget {
  final Widget child;
  const Card({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: MainColors.emerald,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}

class TagData {
  final String label;
  final IconData? icon; // Optionales Icon

  TagData({required this.label, this.icon});
}

class CardContent extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color titleColor;
  final String value;
  final Color valueColor;
  final String comment;
  final Color commentColor;
  final List<TagData> tags;

  const CardContent({
    super.key,
    required this.icon,
    required this.title,
    required this.titleColor,
    required this.value,
    required this.valueColor,
    required this.comment,
    required this.commentColor,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: const Color.fromARGB(185, 255, 255, 255)),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 18, color: valueColor)),
          SizedBox(height: 4),
          Text(comment, style: TextStyle(fontSize: 12, color: commentColor)),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: tags.map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (tag.icon != null) ...[
                      Icon(tag.icon, size: 12, color: Colors.white),
                      SizedBox(width: 4),
                    ],
                    Text(
                      tag.label,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [const Header(), SizedBox(height: 32), const Cards()],
          ),
        ),
      ),
    );
  }
}
