import 'route_path.dart';
import 'package:get/get.dart';
import 'package:pure_live_web/modules/auth/mine_page.dart';
import 'package:pure_live_web/modules/home/home_page.dart';
import 'package:pure_live_web/modules/about/about_page.dart';
import 'package:pure_live_web/modules/areas/areas_page.dart';
import 'package:pure_live_web/modules/about/donate_page.dart';
import 'package:pure_live_web/modules/auth/sign_in_page.dart';
import 'package:pure_live_web/modules/search/search_page.dart';
import 'package:pure_live_web/modules/backup/backup_page.dart';
import 'package:pure_live_web/modules/account/account_bing.dart';
import 'package:pure_live_web/modules/account/account_page.dart';
import 'package:pure_live_web/modules/contact/contact_page.dart';
import 'package:pure_live_web/modules/popular/popular_page.dart';
import 'package:pure_live_web/modules/history/history_page.dart';
import 'package:pure_live_web/modules/about/version_history.dart';
import 'package:pure_live_web/modules/search/search_binding.dart';
import 'package:pure_live_web/modules/favorite/favorite_page.dart';
import 'package:pure_live_web/modules/settings/settings_page.dart';
import 'package:pure_live_web/modules/hot_areas/hot_areas_page.dart';
import 'package:pure_live_web/modules/shield/danmu_shield_page.dart';
import 'package:pure_live_web/modules/settings/settings_binding.dart';
import 'package:pure_live_web/modules/area_rooms/area_rooms_page.dart';
import 'package:pure_live_web/modules/hot_areas/hot_areas_binding.dart';
import 'package:pure_live_web/modules/shield/danmu_shield_binding.dart';
import 'package:pure_live_web/modules/area_rooms/area_rooms_binding.dart';
import 'package:pure_live_web/modules/auth/components/update_password.dart';

// auth

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: RoutePath.kInitial,
      page: HomePage.new,
      participatesInRootNavigator: true,
      preventDuplicates: true,
    ),
    GetPage(
      name: RoutePath.kSignIn,
      page: SignInPage.new,
    ),
    GetPage(
      name: RoutePath.kUpdatePassword,
      page: UpdatePassword.new,
    ),
    GetPage(
      name: RoutePath.kMine,
      page: MinePage.new,
    ),
    GetPage(
      name: RoutePath.kFavorite,
      page: FavoritePage.new,
    ),
    GetPage(
      name: RoutePath.kPopular,
      page: PopularPage.new,
    ),
    GetPage(
      name: RoutePath.kAreas,
      page: AreasPage.new,
    ),
    GetPage(
      name: RoutePath.kSettings,
      page: SettingsPage.new,
      bindings: [SettingsBinding()],
    ),
    GetPage(
      name: RoutePath.kHistory,
      page: HistoryPage.new,
    ),
    GetPage(
      name: RoutePath.kSearch,
      page: SearchPage.new,
      bindings: [SearchBinding()],
    ),
    GetPage(
      name: RoutePath.kContact,
      page: ContactPage.new,
    ),
    GetPage(
      name: RoutePath.kBackup,
      page: BackupPage.new,
    ),
    GetPage(
      name: RoutePath.kAbout,
      page: AboutPage.new,
    ),
    GetPage(
      name: RoutePath.kDonate,
      page: DonatePage.new,
    ),
    GetPage(
      name: RoutePath.kAreaRooms,
      page: AreasRoomPage.new,
      bindings: [AreaRoomsBinding()],
    ),
    //账号设置
    GetPage(
      name: RoutePath.kSettingsAccount,
      page: () => const AccountPage(),
      bindings: [AccountBinding()],
    ),
    GetPage(
      name: RoutePath.kSettingsDanmuShield,
      page: () => const DanmuShieldPage(),
      bindings: [
        DanmuShieldBinding(),
      ],
    ),
    GetPage(
      name: RoutePath.kSettingsHotAreas,
      page: () => const HotAreasPage(),
      bindings: [
        HotAreasBinding(),
      ],
    ),
    GetPage(name: RoutePath.kVersionHistory, page: () => const VersionHistoryPage()),
  ];
}
