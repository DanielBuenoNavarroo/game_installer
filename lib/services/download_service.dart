import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:game_installer/utils/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';

class DownloadService {
  String _selectedDirectory = '';
  bool isDownloading = false;
  String url =
      'https://www.googleapis.com/drive/v3/files/1xPYC3FGe4P30kMSE81yhfXpGgy9l0ly7?alt=media&key=AIzaSyAJpuonY--O10Xb5n7XN6T93thMU8Kk15I';

  void downloadFile(context) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        isDownloading = true;
        final String filePath = '$_selectedDirectory/Agile Asphalt.zip';
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        final archive = ZipDecoder().decodeBytes(response.bodyBytes);
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

        isDownloading = false;
      } else {
        isDownloading = false;
        SnackBarUtils.showSnackBar(context, Icons.error, 'error');
      }
    } catch (e) {
      isDownloading = false;
      SnackBarUtils.showSnackBar(context, Icons.error, e.toString());
      print(e.toString());
    }
  }

  void newDirectory(context) async {
    try {
      String? directory = await FilePicker.platform.getDirectoryPath();
      if (directory != null) {
        _selectedDirectory = directory;
      } else {
        SnackBarUtils.showSnackBar(
            context, Icons.error, 'No se seleccionó ningún directorio');
      }
    } catch (e) {
      SnackBarUtils.showSnackBar(context, Icons.error, e.toString());
    }
  }
}
