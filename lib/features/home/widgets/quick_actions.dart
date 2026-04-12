import 'package:flutter/material.dart';
import 'package:husband/features/shared/css/style_constants.dart';

// A quick action widget that can be used in the upper actions section of the main screen. It consists of a circular icon with a background color and a label below it. It can be used for shortcuts to important features or tasks in the app.
class QuickAction extends StatefulWidget {
  final Color backgroundColor;
  final IconData icon;
  final String text;

  const QuickAction({
    required this.backgroundColor,
    required this.icon,
    required this.text,
    super.key,
  });

  @override
  State<QuickAction> createState() => _QuickActionState();
}

class _QuickActionState extends State<QuickAction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // Handle tap event
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: widget.backgroundColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              widget.icon,
              size: 32,
              color: const Color.fromARGB(185, 255, 255, 255),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.text,
          style: TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 12,
            color: MainColors.lightInk,
          ),
        ),
      ],
    );
  }
}

class QuickActionsSection extends StatelessWidget {
  final List<Widget> children;

  const QuickActionsSection({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
  }
}
