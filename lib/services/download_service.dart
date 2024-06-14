import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:game_installer/utils/snackbar.dart';
import 'package:game_installer/utils/status.dart';
import 'package:archive/archive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadService {
  late String finalDirectory;
  String _selectedDirectory = '';
  final ValueNotifier<Status> currentStatusNotifier =
      ValueNotifier(Status.dontInstalled);
  final ValueNotifier<double> currentDownloadProgress = ValueNotifier(0.0);
  String url =
      'https://www.googleapis.com/drive/v3/files/1HE4t49a_evbobBYood78Fajs4l1abwa3?alt=media&key=AIzaSyAJpuonY--O10Xb5n7XN6T93thMU8Kk15I';

  void _finalDirectory() {
    finalDirectory = '$_selectedDirectory/AgileAsphalt';
  }

  void onStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedDirectory = prefs.getString('selectedDirectory') ?? '';
    finalDirectory = '$_selectedDirectory/AgileAsphalt';
    Directory directory = Directory(finalDirectory);
    bool directoryExists = await directory.exists();
    if (!directoryExists) {
      currentStatusNotifier.value = Status.dontInstalled;
      finalDirectory = '';
    } else {
      currentStatusNotifier.value = Status.ready;
    }
  }

  void downloadFile(context) async {
    selectDirectory(context);
    currentStatusNotifier.value = Status.downloading;
    try {
      Dio dio = Dio();
      await dio.download(
        url,
        '$_selectedDirectory/Agile Asphalt.zip',
        onReceiveProgress: (actual, total) {
          var percent = actual / total * 100;
          if (percent < 100) {
            currentDownloadProgress.value = percent / 100;
          }
        },
      );

      String filePath = '$_selectedDirectory/Agile Asphalt.zip';
      File file = File(filePath);

      List<int> bytes = await file.readAsBytes();
      Archive archive = ZipDecoder().decodeBytes(bytes);

      for (final file in archive) {
        final filename = '$_selectedDirectory/${file.name}';
        if (file.isFile) {
          final data = file.content as List<int>;
          final f = File(filename);
          await f.create(recursive: true);
          await f.writeAsBytes(data);
        } else {
          await Directory(filename).create(recursive: true);
        }
      }

      await file.delete();
      currentStatusNotifier.value = Status.ready;
    } catch (e) {
      currentStatusNotifier.value = Status.dontInstalled;
      SnackBarUtils.showSnackBar(
        context,
        Icons.error,
        e.toString(),
      );
    }
  }

  void selectDirectory(context) async {
    try {
      String? directory = await FilePicker.platform.getDirectoryPath();
      if (directory != null) {
        _selectedDirectory = directory;
        _finalDirectory();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('selectedDirectory', _selectedDirectory);
      } else {
        SnackBarUtils.showSnackBar(
          context,
          Icons.error,
          'No se seleccionó ningún directorio',
        );
      }
    } catch (e) {
      SnackBarUtils.showSnackBar(
        context,
        Icons.error,
        e.toString(),
      );
    }
  }

  void startGame(context) async {
    try {
      String executablePath = '$finalDirectory/Windows/AgileAsphalt.exe';

      if (!File(executablePath).existsSync()) {
        SnackBarUtils.showSnackBar(
          context,
          Icons.error,
          'The route don\'t exist',
        );
      } else {
        ProcessResult result = await Process.run(executablePath, []);

        if (result.exitCode != 0) {
          SnackBarUtils.showSnackBar(
            context,
            Icons.error,
            'Error al iniciar el juego.',
          );
        }
      }
    } catch (e) {
      SnackBarUtils.showSnackBar(
        context,
        Icons.error,
        e.toString(),
      );
    }
  }
}
