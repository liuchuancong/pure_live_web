import 'package:get/get.dart';
import 'package:pure_live_web/api/setting.dart';
import 'package:pure_live_web/common/index.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final res = await SettingsRecover().enterSearch();
        if (res) {
          Get.toNamed(RoutePath.kSearch);
        }
      },
      icon: const Icon(CustomIcons.search),
    );
  }
}
