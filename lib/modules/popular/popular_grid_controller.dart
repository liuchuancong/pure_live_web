import 'dart:async';
import 'package:pure_live_web/common/index.dart';
import 'package:pure_live_web/common/base/base_controller.dart';

class PopularGridController extends BasePageController<LiveRoom> {
  final Site site;

  PopularGridController(this.site);

  @override
  Future<List<LiveRoom>> getData(int page, int pageSize) async {
    return [];
  }
}
