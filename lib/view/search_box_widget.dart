import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:magic_image_generator/view/advanced_search_screen.dart';
import 'package:provider/provider.dart';
import '../common/constants.dart' as constants;

import '../common/search_filter.dart';
import '../common/search_filter_factory.dart';
import '../viewmodel/search_view_model.dart';

class SearchBoxWidget extends StatefulWidget {
  int responsiveColumns;
  double responsiveColumnWidth;
  double responsiveGutterWidth;

  SearchBoxWidget(
      {required this.responsiveColumns,
      required this.responsiveColumnWidth,
      required this.responsiveGutterWidth});

  @override
  State<StatefulWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    myController.text = Provider.of<SearchViewModel>(context).query;
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withAlpha(50),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
              flex: 1,
              child: Padding(
                  padding: EdgeInsets.only(
                    left: widget.responsiveColumnWidth * 0.3,
                  ),
                  child: SizedBox(
                      child: TextField(
                    controller: myController,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.searchCardHint,
                        border: InputBorder.none),
                    autofocus: false,
                    onSubmitted: (value) async {
                      if(Provider.of<SearchViewModel>(context, listen: false).isSearching) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(AppLocalizations.of(context)!.exceptionCode310),
                        ));
                        return;
                      }

                      List<SearchFilterData> filerDataList = SearchFilter.values.map((e) => SearchFilterFactory.createSearchFilter(context, e)).toList();
                      await Provider.of<SearchViewModel>(context, listen: false)
                          .search(value, Localizations.localeOf(context), filerDataList);
                    },
                    onChanged: (value) {
                      Provider.of<SearchViewModel>(context, listen: false)
                          .query = value;
                    },
                  )))),
          Expanded(
              flex: 0,
              child: Container(
                  child: IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () async {
                  myController.text = "";
                  Provider.of<SearchViewModel>(context, listen: false)
                      .query = "";
                },
              ))),
          Expanded(
              flex: 0,
              child: Container(
                  child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  if(Provider.of<SearchViewModel>(context, listen: false).isSearching) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(AppLocalizations.of(context)!.exceptionCode310),
                    ));
                    return;
                  }

                  List<SearchFilterData> filerDataList = SearchFilter.values.map((e) => SearchFilterFactory.createSearchFilter(context, e)).toList();
                  await Provider.of<SearchViewModel>(context, listen: false)
                      .search(
                          myController.text, Localizations.localeOf(context), filerDataList);
                },
              ))),
          Expanded(
              flex: 0,
              child: Container(
                  margin: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: TextButton(
                    child: Text(AppLocalizations.of(context)!.advancedSearchButton, style:const TextStyle(color:Colors.white,), ),
                    style:ElevatedButton.styleFrom(
                      primary: Colors.white24,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return AdvancedSearchScreen();
                          },
                        ),
                      );
                    },
                  ))),
        ]));
  }
}
