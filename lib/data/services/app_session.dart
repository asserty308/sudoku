import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPrefs;
late PackageInfo appPackageInfo;

Future<void> setupSession() async {
  sharedPrefs = await SharedPreferences.getInstance();
  appPackageInfo = await PackageInfo.fromPlatform();
}