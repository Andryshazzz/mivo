import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../app/router/routes.dart';
import 'controller/auth_bloc.dart';
import 'controller/auth_event.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

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
              InputFormField(controller: _nameController),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Continue',
                onPressed: () {
                  final name = _nameController.text.trim();
                  context.read<AuthBloc>().add(SaveUserNameEvent(name: name));
                  context.read<AuthBloc>().add(CheckAuthEvent());
                  if (mounted) context.go(Routes.tasks.path);
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
