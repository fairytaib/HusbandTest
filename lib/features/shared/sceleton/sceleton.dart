// Flutter packages
import 'package:flutter/material.dart';

// Final Sceleton that puts everything together for the main screen. It takes a list of tabs and a builder function for the bottom navigation bar. Each tab has its own header, upper actions, extra actions, and main actions.
class SceletonTab {
  final Widget header;
  final Widget upperActions;
  final Widget? extraActions;
  final List<Widget> mainAction;

  SceletonTab({
    required this.header,
    required this.upperActions,
    this.extraActions,
    required this.mainAction,
  });
}

class Sceleton extends StatefulWidget {
  final List<SceletonTab> tabs;
  final Widget Function(int index, Function(int) onTap)
  bottomNavigationBarBuilder;
  const Sceleton({
    required this.tabs,
    required this.bottomNavigationBarBuilder,
    super.key,
  });

  @override
  State<Sceleton> createState() => _SceletonState();
}

class _SceletonState extends State<Sceleton> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentTab = widget.tabs[_selectedTabIndex];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          key: ValueKey(_selectedTabIndex),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                currentTab.header,
                SizedBox(height: 32),
                currentTab.upperActions,
                currentTab.extraActions ?? SizedBox.shrink(),
                ...currentTab.mainAction,
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: widget.bottomNavigationBarBuilder(
        _selectedTabIndex,
        (index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
      ),
    );
  }
}
