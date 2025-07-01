import 'package:auth_test/res/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../res/theme.dart';
import 'auth_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state.error != null) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'error: Сервер возвращает 403 код, вероятно jwt токен истекает или у клиента недостаточно прав',
                    ),
                  ),
                );
              }
              return const AuthForm();
            },
          ),
        ),
      ),
    );
  }
}

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _codeController;
  final _formKey = GlobalKey<FormState>();
  bool _isCodeSent = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _codeController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите email';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Введите корректный email';
    }
    return null;
  }

  String? _validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите код';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Код должен содержать только цифры';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isAuthorized && state.jwtToken != null) {
          _emailController.clear();
          _codeController.clear();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(userId: state.userId!),
            ),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text('Вход', style: ProjectTextStyles.outfitBold),
                              const SizedBox(width: 4),
                              SvgPicture.asset(ProjectIcons.user),
                            ],
                          ),
                          Text(
                            'Добро пожаловать',
                            style: ProjectTextStyles.outfitRegular.copyWith(
                              color: ProjectColors.dark2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Image.asset(ProjectIcons.mainImage),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    _isCodeSent
                        ? 'Введите код подтверждения'
                        : 'Введите ваш email',
                    style: ProjectTextStyles.poppinsBold.copyWith(
                      color: ProjectColors.red2,
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (!_isCodeSent)
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Введите email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    )
                  else
                    TextFormField(
                      controller: _codeController,
                      decoration: const InputDecoration(
                        hintText: 'Введите код',
                      ),
                      keyboardType: TextInputType.number,
                      validator: _validateCode,
                    ),
                  const SizedBox(height: 10),
                  if (_isCodeSent)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isCodeSent = false;
                              _codeController.clear();
                            });
                          },
                          child: Text(
                            'Изменить email?',
                            style: ProjectTextStyles.poppinsRegular.copyWith(
                              color: ProjectColors.dark3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 35),
                  MyButtonWidget(
                    onTap:
                        state.isLoading
                            ? () {}
                            : () {
                              if (_formKey.currentState!.validate()) {
                                if (!_isCodeSent) {
                                  context.read<AuthBloc>().add(
                                    SendCodeEvent(_emailController.text),
                                  );
                                  setState(() => _isCodeSent = true);
                                } else {
                                  context.read<AuthBloc>().add(
                                    VerifyCodeEvent(
                                      _emailController.text,
                                      _codeController.text,
                                    ),
                                  );
                                }
                              }
                            },
                    child: Text(
                      state.isLoading
                          ? 'Загрузка...'
                          : (_isCodeSent ? 'Подтвердить код' : 'Отправить код'),
                      style: ProjectTextStyles.poppinsBold.copyWith(
                        color: ProjectColors.light1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          height: 1,
                          color: ProjectColors.dark3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Или войти через',
                          style: ProjectTextStyles.outfitRegular.copyWith(
                            color: ProjectColors.dark3,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          height: 1,
                          color: ProjectColors.dark3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  SvgPicture.asset(ProjectIcons.google),
                  const SizedBox(height: 45),
                  Text.rich(
                    TextSpan(
                      style: ProjectTextStyles.poppinsLight,
                      children: [
                        const TextSpan(text: 'Нет аккаунта? '),
                        TextSpan(
                          text: 'Зарегистрироваться',
                          style: ProjectTextStyles.poppinsLight2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyButtonWidget extends StatelessWidget {
  final Function() onTap;
  final Widget child;

  const MyButtonWidget({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 43, minWidth: double.infinity),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: ProjectColors.red2,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String userId;

  const HomeScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('userId: $userId')));
  }
}
