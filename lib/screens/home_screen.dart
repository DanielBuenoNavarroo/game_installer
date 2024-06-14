import 'package:flutter/material.dart';
import 'package:game_installer/services/download_service.dart';
import 'package:game_installer/utils/app_styles.dart';
import 'package:game_installer/utils/status.dart';
import 'package:game_installer/widgets/progress_bar.dart';
import 'package:window_manager/window_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DownloadService downloadService = DownloadService();

  @override
  void initState() {
    super.initState();
    downloadService.onStart();
    addListener();
  }

  @override
  void dispose() {
    removeListener();
    super.dispose();
  }

  void addListener() {
    downloadService.currentStatusNotifier.addListener(_onStatusChanged);
    downloadService.currentDownloadProgress.addListener(_onStatusChanged);
  }

  void removeListener() {
    downloadService.currentStatusNotifier.removeListener(_onStatusChanged);
    downloadService.currentDownloadProgress.removeListener(_onStatusChanged);
  }

  void _onStatusChanged() {
    setState(
      () {},
    );
  }

  void _minimize() {
    WindowManager.instance.minimize();
  }

  void _close() {
    WindowManager.instance.close();
  }

  ElevatedButton _mainButtonForStatus(context) {
    switch (downloadService.currentStatusNotifier.value) {
      case Status.dontInstalled:
        return _mainButton(
            () => downloadService.downloadFile(context), 'Download');
      case Status.downloading:
        return _mainButton(null, 'Downloading');
      case Status.haveAnUpdate:
        return _mainButton(() => null, 'Update');
      case Status.ready:
        return _mainButton(() => downloadService.startGame(context), 'Play');
      default:
        return _mainButton(() => null, 'Download');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agile Asphalt',
          style: AppTheme.titleStyle,
        ),
        backgroundColor: AppTheme.dark,
        toolbarHeight: 40,
        actions: [
          _iconButtonAppBar(
            () => _minimize(),
            Icons.horizontal_rule_rounded,
            AppTheme.minimizeColor,
          ),
          _iconButtonAppBar(
            () => _close(),
            Icons.clear,
            AppTheme.exitColor,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://cdn.leonardo.ai/users/53d1cc19-c1fb-4582-a6e4-d64b0e0dba7a/generations/40c68527-785f-4b0d-a9dd-b5c5587b0770/Default_Black_MCLAREN_on_a_foggy_road_heading_towards_the_came_1.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              width: 60,
              child: Container(
                color: AppTheme.sidebarBg,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _iconButton(() => null, Icons.home),
                      const SizedBox(
                        height: 40,
                      ),
                      _iconButton(() => null, Icons.discord),
                      const SizedBox(
                        height: 40,
                      ),
                      _iconButton(() => null, Icons.photo_rounded),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 45,
              right: 150,
              width: 150,
              height: 70,
              child: _mainButtonForStatus(context),
            ),
            Positioned(
              bottom: 50,
              right: 350,
              height: 50,
              width: 850,
              child: downloadService.currentStatusNotifier.value ==
                      Status.downloading
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProgressBar(
                          progress:
                              downloadService.currentDownloadProgress.value),
                    )
                  : const SizedBox(
                      height: 1,
                      width: 1,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _mainButton(Function()? onPressed, String text) {
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ));
  }

  IconButton _iconButton(Function() onPressed, IconData icon) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 20,
      icon: Icon(
        icon,
        color: AppTheme.light,
      ),
    );
  }

  IconButton _iconButtonAppBar(
      Function()? onPressed, IconData icon, Color color) {
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
