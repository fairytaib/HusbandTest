import 'package:flutter/material.dart';
import 'package:husband/features/shared/css/style_constants.dart';

class FinanceOverviewTab extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;

  // Daten für die Finanzübersicht
  final double percentage; // Wert zwischen 0.0 und 1.0 (z.B. 0.65 für 65%)
  final String incomeValue;
  final String expenseValue;
  final String zakatValue;

  const FinanceOverviewTab({
    super.key,
    this.title = 'Monatsübersicht',
    this.icon = Icons.account_balance_wallet_rounded,
    required this.backgroundColor,
    required this.percentage,
    required this.incomeValue,
    required this.expenseValue,
    required this.zakatValue,
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
          // --- HEADER ---
          // --- MAIN CONTENT ---
          Row(
            children: [
              // LINKS: Das animierte Ring-Diagramm
              SizedBox(
                width: 90,
                height: 90,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: percentage),
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        // Hintergrund-Ring
                        CircularProgressIndicator(
                          value: 1.0,
                          strokeWidth: 8,
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                        // Vordergrund-Ring (animiert)
                        CircularProgressIndicator(
                          value: value,
                          strokeWidth: 8,
                          strokeCap: StrokeCap.round,
                          color: MainColors
                              .emerald, // Smaragdgrün als positive Farbe
                        ),
                        // Prozent-Text in der Mitte
                        Center(
                          child: Text(
                            '${(value * 100).toInt()}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'DM Sans',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(width: 24),

              // RECHTS: Die Auflistung (Legende)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegendItem(
                      label: 'Einnahmen',
                      value: incomeValue,
                      dotColor: MainColors.emerald,
                    ),
                    const SizedBox(height: 12),
                    _buildLegendItem(
                      label: 'Ausgaben',
                      value: expenseValue,
                      dotColor: Colors.redAccent.withValues(alpha: 0.8),
                    ),
                    const SizedBox(height: 12),
                    _buildLegendItem(
                      label: 'Zakat',
                      value: zakatValue,
                      dotColor: MainColors.gold,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Hilfs-Widget für die einzelnen Zeilen der Auflistung
  Widget _buildLegendItem({
    required String label,
    required String value,
    required Color dotColor,
  }) {
    return Row(
      children: [
        // Kleiner farbiger Punkt
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        // Label (z.B. "Einnahmen")
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontFamily: 'DM Sans',
            fontSize: 12,
          ),
        ),
        const Spacer(),
        // Wert (z.B. "3.200 €")
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'DM Sans',
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
