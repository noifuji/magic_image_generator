import 'package:flutter/cupertino.dart';

import 'package:magic_image_generator/l10n/app_localizations.dart';

class MIGException implements Exception {
  int exceptionCode;
  MIGException(this.exceptionCode);
}

class MIGExceptionMessages {
  static String get(BuildContext context, int exceptionCode) {
    if (exceptionCode == 100) {
      return AppLocalizations.of(context)!.exceptionCode100;
    } else if (exceptionCode == 310) {
      return AppLocalizations.of(context)!.exceptionCode310;
    }

    return "";
  }
}
