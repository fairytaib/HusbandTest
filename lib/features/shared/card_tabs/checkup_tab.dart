import 'package:flutter/material.dart';

//Css
import 'package:husband/features/shared/css/style_constants.dart';

class CheckupTab extends StatefulWidget {
  final String title;
  final List<String> tasks;
  final Color backgroundColor;
  final Color accentColor;
  final Function(int completedCount, int totalCount) onProgressChanged;

  const CheckupTab({
    super.key,
    required this.title,
    required this.tasks,
    required this.backgroundColor,
    this.accentColor = MainColors.gold,
    required this.onProgressChanged,
  });

  @override
  State<CheckupTab> createState() => _CheckupTabState();
}

class _CheckupTabState extends State<CheckupTab> {
  // Speichert den Status jedes Checklisten-Eintrags (true = erledigt)
  late List<bool> _checkedStates;

  @override
  void initState() {
    super.initState();
    // Am Anfang sind alle Tasks "false" (nicht erledigt)
    _checkedStates = List.filled(widget.tasks.length, false);
  }

  void _toggleTask(int index) {
    setState(() {
      _checkedStates[index] = !_checkedStates[index];
    });

    // Zähle, wie viele auf "true" stehen und melde es an den Screen zurück
    int completed = _checkedStates.where((state) => state).length;
    widget.onProgressChanged(completed, widget.tasks.length);
  }

  @override
  Widget build(BuildContext context) {
    int completedCount = _checkedStates.where((state) => state).length;
    double progress = widget.tasks.isEmpty
        ? 0
        : completedCount / widget.tasks.length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bereich (Icon, Titel und Zähler)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white70,
                  fontFamily: 'DM Sans',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),

              // Dezenter Zähler rechts oben (z.B. "2/5")
              Text(
                '$completedCount/${widget.tasks.length}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontFamily: 'DM Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Custom Progress Bar
          Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutQuart,
                    height: 4,
                    // Die Breite berechnet sich aus dem Container mal Prozentwert
                    width: constraints.maxWidth * progress,
                    decoration: BoxDecoration(
                      color: widget.accentColor,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: widget.accentColor.withValues(alpha: 0.4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // Die eigentliche Checkliste generieren
          Column(
            children: widget.tasks.asMap().entries.map((entry) {
              int index = entry.key;
              String task = entry.value;
              bool isDone = _checkedStates[index];

              return GestureDetector(
                onTap: () => _toggleTask(index),
                behavior:
                    HitTestBehavior.opaque, // Macht die ganze Zeile klickbar
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      // Runder Custom-Checkbox-Button
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDone
                              ? widget.accentColor
                              : Colors.transparent,
                          border: Border.all(
                            color: isDone
                                ? widget.accentColor
                                : Colors.white.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: isDone
                            ? const Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      const SizedBox(width: 16),

                      // Task-Text mit Animation (Streichung & Verblassen)
                      Expanded(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isDone
                                ? Colors.white.withValues(alpha: 0.4)
                                : Colors.white,
                            decoration: isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationColor: Colors.white.withValues(
                              alpha: 0.4,
                            ),
                          ),
                          child: Text(task),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
