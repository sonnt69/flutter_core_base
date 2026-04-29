import 'package:flutter/material.dart';

class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required this.title,
    required this.child,
    this.actions,
    this.showBackButton = true,
    this.padding = const EdgeInsets.all(20),
  });

  final String title;
  final Widget child;
  final List<Widget>? actions;
  final bool showBackButton;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: showBackButton,
        title: Text(title),
        actions: actions,
      ),
      body: SafeArea(
        child: ListView(padding: padding, children: [child]),
      ),
    );
  }
}
