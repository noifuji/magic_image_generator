import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../viewmodel/search_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBoxWidget extends StatelessWidget {
  int responsiveColumns;
  double responsiveColumnWidth;
  double responsiveGutterWidth;

  final TextEditingController _editingController = TextEditingController();

  SearchBoxWidget(
      {required this.responsiveColumns,
      required this.responsiveColumnWidth,
      required this.responsiveGutterWidth});



  @override
  Widget build(BuildContext context) {
    var focusNode = FocusNode();
    FocusScope.of(context).requestFocus(focusNode);
    return Container(
        width: responsiveColumnWidth * responsiveColumns +
            responsiveGutterWidth * (responsiveColumns - 1),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withAlpha(50),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(children: [
          SizedBox(
              width: responsiveColumnWidth * 0.5,
              child: const Icon(
                Icons.search,
              )),
          SizedBox(
              width: responsiveColumnWidth * (responsiveColumns - 1) +
                  responsiveGutterWidth * (responsiveColumns - 2),
              child: RawKeyboardListener(
                  onKey: (event) async {
                    print(event);
                    if (event is RawKeyUpEvent) {
                      if (event.logicalKey == LogicalKeyboardKey.enter) {
                        await submit(context);
                      } else if (event.data is RawKeyEventDataWeb) {
                        final data = event.data as RawKeyEventDataWeb;
                        if (data.keyLabel == 'Enter') await submit(context);
                      } else if (event.data is RawKeyEventDataAndroid) {
                        final data = event.data as RawKeyEventDataAndroid;
                        if (data.keyCode == 13) await submit(context);
                      }
                    }
                  },
                  focusNode: focusNode,
                  child: TextField(
                    controller: _editingController,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.searchCardHint),
                    autofocus: false,
                  )))
        ]));
  }

  submit(BuildContext context) async {
    final input = _editingController.text;
    await Provider.of<SearchViewModel>(context, listen: false)
        .search(input, Localizations.localeOf(context));
  }
}
