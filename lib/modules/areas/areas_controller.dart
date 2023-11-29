import 'package:get/get.dart';
import 'package:pure_live_web/api/setting.dart';
import 'package:pure_live_web/common/index.dart';
import 'package:pure_live_web/modules/areas/areas_list_controller.dart';

class AreasController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  int index = 0;
  AreasController() {
    final preferPlatform = Get.find<SettingsService>().preferPlatform.value;
    final pIndex = Sites().availableSites().indexWhere((e) => e.id == preferPlatform);
    tabController = TabController(
      initialIndex: pIndex == -1 ? 0 : pIndex,
      length: Sites().availableSites().length,
      vsync: this,
    );
    index = pIndex == -1 ? 0 : pIndex;
    tabController.animation?.addListener(() {
      var currentIndex = (tabController.animation?.value ?? 0).round();
      if (index == currentIndex) {
        return;
      }
      index = currentIndex;
      var controller = Get.find<AreasListController>(tag: Sites().availableSites()[index].id);

      if (controller.list.isEmpty) {
        controller.loadData();
      }
      SettingsRecover().toggleTabevent(index, ToggleEvent.areaTab.name);
    });
  }

  @override
  void onInit() async {
    for (var site in Sites().availableSites()) {
      Get.put(AreasListController(site), tag: site.id);
      var controller = Get.find<AreasListController>(tag: site.id);
      if (controller.list.isEmpty) {
        controller.loadData();
      }
    }

    super.onInit();
  }
}
