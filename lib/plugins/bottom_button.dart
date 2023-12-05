import 'package:get/get.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:pure_live_web/common/index.dart';

typedef CallBlock = void Function(String);

class Application {
  ///应用全局 key
  static GlobalKey<NavigatorState>? globalKey; //= GlobalKey<NavigatorState>();
  static OverlayEntry? overlayEntry;

  static bool hideChild = false;
  static CallBlock? callBlock;

  static double dx = 10;
  static double dy = 200;
  static changeChildShow() {
    hideChild = false;
    Future.delayed(const Duration(milliseconds: 200)).then((e) {
      Application.addOverlayEntry(dx, dy);
    });
  }

  static initKey() {
    GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
    Application.globalKey = globalKey;
  }

  static Future addOverlayEntry(double left, double top) async {
    final SettingsService settingsService = Get.find<SettingsService>();
    Application.overlayEntry?.remove();
    overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Positioned(
              top: top,
              left: left,
              child: Draggable(
                onDragEnd: (DraggableDetails details) {
                  ///拖动结束
                  dx = details.offset.dx;
                  dy = details.offset.dy;
                  addOverlayEntry(dx, dy);
                },
                // HexColor(settingsService.themeColorSwitch.value)
                ///feedback是拖动时跟随手指滑动的Widget。
                feedback: Row(
                  children: [
                    NiceButtons(
                      stretch: false,
                      borderRadius: 60,
                      borderThickness: 2,
                      width: 60,
                      startColor: HexColor(settingsService.themeColorSwitch.value),
                      endColor: HexColor(settingsService.themeColorSwitch.value),
                      borderColor: HexColor(settingsService.themeColorSwitch.value),
                      gradientOrientation: GradientOrientation.Horizontal,
                      onTap: (f) {
                        callBlock!('back');
                      },
                      child: const Icon(
                        Icons.reply_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    NiceButtons(
                      stretch: false,
                      borderRadius: 60,
                      borderThickness: 2,
                      width: 60,
                      startColor: HexColor(settingsService.themeColorSwitch.value),
                      endColor: HexColor(settingsService.themeColorSwitch.value),
                      borderColor: HexColor(settingsService.themeColorSwitch.value),
                      gradientOrientation: GradientOrientation.Horizontal,
                      onTap: (f) {
                        callBlock!('favorite');
                      },
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    NiceButtons(
                      stretch: false,
                      borderRadius: 60,
                      borderThickness: 2,
                      width: 60,
                      startColor: HexColor(settingsService.themeColorSwitch.value),
                      endColor: HexColor(settingsService.themeColorSwitch.value),
                      borderColor: HexColor(settingsService.themeColorSwitch.value),
                      gradientOrientation: GradientOrientation.Horizontal,
                      onTap: (f) {
                        callBlock!('fullscreen');
                      },
                      child: const Icon(
                        Icons.fullscreen_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    NiceButtons(
                      stretch: false,
                      borderRadius: 60,
                      borderThickness: 2,
                      width: 60,
                      startColor: HexColor(settingsService.themeColorSwitch.value),
                      endColor: HexColor(settingsService.themeColorSwitch.value),
                      borderColor: HexColor(settingsService.themeColorSwitch.value),
                      gradientOrientation: GradientOrientation.Horizontal,
                      onTap: (f) {
                        callBlock!('back');
                      },
                      child: const Icon(
                        Icons.reply_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    NiceButtons(
                      stretch: false,
                      borderRadius: 60,
                      borderThickness: 2,
                      width: 60,
                      startColor: HexColor(settingsService.themeColorSwitch.value),
                      endColor: HexColor(settingsService.themeColorSwitch.value),
                      borderColor: HexColor(settingsService.themeColorSwitch.value),
                      gradientOrientation: GradientOrientation.Horizontal,
                      onTap: (f) {
                        callBlock!('favorite');
                      },
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    NiceButtons(
                      stretch: false,
                      borderRadius: 60,
                      borderThickness: 2,
                      width: 60,
                      startColor: HexColor(settingsService.themeColorSwitch.value),
                      endColor: HexColor(settingsService.themeColorSwitch.value),
                      borderColor: HexColor(settingsService.themeColorSwitch.value),
                      gradientOrientation: GradientOrientation.Horizontal,
                      onTap: (f) {
                        callBlock!('fullscreen');
                      },
                      child: const Icon(
                        Icons.fullscreen_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ));

    /// 赋值  方便移除
    Application.overlayEntry = overlayEntry;
    if (Application.globalKey!.currentState != null) {
      Application.globalKey!.currentState!.overlay!.insert(overlayEntry!);
    }
  }
}
