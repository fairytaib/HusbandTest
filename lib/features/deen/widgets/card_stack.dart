import 'package:flutter/material.dart';

// A custom card widget for displaying Deen-related tasks and progress. Used in the "Heute" category of the Deen Tab.
class DeenCard extends StatelessWidget {
  final String title;
  final String stats; // z.B. "3/5"
  final double progress; // 0.0 bis 1.0
  final List<String> tasks;
  final Color accentColor;

  const DeenCard({
    super.key,
    required this.title,
    required this.stats,
    required this.progress,
    required this.tasks,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Linke Seite: Fortschritts-Ring
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 8,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Text(
                    stats,
                    style: const TextStyle(
                      fontFamily: 'DM Sans',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'DM Sans',
                  color: Colors.white70,
                  fontSize: 10,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          // Rechte Seite: Aufgaben-Liste
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: tasks
                  .take(4)
                  .map((task) => _buildTaskItem(task))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Colors.white70,
            size: 14,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Cormorant Garamond',
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
