import 'package:flutter/material.dart';

class AppLifecycleManager extends StatefulWidget {
  final Widget child;
  final VoidCallback? onAppResumed;

  const AppLifecycleManager({
    super.key,
    required this.child,
    this.onAppResumed,
  });

  @override
  State<AppLifecycleManager> createState() => _AppLifecycleManagerState();
}

class _AppLifecycleManagerState extends State<AppLifecycleManager>
    with WidgetsBindingObserver {
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

    // Se o app voltou do background para o primeiro plano
    if (state == AppLifecycleState.resumed) {
      // Dispara o callback se ele tiver sido configurado
      widget.onAppResumed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
