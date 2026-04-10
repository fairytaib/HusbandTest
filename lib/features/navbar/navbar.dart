import 'package:flutter/material.dart';
import 'package:husband/shared/style_constants.dart';

class CustomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 30), // Schwebender Effekt
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: MainColors.ink,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_outlined, "Home", 0),
          _navItem(Icons.dark_mode_outlined, "Deen", 1),
          _navItem(Icons.account_balance_wallet_outlined, "Finanzen", 2),
          _navItem(Icons.favorite_border, "Dates", 3),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive
                ? Colors.white
                : Colors.white.withValues(alpha: 0.5),
            size: 24,
          ),
          const SizedBox(height: 4),
          // Kleiner Punkt unter dem aktiven Icon (wie im Design)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isActive ? 4 : 0,
            width: isActive ? 4 : 0,
            decoration: BoxDecoration(
              color: isActive ? MainColors.gold : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
