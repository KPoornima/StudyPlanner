import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Storage() {
    init();
  }
  static final _instance = Storage();
  SharedPreferences sharedPreferences;
  static Future<void> init() async {
    _instance.sharedPreferences = await SharedPreferences.getInstance();
  }
}
