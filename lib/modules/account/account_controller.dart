import 'package:get/get.dart';
import 'package:pure_live_web/api/setting.dart';
import 'package:pure_live_web/common/index.dart';
import 'package:pure_live_web/common/services/bilibili_account_service.dart';

class AccountController extends GetxController {
  final BiliBiliAccountService biliAccountService = Get.find<BiliBiliAccountService>();
  @override
  void onInit() {
    biliAccountService.loadUserInfo();
    super.onInit();
  }

  void bilibiliTap() async {
    if (biliAccountService.logined.value) {
      final res = await SettingsRecover().exitBilibili();
      if (res) {
        biliAccountService.loadUserInfo();
        SmartDialog.showToast('退出账号成功');
      } else {
        SmartDialog.showToast('退出账号失败');
      }
    } else {
      var result = await SettingsRecover().toBiliBiliLogin();
      if (!result) {
        SmartDialog.showToast('打开登录页失败');
      }
    }
  }
}
