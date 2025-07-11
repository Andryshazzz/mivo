import 'package:flutter/material.dart';

class AppPadding extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const AppPadding({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
  });

  const AppPadding.custom({
    super.key,
    required this.child,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: child,
    );
  }
}
