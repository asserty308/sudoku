import 'package:package_info_plus/package_info_plus.dart';

late PackageInfo appPackageInfo;

Future<void> setupApp() async {
  appPackageInfo = await PackageInfo.fromPlatform();
}
