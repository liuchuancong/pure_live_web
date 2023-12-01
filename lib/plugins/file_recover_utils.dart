import 'dart:io';
import 'dart:math';
import 'dart:html' as html;
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pure_live_web/api/setting.dart';
import 'package:pure_live_web/common/index.dart';
import 'package:date_format/date_format.dart' hide S;
// ignore_for_file: avoid_web_libraries_in_flutter

class FileRecoverUtils {
  ///获取后缀
  static String getName(String fullName) {
    return fullName.split(Platform.pathSeparator).last;
  }

  ///获取uuid
  static String getUUid() {
    var currentTime = DateTime.now().millisecondsSinceEpoch;
    var randomValue = Random().nextInt(4294967295);
    var result = (currentTime % 10000000000 * 1000 + randomValue) % 4294967295;
    return result.toString();
  }

  ///验证URL
  static bool isUrl(String value) {
    final urlRegExp = RegExp(
        r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
    List<String?> urlMatches = urlRegExp.allMatches(value).map((m) => m.group(0)).toList();
    return urlMatches.isNotEmpty;
  }

  ///验证URL
  static bool isPort(String value) {
    final portRegExp = RegExp(r"\d+");
    List<String?> portMatches = portRegExp.allMatches(value).map((m) => m.group(0)).toList();
    return portMatches.isNotEmpty;
  }

  Future<bool> recoverNetworkM3u8Backup(String url, String fileName) async {
    try {
      if (kIsWeb) {
        html.AnchorElement anchorElement = html.AnchorElement(href: url);
        anchorElement.download = url;
        anchorElement.click();
        SnackBarUtil.success('下载成功,请手动导入');
      }
      return true;
    } catch (e) {
      SnackBarUtil.error('下载失败,请稍后再试');
      return false;
    }
  }

  createBackup() async {
    if (kIsWeb) {
      final dateStr = formatDate(
        DateTime.now(),
        [yyyy, '-', mm, '-', dd, 'T', HH, '_', nn, '_', ss],
      );
      var blob = html.Blob(["data"], 'text/plain', 'native');
      html.AnchorElement(
        href: html.Url.createObjectUrlFromBlob(blob).toString(),
      )
        ..setAttribute("download", "purelive_$dateStr.txt")
        ..click();
    }
  }

  void recoverBackup() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: S.of(Get.context!).select_recover_file,
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    PlatformFile file = result!.files.first;
    try {
      final formData = dio.FormData.fromMap({
        'name': file.name,
        'date': DateTime.now().toIso8601String(),
        'file': dio.MultipartFile.fromBytes(file.bytes as List<int>),
      });

      SettingsRecover().uploadFile(formData, 'uploadRecoverFile');
      SnackBarUtil.success(S.of(Get.context!).recover_backup_success);
    } catch (e) {
      SnackBarUtil.error(S.of(Get.context!).recover_backup_failed);
    }
  }

  // 选择备份目录
  Future<String?> selectBackupDirectory(String backupDirectory) async {
    final settings = Get.find<SettingsService>();
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) return null;
    settings.backupDirectory.value = selectedDirectory;
    return selectedDirectory;
  }

  Future<bool> recoverM3u8Backup() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: S.of(Get.context!).select_recover_file,
      type: FileType.custom,
      allowedExtensions: ['m3u'],
    );
    PlatformFile file = result!.files.first;
    try {
      final formData = dio.FormData.fromMap({
        'name': file.name,
        'date': DateTime.now().toIso8601String(),
        'file': dio.MultipartFile.fromBytes(file.bytes as List<int>),
      });

      SettingsRecover().uploadFile(formData, 'uploadM3u8File');
      SnackBarUtil.success(S.of(Get.context!).recover_backup_success);
      return true;
    } catch (e) {
      SnackBarUtil.error(S.of(Get.context!).recover_backup_failed);
      return false;
    }
  }
}
