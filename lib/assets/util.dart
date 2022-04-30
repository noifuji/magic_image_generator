import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../model/card_info.dart';

class Util {

  /**
   * This method work only on debug mode.
   */
  static void printTimeStamp(String str) {
    if (kDebugMode) {
      DateTime now = DateTime.now();
      print('''${now.hour}:${now.minute}:${now.second}.${now.millisecond}  :$str''');
    }
  }
}