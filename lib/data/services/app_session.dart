import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPrefs;

Future<void> setupSession() async {
  sharedPrefs = await SharedPreferences.getInstance();
}