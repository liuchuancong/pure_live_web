import 'dart:async';
import 'dart:convert';
import 'package:pure_live_web/api/setting.dart';
import 'package:pure_live_web/common/index.dart';
import 'package:pure_live_web/common/base/base_controller.dart';

class PopularGridController extends BasePageController<LiveRoom> {
  final Site site;

  PopularGridController(this.site);

  @override
  Future<List<LiveRoom>> getData(int page, int pageSize) async {
    var result = await SettingsRecover().getTabData(site.id, ToggleEvent.hotTab.name);
    return result.map((e) => LiveRoom.fromJson(jsonDecode(e))).toList();
  }
}
