import 'package:flutter/material.dart';

// Custom widgets for the "Letze Erlebnisse" section in the main screen. It includes a section header and individual memory cards that display an icon, title, date, tag, and paid money (if applicable). These widgets are used to show recent activities or events in the user's life that they want to remember or reflect on.
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
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            widget.icon,
            size: 20,
            color: const Color.fromARGB(255, 0, 0, 0),
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
                  fontSize: 16,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.date.day}.${widget.date.month}.${widget.date.year}',
                    style: TextStyle(
                      fontFamily: 'Cormorant Garamond',
                      fontSize: 14,
                      color: const Color.fromARGB(202, 65, 65, 65),
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
            color: Color.fromARGB(184, 14, 13, 13),
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
