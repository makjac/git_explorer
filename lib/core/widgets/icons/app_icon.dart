import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';
import 'package:git_explorer/core/widgets/icons/app_icons.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({required this.icon, this.size = 24, this.color, super.key});

  final AppIcons icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? context.theme.iconTheme.color;

    return SvgPicture.asset(
      icon.assetPath,
      width: size,
      height: size,
      colorFilter:
          iconColor != null
              ? ColorFilter.mode(iconColor, BlendMode.srcIn)
              : null,
    );
  }
}
