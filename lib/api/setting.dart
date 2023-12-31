import 'dart:convert';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
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

  Future favoriteRoom() async {
    var result = await HttpClient.instance.postJson('/api/favoriteRoom');
    return jsonDecode(result)['data'];
  }

  Future fullscreenRoom() async {
    var result = await HttpClient.instance.postJson('/api/fullscreenRoom');
    return jsonDecode(result)['data'];
  }

  Future postFavoriteRooms() async {
    var result = await HttpClient.instance.postJson('/api/favoriteRoom');
    return jsonDecode(result)['data'];
  }

  Future exitRoom(String type) async {
    var result = await HttpClient.instance.postJson('/api/exitRoom', queryParameters: {'type': type});
    return jsonDecode(result)['data'];
  }

  Future enterSearch() async {
    var result = await HttpClient.instance.postJson('/api/enterSearch');
    return jsonDecode(result)['data'];
  }

  Future closeWebServer() async {
    var result =
        await HttpClient.instance.postJson('/api/closeWebServer', queryParameters: {'webPort': service.webPort.value});
    return jsonDecode(result)['data'];
  }

  Future enterRoom(String liveRoom) async {
    var result = await HttpClient.instance.postJson('/api/enterRoom', queryParameters: {'liveRoom': liveRoom});
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

  Future toggleTabevent(int index, String type, {String tag = ''}) async {
    var result = await HttpClient.instance
        .postJson('/api/toggleTabevent', queryParameters: {'index': index, 'type': type, 'tag': tag});
    return jsonDecode(result)['data'];
  }

  Future toggleWebServer(bool webPortEnable, String webPort) async {
    var result = await HttpClient.instance
        .postJson('/api/toggleWebServer', queryParameters: {'webPortEnable': webPortEnable, 'webPort': webPort});
    return jsonDecode(result)['data'];
  }

  Future restartApp() async {
    var result = await HttpClient.instance.postJson('/api/restartApp');
    return jsonDecode(result)['data'];
  }

  Future getGridData(String tag, String type, int page, int pageSize, {String keywords = ''}) async {
    var result = await HttpClient.instance.postJson('/api/getGridData',
        queryParameters: {'tag': tag, 'type': type, 'page': page, 'pageSize': pageSize, 'keywords': keywords});
    return jsonDecode(result)['data'];
  }

  Future toAreaDetail(String tag, String areaRoom) async {
    var result =
        await HttpClient.instance.postJson('/api/toAreaDetail', queryParameters: {'tag': tag, 'area': areaRoom});
    return jsonDecode(result)['data'];
  }

  Future uploadFile(dio.FormData formData, String type) async {
    var result = await HttpClient.instance.postFile('/api/uploadFile', data: formData, queryParameters: {'type': type});
    return jsonDecode(result)['data'];
  }

  Future getHistoryData() async {
    var result = await HttpClient.instance.postJson('/api/getHistoryData');
    return jsonDecode(result);
  }
}
