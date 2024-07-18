import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/settings/domain/settings_controller.dart';

late SharedPreferences sharedPrefs;
late PackageInfo appPackageInfo;

Future<void> setupApp() async {
  sharedPrefs = await SharedPreferences.getInstance();
  appPackageInfo = await PackageInfo.fromPlatform();

  settingsController.loadSettings();
}