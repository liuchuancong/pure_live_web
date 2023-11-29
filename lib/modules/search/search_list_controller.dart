import 'package:get/get.dart';
import 'package:pure_live_web/core/sites.dart';
import 'package:pure_live_web/common/base/base_controller.dart';

class SearchListController extends BasePageController {
  String keyword = "";

  /// 搜索模式，0=直播间，1=主播
  var searchMode = 0.obs;
  final Site site;
  SearchListController(
    this.site,
  );

  @override
  Future refreshData() async {
    if (keyword.isEmpty) {
      return;
    }
    return await super.refreshData();
  }

  @override
  Future<List> getData(int page, int pageSize) async {
    if (keyword.isEmpty) {}
    return [];
  }

  void clear() {
    currentPage = 1;
    list.value = [];
  }
}
