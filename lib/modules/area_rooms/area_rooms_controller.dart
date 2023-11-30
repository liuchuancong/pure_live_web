import 'dart:convert';
import 'package:pure_live_web/core/sites.dart';
import 'package:pure_live_web/api/setting.dart';
import 'package:pure_live_web/common/models/live_area.dart';
import 'package:pure_live_web/common/models/live_room.dart';
import 'package:pure_live_web/common/models/toggle_event.dart';
import 'package:pure_live_web/common/base/base_controller.dart';

class AreaRoomsController extends BasePageController<LiveRoom> {
  final Site site;
  final LiveArea subCategory;

  AreaRoomsController({
    required this.site,
    required this.subCategory,
  });

  @override
  Future<List<LiveRoom>> getData(int page, int pageSize) async {
    var result = await SettingsRecover().getTabData(site.id, ToggleEvent.areaRoomsTab.name, page, pageSize);
    return (jsonDecode(result) as List).map<LiveRoom>((e) => LiveRoom.fromJson(jsonDecode(e))).toList();
  }
}
