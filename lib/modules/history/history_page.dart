import 'dart:convert';
import 'package:get/get.dart';
import 'package:pure_live_web/api/setting.dart';
import 'package:pure_live_web/common/index.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HistoryPage extends GetWidget {
  HistoryPage({super.key});

  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  Future onRefresh() async {
    try {
      final SettingsService settings = Get.find<SettingsService>();
      var rooms = await SettingsRecover().getHistoryData();
      settings.historyRooms.value = (rooms as List).map<LiveRoom>((e) => LiveRoom.fromJson(jsonDecode(e))).toList();
      refreshController.finishRefresh(IndicatorResult.success);
      refreshController.resetFooter();
    } catch (e) {
      print(e.toString());
      refreshController.finishRefresh(IndicatorResult.fail);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: Text('${S.of(context).history}(20)'),
      ),
      body: Obx(() {
        final SettingsService settings = Get.find<SettingsService>();
        const dense = true;
        final rooms = settings.historyRooms.reversed.toList();
        return LayoutBuilder(builder: (context, constraint) {
          final width = constraint.maxWidth;
          int crossAxisCount = width > 1280 ? 4 : (width > 960 ? 3 : (width > 640 ? 2 : 1));
          if (dense) {
            crossAxisCount = width > 1280 ? 5 : (width > 960 ? 4 : (width > 640 ? 3 : 2));
          }
          return EasyRefresh(
            controller: refreshController,
            onRefresh: onRefresh,
            onLoad: () {
              refreshController.finishLoad(IndicatorResult.noMore);
            },
            child: rooms.isEmpty
                ? EmptyView(
                    icon: Icons.history_rounded,
                    title: S.of(context).empty_history,
                    subtitle: '',
                  )
                : MasonryGridView.count(
                    padding: const EdgeInsets.all(5),
                    controller: ScrollController(),
                    crossAxisCount: crossAxisCount,
                    itemCount: rooms.length,
                    itemBuilder: (context, index) => RoomCard(
                      room: rooms[index],
                      dense: dense,
                    ),
                  ),
          );
        });
      }),
    );
  }
}
