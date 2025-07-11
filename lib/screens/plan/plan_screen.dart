import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Экран планов')));
  }
}
