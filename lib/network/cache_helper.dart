import 'package:life/screens/start_up/start_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/components.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String key}) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    }
    if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    }
    return await sharedPreferences!.setInt(key, value);
  }

  static void signOut(context) {
    sharedPreferences!.remove("token").then((value) {
      navigateAndFinish(context, const StartUpScreen());
    });
  }
}
