import 'package:flutter/material.dart';

class InformationCenter extends StatefulWidget {
  final Color backgroundColor;
  final IconData icon;
  final String title;
  final String value;
  final String comment;

  const InformationCenter({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.title,
    required this.value,
    required this.comment,
  });

  @override
  State<InformationCenter> createState() => _InformationCenterState();
}

class _InformationCenterState extends State<InformationCenter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          // Handle tap event
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.backgroundColor.withValues(alpha: 0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 32,
                color: const Color.fromARGB(185, 255, 255, 255),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.value,
                      style: TextStyle(
                        fontFamily: 'Cormorant Garamond',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.comment,
                      style: TextStyle(
                        fontFamily: 'Cormorant Garamond',
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                size: 24,
                color: const Color.fromARGB(185, 255, 255, 255),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
