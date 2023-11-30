import 'dart:convert';
import 'package:pure_live_web/common/models/index.dart';

class LiveCategory {
  final String name;
  final String id;
  final List<LiveArea> children;
  LiveCategory({
    required this.id,
    required this.name,
    required this.children,
  });

  @override
  String toString() {
    return json.encode({
      "name": name,
      "id": id,
      "children": children,
    });
  }

  LiveCategory.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        children = (json['children'] as List).map((e) => LiveArea.fromJson(jsonDecode(e))).toList(),
        name = json['name'] ?? '';
}
