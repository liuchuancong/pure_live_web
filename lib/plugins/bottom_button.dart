import 'package:get/get.dart';
import 'package:pure_live_web/common/index.dart';

typedef CallBlock = void Function();

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

                ///feedback是拖动时跟随手指滑动的Widget。
                feedback: ElevatedButton(
                  onPressed: null,
                  clipBehavior: Clip.antiAlias,
                  style: ButtonStyle(
                    //背景颜色
                    backgroundColor: MaterialStateProperty.all(HexColor(settingsService.themeColorSwitch.value)),
                    //字体颜色
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    // 阴影值
                    elevation: MaterialStateProperty.all(10),
                    //鼠标的样式，当悬停的时候，鼠标要显示为什么样的样式，比如下面的鼠标就会显示为等待加载的样式
                    //shap,eleation 改变的动画时间
                    animationDuration: const Duration(milliseconds: 200),

                    //水波纹
                    splashFactory: InkRipple.splashFactory,
                    //字体样式
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '返回',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),

                child: ElevatedButton(
                  onPressed: callBlock,
                  clipBehavior: Clip.antiAlias,
                  focusNode: FocusNode(),
                  style: ButtonStyle(
                    //背景颜色
                    backgroundColor: MaterialStateProperty.all(HexColor(settingsService.themeColorSwitch.value)),
                    //字体颜色
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    // 阴影值
                    elevation: MaterialStateProperty.all(8),
                    //child的位置，
                    alignment: Alignment.center,
                    //水波纹
                    splashFactory: InkRipple.splashFactory,
                    //字体样式
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '返回',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
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
