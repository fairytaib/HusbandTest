import 'package:flutter/material.dart';
import 'package:husband/features/shared/css/style_constants.dart';

class SelectionTool extends StatelessWidget {
  final Color backgroundColor;
  final Color selectedColor;
  final List<String> options;
  final int selectedIndex;
  final Function(int) onSelected;

  const SelectionTool({
    super.key,
    required this.backgroundColor,
    required this.selectedColor,
    required this.options,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: options.asMap().entries.map((entry) {
          int idx = entry.key;
          String text = entry.value;
          bool isSelected = idx == selectedIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(idx),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isSelected ? selectedColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 13,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected ? Colors.white : MainColors.lightInk,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
