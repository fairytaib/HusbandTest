// Flutter
import 'package:flutter/material.dart';

class InputTab extends StatefulWidget {
  final String title;
  final String question;
  final String hintText;
  final Color backgroundColor;
  final Function(String) onSave;

  const InputTab({
    super.key,
    required this.title,
    required this.question,
    this.hintText = 'Tippe, um deine Antwort einzutragen.',

    required this.backgroundColor,
    required this.onSave,
  });

  @override
  State<InputTab> createState() => _InputTabState();
}

class _InputTabState extends State<InputTab> {
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

