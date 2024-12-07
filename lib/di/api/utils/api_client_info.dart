import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppClientdInfo {
  static const String appName = 'TODO: Update'; 
  String? buildNumber;
  String? appVersion;
  String? appVersionByOS;
  String? systemName;
  String? systemVersion;
  String? model;
  String? brand;

  String get userAgent {
    return '$appName/$appVersion ($systemName $systemVersion; Build $buildNumber)';
  }
}

class AppClientInfoUtils {
  static Future<AppClientdInfo> get buildInfo async {
    try {
      var buildInfo = AppClientdInfo();
      final packageInfo = await PackageInfo.fromPlatform();
      buildInfo.appVersion = packageInfo.version;
      buildInfo.buildNumber = packageInfo.buildNumber;

      final devicePlugin = DeviceInfoPlugin();
      if (Platform.isIOS) {
        final iosDeviceInfo = await devicePlugin.iosInfo;
        buildInfo._setIOSDeviceInfo(iosDeviceInfo, packageInfo.version);
      } else if (Platform.isAndroid) {
        final androidDeviceInfo = await devicePlugin.androidInfo;
        buildInfo._setAndroidDeviceInfo(androidDeviceInfo, packageInfo.version);
      }

      return buildInfo;
    } catch (e) {
      return AppClientdInfo();
    }
  }
}

extension _IOSDeviceInfoExtension on AppClientdInfo {
  void _setIOSDeviceInfo(IosDeviceInfo deviceInfo, String appVersion) {
    model = deviceInfo.model;
    systemName = 'iOS';
    systemVersion = deviceInfo.systemVersion;
    brand = 'Apple';
    appVersionByOS = '${AppClientdInfo.appName}-iOS-$appVersion';
  }
}

extension _AndroidDeviceInfoExtension on AppClientdInfo {
  void _setAndroidDeviceInfo(AndroidDeviceInfo deviceInfo, String appVersion) {
    model = deviceInfo.model;
    systemName = 'Android';
    systemVersion = deviceInfo.version.release;
    brand = deviceInfo.brand;
    appVersionByOS = '${AppClientdInfo.appName}-Android-$appVersion';
  }
}