import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Start', style: context.theme.textTheme.titleSmall),
          ),
        ],
      ),
    );
  }
}
