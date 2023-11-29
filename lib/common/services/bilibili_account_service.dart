import 'dart:async';
import 'package:get/get.dart';
import 'package:pure_live_web/api/setting.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pure_live_web/common/services/settings_service.dart';

class BiliBiliAccountService extends GetxController {
  static BiliBiliAccountService get instance => Get.find<BiliBiliAccountService>();
  final SettingsService settingsService = Get.find<SettingsService>();
  var logined = false.obs;
  var uid = 0;
  var name = "未登录".obs;
  @override
  void onInit() {
    loadUserInfo();
    super.onInit();
  }

  Future loadUserInfo() async {
    Timer(const Duration(seconds: 1), () async {
      var result = await SettingsRecover().getLibilibiLoginStatus();
      if (result['data']) {
        name.value = result['name'];
        logined.value = true;
      } else {
        name.value = '未登录';
        logined.value = false;
        SmartDialog.showToast("获取哔哩哔哩登录信息失败");
      }
    });
  }

  void logout() async {}
}
