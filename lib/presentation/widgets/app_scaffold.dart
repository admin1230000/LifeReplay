// lib/presentation/widgets/app_scaffold.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A reusable scaffold that wraps every main screen with a consistent AppBar.
///
/// The BottomNavigationBar is provided by the parent [StatefulShellRoute]
/// shell, so this scaffold does not include one.
class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool showBack;
  final List<Widget>? actions;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.showBack = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        leading: (showBack && context.canPop())
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 20),
                onPressed: () => context.pop(),
              )
            : null,
        actions: actions,
      ),
      body: SafeArea(child: body),
    );
  }
}
