import 'package:auth_test/screens/settings/controller/settings_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool theme = false; // TODO: отрефакторить
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: context.colors.background,
                surfaceTintColor: Colors.transparent,
                leading: AppPadding(
                  child: RoundButton(
                    onTap: () => context.pop(),
                    icon: context.icons.chevron_left,
                  ),
                ),
                title: Text(
                  'Settings',
                  style: context.theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: CupertinoSwitch(
                    value: theme,
                    onChanged: (value) {
                      setState(() {
                        theme = value;
                      }); // TODO: отрефакторить
                      context.read<SettingsCubit>().changeTheme(
                        value ? 'dark' : 'light',
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
