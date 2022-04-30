import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/search_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBoxWidget extends StatelessWidget {
  int responsiveColumns;
  double responsiveColumnWidth;
  double responsiveGutterWidth;

  SearchBoxWidget({
    required this.responsiveColumns,
    required this.responsiveColumnWidth,
    required this.responsiveGutterWidth });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: responsiveColumnWidth*responsiveColumns + responsiveGutterWidth*(responsiveColumns-1),
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .secondary
              .withAlpha(50),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(children: [
          const Icon(
            Icons.search,
          ),
          SizedBox(
              width: responsiveColumnWidth*(responsiveColumns-1) + responsiveGutterWidth*(responsiveColumns-2),
              child: TextField(
                decoration: InputDecoration(hintText: AppLocalizations.of(context)!.searchCardHint),
                autofocus: true,
                onSubmitted: (value) async {
                  await Provider.of<SearchViewModel>(context, listen: false).search(value, Localizations.localeOf(context));
                },
              ))
        ]));
  }


}