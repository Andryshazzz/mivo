import 'package:auth_test/res/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../res/theme.dart';
import '../home/home_screen.dart';
import 'controller/auth_bloc.dart';
import 'controller/auth_event.dart';
import 'controller/auth_state.dart';

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
