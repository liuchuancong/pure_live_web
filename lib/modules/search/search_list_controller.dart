import 'dart:convert';
import 'package:get/get.dart';
import 'package:pure_live_web/api/setting.dart';
import 'package:pure_live_web/common/index.dart';
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
    var result =
        await SettingsRecover().getGridData(site.id, ToggleEvent.doSearch.name, page, pageSize, keywords: keyword);
    return (jsonDecode(result) as List).map<LiveRoom>((e) => LiveRoom.fromJson(jsonDecode(e))).toList();
  }

  void clear() {
    currentPage = 1;
    list.value = [];
  }
}
