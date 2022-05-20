import 'package:flutter/cupertino.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MIGException implements Exception{
  int exceptionCode;
  MIGException(this.exceptionCode);
}

class MIGExceptionMessages {
  static String get(BuildContext context,int exceptionCode) {
    if(exceptionCode == 100) {
      return AppLocalizations.of(context)!.exceptionCode100;
    }

    return "";
  }
}