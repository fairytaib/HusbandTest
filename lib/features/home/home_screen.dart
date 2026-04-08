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
  final List<Widget> cards;

  const CardSceleton({
    super.key,
    required this.cards,
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
              if(cards.length > 2)
                Positioned(
                  top: 20,
                  left: 10,
                  right: 10,
                  child: cards[2],
                ),
              if(cards.length > 1)
                Positioned(
                  top: 10,
                  left: 5,
                  right: 5,
                  child: cards[1],
                ),
              cards[0]
            ],
          ),
        ),
      ],
    );
  }
}

class Card extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  const Card({
    super.key,
    required this.child,
    required this.backgroundColor,
  });

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
          Text(
            value.split(" ")[0],
            style: TextStyle(
              fontFamily: 'Cormorant Garamond',
              fontSize: 18,
              color: valueColor
              )
            ),
            Text(
            value.contains('/') ? '/ ${value.split('/')[1]}' : '',
            style: TextStyle(
              fontFamily: 'Cormorant Garamond',
              fontSize: 12,
              color: valueColor
              )
            ),
          Spacer(),
          Text(comment, style: TextStyle(fontFamily: 'Cormorant Garamond', fontSize: 12, color: commentColor)),
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
                        color: Colors.white
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

class InteractiveCardStack extends StatefulWidget {
  final List<Widget> cards;
  const InteractiveCardStack({super.key, required this.cards});

  @override
  State<InteractiveCardStack> createState() => _InteractiveCardStackState();
}

class _InteractiveCardStackState extends State<InteractiveCardStack> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
            children: [
              const Header(), 
              SizedBox(height: 32),
              CardSceleton(
                cards: [
                  Card(
                    backgroundColor: MainColors.emerald,
                    child: CardContent(
                      icon: Icons.nightlight_round,
                      title: 'Deen - Spiritualität',
                      titleColor: Colors.white,
                      value: '4 /5 Gebete',
                      valueColor: Colors.white,
                      comment: '1 Dua ausstehend',
                      commentColor: Colors.white70,
                      tags: [
                        TagData(label: 'Fajr', icon: Icons.check),
                        TagData(label: 'Dhuhr', icon: Icons.check),
                        TagData(label: 'Asr', icon: Icons.check),
                        TagData(label: 'Maghrib', icon: Icons.check),
                      ],
                    ),
                    
                  ),
                  Card(
                    backgroundColor: MainColors.brown,
                    child: CardContent(
                      icon: Icons.attach_money,
                      title: 'Finanzen - Haushalt',
                      titleColor: Colors.white,
                      value: '342 €',
                      valueColor: Colors.white,
                      comment: 'Budget noch Verfügbar',
                      commentColor: Colors.white70,
                      tags: [
                        TagData(label: 'Einnahmen +€2800'),
                        TagData(label: 'Gestern: €450 Ausgaben'),
                      ],
                    ),
                    
                  ),
                  Card(
                    backgroundColor: MainColors.purple,
                    child: CardContent(
                      icon: Icons.local_restaurant_rounded,
                      title: 'Dates - Ehe',
                      titleColor: Colors.white,
                      value: 'Freitag 12.04',
                      valueColor: Colors.white,
                      comment: 'Erinnerung für Date am Freitag',
                      commentColor: Colors.white70,
                      tags: [
                        TagData(label: 'Nächstes Date'),
                        TagData(label: 'Picknick im Park'),
                      ],
                    ),
                    
                  ),
              )],
          ),
        ),
      ),
    );
  }
}
