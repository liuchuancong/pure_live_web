import 'dart:async';
import 'package:get/get.dart';
import '../search/search_page.dart';
import 'package:pure_live_web/api/setting.dart';
import 'package:pure_live_web/common/index.dart';
import 'package:pure_live_web/plugins/bottom_button.dart';
import 'package:pure_live_web/modules/areas/areas_page.dart';
import 'package:pure_live_web/modules/home/mobile_view.dart';
import 'package:pure_live_web/modules/home/tablet_view.dart';
import 'package:pure_live_web/modules/popular/popular_page.dart';
import 'package:pure_live_web/modules/favorite/favorite_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      insetOverLay();
    });
  }

  insetOverLay() async {
    await const Duration(seconds: 1).delay();
    Application.addOverlayEntry(10, MediaQuery.of(Get.context!).size.height / 4 * 3);
    Application.callBlock = () {
      SettingsRecover().exitRoom('');
    };
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _selectedIndex = 0;
  final List<Widget> bodys = const [
    FavoritePage(),
    PopularPage(),
    AreasPage(),
    SearchPage(),
  ];
  void debounceListen(Function? func, [int delay = 1000]) {
    if (_debounceTimer != null) {
      _debounceTimer?.cancel();
    }
    _debounceTimer = Timer(Duration(milliseconds: delay), () {
      func?.call();

      _debounceTimer = null;
    });
  }

  handMoveRefresh() {
    final FavoriteController favoriteController = Get.find<FavoriteController>();
    favoriteController.onRefresh();
  }

  void onDestinationSelected(int index) {
    setState(() => _selectedIndex = index);
    SettingsRecover().toggleTabevent(index, ToggleEvent.bottomTab.name);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(
      builder: (context, constraint) => constraint.maxWidth <= 680
          ? HomeMobileView(
              body: bodys[_selectedIndex],
              index: _selectedIndex,
              onDestinationSelected: onDestinationSelected,
              onFavoriteDoubleTap: handMoveRefresh,
            )
          : HomeTabletView(
              body: bodys[_selectedIndex],
              index: _selectedIndex,
              onDestinationSelected: onDestinationSelected,
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
