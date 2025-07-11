import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Экран создания тасок')));
  }
}
