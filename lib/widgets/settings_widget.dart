import 'package:flutter/material.dart';
import 'package:game_installer/utils/app_styles.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  void handleClick() {

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.light,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppTheme.disabledBackgroundColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: _closeButton(() => handleClick(), Icons.close),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconButton _closeButton(Function() onPressed, IconData icon) {
    return IconButton(
      onPressed: onPressed,
      hoverColor: Colors.transparent,
      color: AppTheme.accent,
      splashColor: Colors.white,
      iconSize: 50,
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
      icon: Icon(icon),
    );
  }
}
