import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/search_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBoxWidget extends StatelessWidget {
  late double parentWidth;

  SearchBoxWidget({required this.parentWidth, });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: parentWidth * 0.8,
        //width: constraints.maxWidth * 0.8,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
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
              width: parentWidth * 0.7,
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