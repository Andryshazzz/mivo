import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../app/router/routes.dart';
import '../../app/utils/dismiss_tap.dart';
import 'controller/user_bloc.dart';
import 'controller/user_event.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController _nameController;
  final GlobalKey<FormState> _authKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _authKey,
          child: KeyboardDismissOnTap(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    left: 20,
                    right: 20,
                    top: 20,
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'mivo',
                          style: context.theme.textTheme.headlineMedium!
                              .copyWith(fontSize: 30),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Your name',
                        style: context.theme.textTheme.displayLarge,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Enter your name:',
                        style: context.theme.textTheme.titleMedium!.copyWith(
                          color: context.colors.gray,
                        ),
                      ),
                      const SizedBox(height: 40),
                      InputFormField(
                        controller: _nameController,
                        maxLength: 10,
                        maxLines: 1,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Name cannot be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Continue',
                        onPressed: () {
                          if (!_authKey.currentState!.validate()) return;
                          final name = _nameController.text.trim();

                          context.read<UserBloc>().add(
                            SaveUserNameEvent(name: name),
                          );
                          context.read<UserBloc>().add(GetUserNameEvent());

                          if (mounted) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              context.go(Routes.tasks.path);
                            });
                          }
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
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(color: context.colors.gray),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: context.colors.grayDark,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Какая-то кнопка в будущем',
                        onPressed: () {},
                        type: ButtonType.auth,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
