// Flutter
import 'package:flutter/material.dart';

class GoalTab extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String mainValue;
  final String subtitle;
  final Color backgroundColor;

  // Optional: Für die Ziel-Karte (Fortschrittskreis oben rechts, Wert 0.0 bis 1.0)
  final double? progress;

  // Optional: Für die Lernen-Karte (Klickbarer Button oben rechts)
  final IconData? actionIcon;
  final VoidCallback? onActionTap;

  const GoalTab({
    super.key,
    required this.title,
    this.icon,
    required this.mainValue,
    required this.subtitle,
    required this.backgroundColor,
    this.progress,
    this.actionIcon,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Titel links, optionaler Indikator/Button rechts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.white.withValues(alpha: 0.8),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontFamily: 'DM Sans',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),

              // Logik für das Element oben rechts
              if (progress != null)
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 3,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                )
              else if (actionIcon != null)
                GestureDetector(
                  onTap: onActionTap,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(actionIcon, color: Colors.white, size: 14),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),

          // Großer Fokus-Text in der Mitte (z.B. "5/10" oder "Sure Al-Kahf")
          Text(
            mainValue,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Cormorant Garamond',
              fontSize: 34, // Bewusst sehr groß für den Fokus
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),

          // Untertitel (z.B. "Bücher gelesen")
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontFamily: 'DM Sans',
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
