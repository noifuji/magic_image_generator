import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;
import "../../assets/constants.dart" as constants;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class KofiButton extends StatelessWidget {
  bool isSmall;

  KofiButton({Key? key, this.isSmall = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
        child: TextButton(
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
                    style: const TextStyle(color: Colors.white)),
            ])));
  }

  void onPressed() {
    js.context.callMethod('open', [constants.kofiUrl]);
  }
}
