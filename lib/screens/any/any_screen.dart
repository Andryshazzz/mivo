import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AnyScreen extends StatelessWidget {
  const AnyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Какой то экран:)')));
  }
}
