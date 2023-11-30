import 'dart:convert';
import 'package:pure_live_web/api/setting.dart';
import 'package:pure_live_web/common/index.dart';
import 'package:pure_live_web/routes/app_navigation.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AreaCard extends StatelessWidget {
  const AreaCard({super.key, required this.category});
  final LiveArea category;

  routerToDetail() async {
    var res = await SettingsRecover().toAreaDetail(category.platform!, jsonEncode(category.toJson()));
    if (res) {
      if (category.platform != 'iptv') {
        AppNavigator.toCategoryDetail(site: Sites.of(category.platform!), category: category);
      } else {
        var roomItem = LiveRoom(
          roomId: category.areaId,
          title: category.typeName,
          cover: '',
          nick: category.areaName,
          watching: '',
          avatar:
              'https://img95.699pic.com/xsj/0q/x6/7p.jpg%21/fw/700/watermark/url/L3hzai93YXRlcl9kZXRhaWwyLnBuZw/align/southeast',
          area: '',
          liveStatus: LiveStatus.live,
          status: true,
          platform: 'iptv',
        );
        SettingsRecover().enterRoom(jsonEncode(roomItem.toJson()));
      }
    } else {
      SmartDialog.showToast('打开分区失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(7.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: () {
          routerToDetail();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Card(
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                clipBehavior: Clip.antiAlias,
                color: Colors.white,
                elevation: 0,
                child: CachedNetworkImage(
                  imageUrl: category.areaPic!,
                  fit: BoxFit.fill,
                  errorWidget: (context, error, stackTrace) => const Center(
                    child: Icon(
                      Icons.live_tv_rounded,
                      size: 38,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              title: Text(
                category.areaName!,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    category.typeName!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
