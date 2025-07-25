import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: context.colors.noirViolet,
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
            ],
          ),
        );
      },
    );
  }
}
