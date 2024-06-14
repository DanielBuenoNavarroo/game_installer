import 'package:flutter/material.dart';
import 'package:game_installer/utils/app_styles.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.progress});
  final progress;

  @override
  Widget build(BuildContext context) {
    double width = 850;
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Container(
            width: width * progress,
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.accent,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '${(progress * 100).toInt()}%',
              style: AppTheme.titleStyle,
            ),
          )
        ],
      ),
    );
  }
}
