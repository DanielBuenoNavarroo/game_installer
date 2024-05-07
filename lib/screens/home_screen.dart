import 'package:flutter/material.dart';
import 'package:game_installer/services/download_service.dart';
import 'package:game_installer/utils/app_styles.dart';
import 'package:game_installer/widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DownloadService _downloadService = DownloadService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.medium,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: CustomAppBar(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _mainButton(
                  () => _downloadService.newDirectory(context), 'Directory'),
              _mainButton(
                  () => _downloadService.downloadFile(context), 'Download'),
            ],
          )
        ],
      ),
    );
  }

  ElevatedButton _mainButton(Function() onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(),
      child: Text(text),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppTheme.accent,
      foregroundColor: AppTheme.light,
      disabledBackgroundColor: AppTheme.disabledBackgroundColor,
      disabledForegroundColor: AppTheme.disabledForegroundColor,
    );
  }
}
