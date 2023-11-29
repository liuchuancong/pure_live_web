import 'dart:convert';
import 'package:get/get.dart';
import 'package:pure_live_web/common/index.dart';
import 'package:pure_live_web/core/common/http_client.dart';

class SettingsRecover {
  final SettingsService service = Get.find<SettingsService>();
  Future getSettingsConfig() async {
    var result = await HttpClient.instance.getText('/api/getSettings');
    service.fromJson(json.decode(result));
  }

  Future getFavoriteRooms() async {
    var result = await HttpClient.instance.getText('/api/getFavoriteRooms');
    return json.decode(result);
  }

  Future postFavoriteRooms() async {
    var result = await HttpClient.instance.postJson('/api/postFavoriteRooms');
    return jsonDecode(result)['data'];
  }
}
