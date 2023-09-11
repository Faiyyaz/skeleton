import 'package:package_info_plus/package_info_plus.dart';

AppConfig _appConfigProd = AppConfig(
  baseURL: "https://www.example.com",
);

AppConfig _appConfigDev = AppConfig(
  baseURL: "https://www.example.com",
);

class AppConfig {
  final String baseURL;

  AppConfig({
    required this.baseURL,
  });
}

class Environment {
  static AppConfig? _appConfig;

  static Future<AppConfig> current() async {
    if (_appConfig != null) {
      return _appConfig!;
    }

    final packageInfo = await PackageInfo.fromPlatform();

    switch (packageInfo.packageName) {
      case "com.byteiva.skeleton.dev":
        _appConfig = _appConfigDev;
        break;
      default:
        _appConfig = _appConfigProd;
    }
    return _appConfig!;
  }
}
