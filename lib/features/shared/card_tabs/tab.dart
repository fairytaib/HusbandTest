import 'package:flutter/material.dart';

//Css
import 'package:husband/features/shared/css/style_constants.dart';

class InputCard extends StatefulWidget {
  final String title;
  final String question;
  final String hintText;
  final Color backgroundColor;
  final Function(String) onSave;

  const InputCard({
    super.key,
    required this.title,
    required this.question,
    this.hintText = 'Tippe, um deine Antwort einzutragen.',

    required this.backgroundColor,
    required this.onSave,
  });

  @override
  State<InputCard> createState() => _InputCardState();
}

class _InputCardState extends State<InputCard> {
  final TextEditingController _controller = TextEditingController();
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 12),
          // Die Frage
          Text(
            widget.question,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Cormorant Garamond',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          // Eingabefeld (Stilisiert wie im Entwurf)
          TextField(
            controller: _controller,
            maxLines: _isExpanded ? 4 : 1,
            onTap: () => setState(() => _isExpanded = true),
            style: const TextStyle(color: Colors.white, fontFamily: 'DM Sans'),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),

          // Speicher-Button (erscheint wenn aufgeklappt)
          if (_isExpanded) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  widget.onSave(_controller.text);
                  setState(() => _isExpanded = false);
                  FocusScope.of(context).unfocus();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: widget.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Speichern',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class CheckupCard extends StatefulWidget {
  final String title;
  final List<String> tasks;
  final Color backgroundColor;
  final Color accentColor;
  final Function(int completedCount, int totalCount) onProgressChanged;

  const CheckupCard({
    super.key,
    required this.title,
    required this.tasks,
    required this.backgroundColor,
    this.accentColor = MainColors.gold,
    required this.onProgressChanged,
  });

  @override
  State<CheckupCard> createState() => _CheckupCardState();
}

class _CheckupCardState extends State<CheckupCard> {
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

class TextCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String mainText;
  final String? subText; // Optional: Für Übersetzungen
  final String? reference; // Optional: Für Quellen (z.B. Hadith-Nummer)
  final Color backgroundColor;

  const TextCard({
    super.key,
    required this.title,
    required this.icon,
    required this.mainText,
    this.subText,
    this.reference,
    required this.backgroundColor,
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
        mainAxisSize: MainAxisSize.min, // Passt sich der Textlänge an
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bereich (Icon und Titel)
          Row(
            children: [
              Icon(icon, color: Colors.white.withValues(alpha: 0.8), size: 20),
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
          const SizedBox(height: 20),

          // Haupttext (z.B. Das Dua selbst)
          Text(
            mainText,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Cormorant Garamond',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              height: 1.4, // Etwas mehr Zeilenabstand für bessere Lesbarkeit
            ),
          ),

          // Optional: Untertext / Übersetzung (Wird nur gezeichnet, wenn vorhanden)
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

          // Optional: Referenz / Quelle (Ganz unten rechts)
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
        ],
      ),
    );
  }
}
