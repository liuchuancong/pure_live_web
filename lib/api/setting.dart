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

  Future uploadSettingsConfig() async {
    var result = await HttpClient.instance
        .postJson('/api/uploadSettingsConfig', queryParameters: {'setting': jsonEncode(service.toJson())});
    return jsonDecode(result)['data'];
  }

  Future getFavoriteRooms() async {
    var result = await HttpClient.instance.getText('/api/getFavoriteRooms');
    return json.decode(result);
  }

  Future postFavoriteRooms() async {
    var result = await HttpClient.instance.postJson('/api/postFavoriteRooms');
    return jsonDecode(result)['data'];
  }

  Future exitRoom() async {
    var result = await HttpClient.instance.postJson('/api/exitRoom');
    return jsonDecode(result)['data'];
  }

  Future playRoom(LiveRoom room) async {
    var result =
        await HttpClient.instance.postJson('/api/playRoom', queryParameters: {'liveRoom': jsonEncode(room.toJson())});
    return jsonDecode(result)['data'];
  }

  Future toBiliBiliLogin() async {
    var result = await HttpClient.instance.postJson('/api/toBiliBiliLogin');
    return jsonDecode(result)['data'];
  }

  Future getLibilibiLoginStatus() async {
    var result = await HttpClient.instance.postJson('/api/getLibilibiLoginStatus');
    return jsonDecode(result);
  }

  Future exitBilibili() async {
    var result = await HttpClient.instance.postJson('/api/exitBilibili');
    return jsonDecode(result)['data'];
  }

  Future toggleTabevent(int index, String type) async {
    var result =
        await HttpClient.instance.postJson('/api/toggleHomeTab', queryParameters: {'index': index, 'type': type});
    return jsonDecode(result)['data'];
  }

  Future getTabData(String tag, String type) async {
    var result = await HttpClient.instance.postJson('/api/getTabData', queryParameters: {'tag': tag, 'type': type});
    return jsonDecode(result)['data'];
  }
}
