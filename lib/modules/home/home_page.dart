import 'dart:async';
import 'package:get/get.dart';
import '../search/search_page.dart';
import 'package:pure_live_web/common/index.dart';
import 'package:pure_live_web/modules/areas/areas_page.dart';
import 'package:pure_live_web/modules/home/mobile_view.dart';
import 'package:pure_live_web/modules/home/tablet_view.dart';
import 'package:pure_live_web/modules/popular/popular_page.dart';
import 'package:pure_live_web/modules/favorite/favorite_page.dart';
import 'package:pure_live_web/modules/about/widgets/version_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  Timer? _debounceTimer;

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
  }

  Future<void> addToOverlay() async {
    final overlay = Overlay.maybeOf(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Container(
        alignment: Alignment.center,
        color: Colors.black54,
        child: NewVersionDialog(entry: entry),
      ),
    );

    await VersionUtil.checkUpdate();
    bool isHasNerVersion = Get.find<SettingsService>().enableAutoCheckUpdate.value && VersionUtil.hasNewVersion();
    if (mounted) {
      if (overlay != null && isHasNerVersion) {
        WidgetsBinding.instance.addPostFrameCallback((_) => overlay.insert(entry));
      } else {
        if (overlay != null && isHasNerVersion) {
          overlay.insert(entry);
        }
      }
    }
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
