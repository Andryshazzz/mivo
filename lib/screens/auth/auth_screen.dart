import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../res/theme.dart';

// class _AuthScreen extends StatelessWidget {
//   const _AuthScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: const AuthForm()));
  }
}

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text('Login'),
                      SvgPicture.asset(ProjectIcons.user),
                    ],
                  ),
                  Text('Welcome back , Rohit thakur'),
                ],
              ),
            ],
          ),
          Image.asset(ProjectIcons.mainImage),
          Text('Enter Your Mobile Number'),
          TextFormField(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text('Change Number')],
          ),
          ElevatedButton(onPressed: () {}, child: Text('Login')),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Or Login with')],
          ),
          SvgPicture.asset(ProjectIcons.google),
          Text('You Don’t have an account ? Sign up'),
        ],
      ),
    );
  }
}
