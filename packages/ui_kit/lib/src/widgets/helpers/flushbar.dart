import 'package:flashy_flushbar/flashy_flushbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_kit/src/theme_style/colors.dart';
import 'package:ui_kit/src/theme_style/icons.dart';
import 'package:ui_kit/src/theme_style/text_style.dart';

enum FlushbarType {
  info,
  error;

  String getIcon() {
    switch (this) {
      case FlushbarType.info:
        return ProjectIcons.info;
      case FlushbarType.error:
        return ProjectIcons.error;
    }
  }

  Color getColor() {
    switch (this) {
      case FlushbarType.info:
        return ProjectColors.lavenderEcho;
      case FlushbarType.error:
        return ProjectColors.red;
    }
  }
}

class Flushbar {
  final String? text;
  final FlushbarType type;

  Flushbar({required this.text, required this.type});

  void show() => FlashyFlushbar(
        backgroundColor: type.getColor(),
        comingFromTop: false,
        leadingWidget: SvgPicture.asset(
          type.getIcon(),
          height: 24,
          colorFilter: ColorFilter.mode(ProjectColors.white, BlendMode.srcIn),
        ),
        message: text ?? '',
        messageStyle: ProjectTextStyles.workSansMedium,
        duration: const Duration(milliseconds: 700),
        trailingWidget: IconButton(
          icon: SvgPicture.asset(ProjectIcons.close,
              height: 24,
              colorFilter:
                  ColorFilter.mode(ProjectColors.white, BlendMode.srcIn)),
          onPressed: () {
            FlashyFlushbar.cancel();
          },
        ),
      ).show();
}
