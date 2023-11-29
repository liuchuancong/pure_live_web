import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  bool shouldGoReset = false;
  late bool isLogin = false;
  late User user;
  String userId = '';
}
