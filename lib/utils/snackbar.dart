import 'package:flutter/material.dart';
import 'package:game_installer/utils/app_styles.dart';

class SnackBarUtils {
  static void showSnackBar(
      BuildContext context, IconData icon, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              icon,
              color: AppTheme.accent,
            ),
            const SizedBox(width: 8),
            Text(message)
          ],
        ),
      ),
    );
  }
}