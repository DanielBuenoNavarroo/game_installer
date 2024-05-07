import 'package:flutter/material.dart';
import 'package:game_installer/utils/app_styles.dart';
import 'package:window_manager/window_manager.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  _AppBarState createState() => _AppBarState();
}

class _AppBarState extends State<CustomAppBar> {
  void _minimize() {
    WindowManager.instance.minimize();
  }

  void _close() {
    WindowManager.instance.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.dark,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _mainButton(
            () => null,
            Icons.settings,
            AppTheme.minimizeColor,
          ),
          _mainButton(
            () => _minimize(),
            Icons.horizontal_rule_rounded,
            AppTheme.minimizeColor,
          ),
          _mainButton(
            () => _close(),
            Icons.clear,
            AppTheme.exitColor,
          ),
        ],
      ),
    );
  }

  IconButton _mainButton(Function()? onPressed, IconData icon, Color color) {
    return IconButton(
      onPressed: onPressed,
      hoverColor: color,
      iconSize: 20,
      icon: Icon(
        icon,
        color: AppTheme.light,
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
    );
  }
}
