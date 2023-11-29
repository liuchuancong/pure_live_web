import 'package:get/get.dart';
import 'package:pure_live_web/common/index.dart';
import 'package:pure_live_web/model/live_category.dart';
import 'package:pure_live_web/common/base/base_controller.dart';

class AreasListController extends BasePageController<AppLiveCategory> {
  final Site site;
  AreasListController(this.site);

  @override
  Future<List<AppLiveCategory>> getData(int page, int pageSize) async {
    // var result = await site.liveSite.getCategores(page, pageSize);
    var result = [];
    return result.map((e) => AppLiveCategory.fromLiveCategory(e)).toList();
  }
}

class AppLiveCategory extends LiveCategory {
  var showAll = false.obs;
  AppLiveCategory({
    required super.id,
    required super.name,
    required super.children,
  }) {
    showAll.value = children.length < 19;
  }

  List<LiveArea> get take15 => children.take(15).toList();

  factory AppLiveCategory.fromLiveCategory(LiveCategory item) {
    return AppLiveCategory(
      children: item.children,
      id: item.id,
      name: item.name,
    );
  }
}
