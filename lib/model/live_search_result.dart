import 'package:pure_live_web/model/live_anchor_item.dart';
import 'package:pure_live_web/common/models/live_room.dart';

class LiveSearchRoomResult {
  final bool hasMore;
  final List<LiveRoom> items;
  LiveSearchRoomResult({
    required this.hasMore,
    required this.items,
  });
}

class LiveSearchAnchorResult {
  final bool hasMore;
  final List<LiveAnchorItem> items;
  LiveSearchAnchorResult({
    required this.hasMore,
    required this.items,
  });
}
