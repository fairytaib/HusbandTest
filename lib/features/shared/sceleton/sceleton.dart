// Flutter packages
import 'package:flutter/material.dart';

//Css

class Sceleton extends StatefulWidget {
  final Widget header;
  final Widget upperActions;
  final Widget? extraActions;
  final List<Widget> mainAction;
  final Widget bottomNavigationBar;

  const Sceleton({
    required this.header,
    required this.upperActions,
    this.extraActions,
    required this.mainAction,
    required this.bottomNavigationBar,
    super.key
    });

  @override
  State<Sceleton> createState() => _SceletonState();
}

class _SceletonState extends State<Sceleton> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.header,
                SizedBox(height: 32),
                widget.upperActions,
                widget.extraActions ?? SizedBox.shrink(),
                ...widget.mainAction,
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
