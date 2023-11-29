import 'package:get/get.dart';
import 'package:pure_live_web/modules/area_rooms/area_rooms_controller.dart';

class AreaRoomsBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut(() => AreaRoomsController(
            site: Get.arguments[0],
            subCategory: Get.arguments[1],
          ))
    ];
  }
}
