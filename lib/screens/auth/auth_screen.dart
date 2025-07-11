import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../app/router/router.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'mivo',
                  style: context.theme.textTheme.headlineMedium!.copyWith(
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text('Your name', style: context.theme.textTheme.displayLarge),
              const SizedBox(height: 15),
              Text(
                'Enter your name:',
                style: context.theme.textTheme.titleMedium!.copyWith(
                  color: context.colors.gray,
                ),
              ),
              const SizedBox(height: 40),
              const InputFormField(),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Continue',
                onPressed: () {
                  context.router.replace(const HomeRoute());
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: context.colors.grayDark,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Or',
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        color: context.colors.gray,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: Color(0xFF2E2E2E), thickness: 1),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                icon: const Text('G'),
                text: 'Continue with Google',
                onPressed: () {},
                type: ButtonType.auth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
