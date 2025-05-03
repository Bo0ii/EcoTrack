import 'package:flutter/material.dart';
import '/custom_code/actions/index.dart' as actions;

class LifecycleManager extends StatefulWidget {
  final Widget child;

  const LifecycleManager({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<LifecycleManager> createState() => _LifecycleManagerState();
}

class _LifecycleManagerState extends State<LifecycleManager> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    // Handle app lifecycle changes
    switch (state) {
      case AppLifecycleState.resumed:
        // App is visible and responding to user input
        actions.setApiBackgroundMode(false);
        break;
      case AppLifecycleState.inactive:
        // App is in an inactive state (on iOS this means foreground inactive)
        // No need to change anything here
        break;
      case AppLifecycleState.paused:
        // App is not visible but still running in the background
        actions.setApiBackgroundMode(true);
        break;
      case AppLifecycleState.detached:
        // App is detached from the UI (Android only)
        // Conserve resources maximally
        actions.setApiBackgroundMode(true);
        break;
      case AppLifecycleState.hidden:
        // App is hidden (iOS only)
        actions.setApiBackgroundMode(true);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
} 