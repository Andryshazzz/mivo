import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../app/router/routes.dart';

class HomeScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const HomeScreen({required this.navigationShell, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: widget.navigationShell,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          onPressed: () => context.push(Routes.create.path),
          backgroundColor: context.colors.lavenderEcho,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: context.colors.noirViolet,
        shape: CustomNotchedShape(),
        notchMargin: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavBarIcon(
                icon: context.icons.tasks,
                isActive: widget.navigationShell.currentIndex == 0,
                onTap: () => widget.navigationShell.goBranch(0),
              ),
              _NavBarIcon(
                icon: context.icons.plan,
                isActive: widget.navigationShell.currentIndex == 1,
                onTap: () => widget.navigationShell.goBranch(1),
              ),
              const SizedBox(width: 48),
              _NavBarIcon(
                icon: context.icons.user,
                isActive: widget.navigationShell.currentIndex == 3,
                onTap: () => widget.navigationShell.goBranch(3),
              ),
              _NavBarIcon(
                icon: context.icons.plan,
                isActive: widget.navigationShell.currentIndex == 4,
                onTap: () => widget.navigationShell.goBranch(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  final String icon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarIcon({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SvgPicture.asset(
        icon,
        height: 22,
        colorFilter: ColorFilter.mode(
          isActive
              ? context.colors.lavenderEcho
              : context.colors.gray.withOpacity(0.6),
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

class CustomNotchedShape extends NotchedShape {
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    const double notchRadius = 42;
    const double notchDepth = 44;
    const double cornerRadius = 20;
    const double notchCornerRadius = 15;

    if (guest == null || !guest.overlaps(host)) {
      return Path()
        ..moveTo(host.left, host.bottom)
        ..lineTo(host.left, host.top + cornerRadius)
        ..quadraticBezierTo(
          host.left,
          host.top,
          host.left + cornerRadius,
          host.top,
        )
        ..lineTo(host.right - cornerRadius, host.top)
        ..quadraticBezierTo(
          host.right,
          host.top,
          host.right,
          host.top + cornerRadius,
        )
        ..lineTo(host.right, host.bottom)
        ..lineTo(host.left, host.bottom)
        ..close();
    }

    final notchCenter = guest.center.dx;
    final notchTop = host.top + notchDepth;

    final path =
        Path()
          ..moveTo(host.left, host.bottom)
          ..lineTo(host.left, host.top + cornerRadius)
          ..quadraticBezierTo(
            host.left,
            host.top,
            host.left + cornerRadius,
            host.top,
          )
          ..lineTo(notchCenter - notchRadius - notchCornerRadius, host.top)
          ..quadraticBezierTo(
            notchCenter - notchRadius,
            host.top,
            notchCenter - notchRadius,
            host.top + notchCornerRadius,
          )
          ..quadraticBezierTo(
            notchCenter - notchRadius,
            notchTop,
            notchCenter,
            notchTop,
          )
          ..quadraticBezierTo(
            notchCenter + notchRadius,
            notchTop,
            notchCenter + notchRadius,
            host.top + notchCornerRadius,
          )
          ..quadraticBezierTo(
            notchCenter + notchRadius,
            host.top,
            notchCenter + notchRadius + notchCornerRadius,
            host.top,
          )
          ..lineTo(host.right - cornerRadius, host.top)
          ..quadraticBezierTo(
            host.right,
            host.top,
            host.right,
            host.top + cornerRadius,
          )
          ..lineTo(host.right, host.bottom)
          ..lineTo(host.left, host.bottom)
          ..close();

    return path;
  }
}
