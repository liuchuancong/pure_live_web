import 'package:get/get.dart';
import 'package:pure_live_web/common/services/settings_service.dart';

class Sites {
  static List<Site> supportSites = [
    Site(
      id: "bilibili",
      name: "哔哩",
      logo: "assets/images/bilibili_2.png",
    ),
    Site(
      id: "douyu",
      name: "斗鱼",
      logo: "assets/images/douyu.png",
    ),
    Site(
      id: "huya",
      name: "虎牙",
      logo: "assets/images/huya.png",
    ),
    Site(
      id: "douyin",
      name: "抖音",
      logo: "assets/images/douyin.png",
    ),
    Site(
      id: "kuaishou",
      name: "快手",
      logo: "assets/images/kuaishou.png",
    ),
    Site(
      id: "cc",
      name: "网易CC",
      logo: "assets/images/kuaishou.png",
    ),
    Site(
      id: "iptv",
      name: "网络",
      logo: "assets/images/kuaishou.png",
    ),
  ];

  static Site of(String id) {
    return supportSites.firstWhere((e) => id == e.id);
  }

  List<Site> availableSites() {
    final SettingsService settingsService = Get.find<SettingsService>();
    return supportSites.where((element) => settingsService.hotAreasList.value.contains(element.id)).toList();
  }
}

class Site {
  final String id;
  final String name;
  final String logo;
  Site({
    required this.id,
    required this.logo,
    required this.name,
  });
}
