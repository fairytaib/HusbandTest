// Flutter
import 'package:flutter/material.dart';

class AddTab extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color backgroundColor;

  const AddTab({
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.add_circle_outline,
            size: 32,
            color: Colors.white.withValues(alpha: 0.7),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'DM Sans',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white70,
              fontFamily: 'DM Sans',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
