//Flutter
import 'package:flutter/material.dart';

// Shared Widgets
import 'package:husband/features/shared/tags/tags.dart';

class TextTab extends StatelessWidget {
  final String title;
  final String mainText;
  final String? subText; // Optional: Für Übersetzungen
  final String? reference; // Optional: Für Quellen (z.B. Hadith-Nummer)
  final Color backgroundColor;
  final List<TagData> tags;

  const TextTab({
    super.key,
    required this.title,
    required this.mainText,
    this.subText,
    this.reference,
    required this.backgroundColor,
    required this.tags,
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
          const SizedBox(height: 4),
          Text(
            mainText,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Cormorant Garamond',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          if (subText != null) ...[
            const SizedBox(height: 12),
            Text(
              subText!,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontFamily: 'DM Sans',
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
          if (reference != null) ...[
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                reference!,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontFamily: 'DM Sans',
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
          SizedBox(height: 4),
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
