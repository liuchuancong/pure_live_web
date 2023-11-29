import 'dart:io';
import 'dart:math';

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

  Future<bool> recoverNetworkM3u8Backup(String url, String fileName) async {
    return false;
  }

  Future<bool> requestStoragePermission() async {
    return true;
  }

  Future<String?> createBackup(String backupDirectory) async {}

  void recoverBackup() async {}

  // 选择备份目录
  Future<String?> selectBackupDirectory(String backupDirectory) async {
    return '';
  }

  Future<bool> recoverM3u8Backup() async {
    return false;
  }

  Future<bool> recoverM3u8BackupByShare(media) async {
    return false;
  }
}
