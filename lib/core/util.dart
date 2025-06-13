import 'package:flutter/foundation.dart';
import 'constants.dart';

class Util {
  ///This method work only on debug mode.
  static void printTimeStamp(String str) {
    if (kDebugMode) {
      DateTime now = DateTime.now();
      print(
          '''${now.hour}:${now.minute}:${now.second}.${now.millisecond}  :$str''');
    }
  }

  static Environment getCurrentEnvironment() {
    String? env = const String.fromEnvironment('ENV');
    if (env == "") {
      env = "dev";
    }
    return envMap[env]!;
  }

  static String getCardMasterUrl() {
    Environment env = getCurrentEnvironment();
    if (env == Environment.staging) {
      return cardMasterUrlS3Stg;
    } else if (env == Environment.production) {
      return cardMasterUrlS3Prd;
    } else {
      return cardMasterUrlS3Dev;
    }
  }

  static String cardMasterVersionUrl() {
    Environment env = getCurrentEnvironment();
    if (env == Environment.staging) {
      return cardMasterVersionUrlS3Stg;
    } else if (env == Environment.production) {
      return cardMasterVersionUrlS3Prd;
    } else {
      return cardMasterVersionUrlS3Dev;
    }
  }
}
