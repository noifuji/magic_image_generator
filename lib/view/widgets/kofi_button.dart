import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;
import "../../assets/constants.dart" as constants;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class KofiButton extends StatelessWidget {
  bool isSmall;
  double? width;
  double? height;

  KofiButton({Key? key, this.isSmall = false, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (width != null && height != null)
        ? Container(
            width: width,
            height: height,
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
            child: createTextButton(context, width, height))
        : Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
            child: createTextButton(context, null, null));
  }

  Widget createTextButton(BuildContext context, double? width, double? height) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)))),
        onPressed: onPressed,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(constants.kofiIcon),
          if (!isSmall)
            Text(AppLocalizations.of(context)!.kofi,
                style: (width!=null && height != null)
                    ? TextStyle(color: Colors.white, fontSize: height*0.75*0.5)
                    : const TextStyle(color: Colors.white)),
        ]));
  }

  void onPressed() {
    js.context.callMethod('open', [constants.kofiUrl]);
  }
}
