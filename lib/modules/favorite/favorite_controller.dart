import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:pure_live_web/api/setting.dart';
import 'package:pure_live_web/common/index.dart';

class FavoriteController extends GetxController with GetSingleTickerProviderStateMixin {
  final SettingsService settings = Get.find<SettingsService>();
  late TabController tabController;
  bool isFirstLoad = true;
  FavoriteController() {
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onInit() {
    super.onInit();
    // 初始化关注页
    syncRooms();
    tabController.addListener(() {
      SettingsRecover().toggleTabevent(tabController.index, ToggleEvent.online.name);
    });
    // 监听settings rooms变化
    settings.favoriteRooms.listen((rooms) => syncRooms());
    onRefresh();
    // 定时自动刷新
    if (settings.autoRefreshTime.value != 0) {
      Timer.periodic(
        Duration(minutes: settings.autoRefreshTime.value),
        (timer) => onRefresh(),
      );
    }
  }

  final onlineRooms = [].obs;
  final offlineRooms = [].obs;

  void syncRooms() {
    onlineRooms.clear();
    offlineRooms.clear();
    onlineRooms.addAll(settings.favoriteRooms.where((room) => room.liveStatus == LiveStatus.live));
    offlineRooms.addAll(settings.favoriteRooms.where((room) => room.liveStatus != LiveStatus.live));
  }

  Future<bool> onRefresh() async {
    // 自动刷新时间为0关闭。不是手动刷新并且不是第一次刷新
    if (isFirstLoad) {
      await const Duration(seconds: 1).delay();
    }
    bool hasError = false;
    if (settings.favoriteRooms.value.isEmpty) return false;
    try {
      var refreshFlag = await SettingsRecover().postFavoriteRooms();
      if (refreshFlag) {
        var rooms = await SettingsRecover().getFavoriteRooms();
        settings.favoriteRooms.value = (rooms as List).map<LiveRoom>((e) => LiveRoom.fromJson(jsonDecode(e))).toList();
        syncRooms();
        SmartDialog.showToast('刷新成功');
      } else {
        SmartDialog.showToast('刷新失败');
      }
    } catch (e) {
      hasError = true;
      log(e.toString(), name: 'syncRooms');
    }
    isFirstLoad = false;
    return hasError;
  }
}
