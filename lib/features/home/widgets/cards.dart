import 'package:flutter/material.dart';
import 'package:husband/shared/style_constants.dart';


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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: 32, color: const Color.fromARGB(185, 255, 255, 255)),
          Spacer(),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                value.split(" ")[0],
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  fontSize: 18,
                  color: valueColor,
                ),
              ),
              Text(
                value.contains('/') ? '/ ${value.split('/')[1]}' : '',
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  fontSize: 12,
                  color: valueColor,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            comment,
            style: TextStyle(
              fontFamily: 'Cormorant Garamond',
              fontSize: 12,
              color: commentColor,
            ),
          ),
          Spacer(),
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
                    Text(
                      tag.label,
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    if (tag.icon != null) ...[
                      Icon(tag.icon, size: 12, color: Colors.white),
                      SizedBox(width: 4),
                    ],
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

class DashboardCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  const DashboardCard({super.key, required this.child, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}

class InteractiveCardStack extends StatefulWidget {
  final List<Widget> cards;
  const InteractiveCardStack({super.key, required this.cards});

  @override
  State<InteractiveCardStack> createState() => _InteractiveCardStackState();
}

class _InteractiveCardStackState extends State<InteractiveCardStack> {
  int _currentIndex = 0;

  void _showNextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.cards.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    int stackPosition = _currentIndex + 1;
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
        GestureDetector(
          onTap: _showNextCard,
          child: SizedBox(
            height: 250,
            width: double.infinity,
            child: Stack(
              children: widget.cards
                  .asMap()
                  .entries
                  .map((entry) {
                    int index = entry.key;
                    int position =
                        (index - _currentIndex + widget.cards.length) %
                        widget.cards.length;

                    double top = position * 15;
                    double horizontalInset = position * 10;
                    double opacity = (1.0 - (position * 0.3)).clamp(0.0, 1.0);

                    return AnimatedPositioned(
                      key: ValueKey(
                        index,
                      ), // WICHTIG: Damit Flutter die Karte wiederkennt
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutBack,
                      top: top,
                      left: horizontalInset,
                      right: horizontalInset,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: opacity,
                        child: entry.value,
                      ),
                    );
                  })
                  .toList()
                  .reversed
                  .toList(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              stackPosition.toString(),
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 12,
                color: MainColors.lightInk,
              ),
            ),
            Text(
              ' / ${widget.cards.length}',
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 12,
                color: MainColors.lightInk,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
