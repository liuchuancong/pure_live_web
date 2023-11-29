import 'package:get/get.dart';
import 'package:pure_live_web/api/setting.dart';
import 'package:pure_live_web/common/index.dart';
import 'package:pure_live_web/plugins/global.dart';
import 'common/services/bilibili_account_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  PrefUtil.prefs = await SharedPreferences.getInstance();
  // 初始化服务
  initService();
  initRefresh();
  runApp(const MyApp());
}

void initService() async {
  Get.put(AuthController());
  Get.put(SettingsService());
  Get.put(FavoriteController());

  Get.put(BiliBiliAccountService());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final settings = Get.find<SettingsService>();

  @override
  void initState() {
    super.initState();
  }

  initData() async {
    await SettingsRecover().getSettingsConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var themeColor = HexColor(settings.themeColorSwitch.value);
      var lightTheme = MyTheme(primaryColor: themeColor).lightThemeData;
      var darkTheme = MyTheme(primaryColor: themeColor).darkThemeData;
      return GetMaterialApp(
        title: '纯粹直播',
        binds: [
          Bind.lazyPut(() => PopularController()),
          Bind.lazyPut(() => AreasController()),
        ],
        themeMode: SettingsService.themeModes[settings.themeModeName.value]!,
        theme: lightTheme,
        darkTheme: darkTheme,
        locale: SettingsService.languages[settings.languageName.value]!,
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        initialRoute: RoutePath.kInitial,
        defaultTransition: Transition.native,
        getPages: AppPages.routes,
      );
    });
  }
}
