import 'package:flutter/material.dart';
import 'package:husband/features/shared/css/style_constants.dart';

import 'package:husband/features/shared/tags/tags.dart';

// CardContent for the DashboardCard, which includes icon, title, value, comment and tags

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
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon),
              SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
            ],
          ),

          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                value.split(" ")[0],
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  fontSize: 30,
                  color: valueColor,
                ),
              ),
              Text(
                value.contains('/') ? '/ ${value.split('/')[1]}' : '',
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  fontSize: 20,
                  color: valueColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            comment,
            style: TextStyle(
              fontFamily: 'Cormorant Garamond',
              fontSize: 16,
              color: commentColor,
            ),
          ),
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

// DashboardCard, which is a Material card with rounded corners and a shadow, containing CardContent
class DashboardCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  const DashboardCard({
    super.key,
    required this.child,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      // Material sorgt für Schatten und korrekte Farbdarstellung
      color: backgroundColor, // Hier die Farbe (z.B. MainColors.emerald)
      borderRadius: BorderRadius.circular(20),
      elevation: 4, // Optional: Ein leichter Schatten hilft bei der Trennung
      child: Container(
        padding: const EdgeInsets.all(16),
        child: child, // Hier kommt dein CardContent rein
      ),
    );
  }
}

// InteractiveCardStack, which is a stack of cards that can be swiped through by tapping. Only the top card is fully visible, the others are slightly offset and behind it. Tapping on the stack shows the next card in the list.
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

  int _getPosition(int index) {
    return (index - _currentIndex + widget.cards.length) % widget.cards.length;
  }

  @override
  Widget build(BuildContext context) {
    int stackPosition = _currentIndex + 1;

    var sortedEntries = widget.cards.asMap().entries.toList();

    sortedEntries.sort((a, b) {
      return _getPosition(b.key).compareTo(_getPosition(a.key));
    });

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
            height: 230,
            width: double.infinity,
            child: Stack(
              children: sortedEntries
                  .map((entry) {
                    int index = entry.key;
                    int position = _getPosition(index);

                    double bottom = 1;
                    double horizontalInset = 1;

                    if (position == 0) {
                      bottom = 0;
                      horizontalInset = 14;
                    } else if (position == 1) {
                      bottom = 10;
                      horizontalInset = 7;
                    } else {
                      bottom = 20;
                      horizontalInset = 0;
                    }

                    return AnimatedPositioned(
                      key: ValueKey(
                        index,
                      ), // WICHTIG: Damit Flutter die Karte wiederkennt
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutBack,
                      top: 0,
                      bottom: bottom,
                      left: horizontalInset,
                      right: horizontalInset,
                      child: entry.value,
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
        SizedBox(height: 8),
      ],
    );
  }
}
