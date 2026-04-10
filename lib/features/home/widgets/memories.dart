import 'package:flutter/material.dart';

class LastMemories extends StatefulWidget {
  final IconData icon;
  final String title;
  final DateTime date;
  final String tag;
  final String paidMoney;

  const LastMemories({
    super.key,
    required this.icon,
    required this.title,
    required this.date,
    required this.tag,
    required this.paidMoney,
  });

  @override
  State<LastMemories> createState() => _LastMemoriesState();
}

class _LastMemoriesState extends State<LastMemories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255).withValues(alpha: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            widget.icon,
            size: 20,
            color: const Color.fromARGB(185, 255, 255, 255),
          ),
          SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${widget.date.day}.${widget.date.month}.${widget.date.year}',
                    style: TextStyle(
                      fontFamily: 'Cormorant Garamond',
                      fontSize: 10,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    widget.tag,
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ],
                // Hier muss noch der Preis/Value eingetragen werden
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LastMemoriesSection extends StatelessWidget {
  final List<Widget> children;
  const LastMemoriesSection({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Letze Erlebnisse',
          style: TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 18,
            color: Color.fromARGB(185, 255, 255, 255),
          ),
        ),
        const SizedBox(height: 8),
        for (var child in children) ...[
          child,
          const SizedBox(height: 4),
        ], // max 3 children pls
      ],
    );
  }
}
