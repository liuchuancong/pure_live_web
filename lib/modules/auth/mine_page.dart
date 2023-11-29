import 'package:pure_live_web/common/index.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  void uploadUserConifg() {}

  void downloadUserConifg() {}

  void singOut() {}

  bool isManager() {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).supabase_mine),
      ),
      body: ListView(scrollDirection: Axis.vertical, physics: const BouncingScrollPhysics(), children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.upload_file_outlined, size: 32),
                subtitle: Text(S.of(context).supabase_mine_streams),
                title: Text(S.of(context).supabase_mine_profiles),
                onTap: uploadUserConifg,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
