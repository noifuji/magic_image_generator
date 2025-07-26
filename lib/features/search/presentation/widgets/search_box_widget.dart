import 'package:flutter/material.dart';
import 'package:magic_image_generator/l10n/app_localizations.dart';
import 'package:magic_image_generator/features/search/presentation/screens/advanced_search_screen.dart';
import 'package:provider/provider.dart';

import 'package:magic_image_generator/core/search_filter.dart';
import 'package:magic_image_generator/core/search_filter_factory.dart';
import '../viewmodel/search_view_model.dart';
import 'package:magic_image_generator/features/search/presentation/screens/import_deck_list_screen.dart';

class SearchBoxWidget extends StatefulWidget {
  final int responsiveColumns;
  final double responsiveColumnWidth;
  final double responsiveGutterWidth;

  const SearchBoxWidget(
      {Key? key,
      required this.responsiveColumns,
      required this.responsiveColumnWidth,
      required this.responsiveGutterWidth})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    myController.text = Provider.of<SearchViewModel>(context).searchBoxText;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withAlpha(50),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                  if (Provider.of<SearchViewModel>(context, listen: false)
                      .isSearching()) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text(AppLocalizations.of(context)!.exceptionCode310),
                    ));
                    return;
                  }

                  List<SearchFilterData> filerDataList = SearchFilter.values
                      .map((e) =>
                          SearchFilterFactory.createSearchFilter(context, e))
                      .toList();
                  Provider.of<SearchViewModel>(context, listen: false).search(
                      Localizations.localeOf(context), filerDataList,
                      query: value);
                },
                onChanged: (value) {
                  Provider.of<SearchViewModel>(context, listen: false)
                      .searchBoxText = value;
                },
              ),
            ),
          ),
        ),
        Expanded(
          flex: 0,
          child: IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () async {
              myController.text = "";
              Provider.of<SearchViewModel>(context, listen: false)
                  .searchBoxText = "";
            },
          ),
        ),
        Expanded(
          flex: 0,
          child: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              if (Provider.of<SearchViewModel>(context, listen: false)
                  .isSearching()) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(AppLocalizations.of(context)!.exceptionCode310),
                ));
                return;
              }

              List<SearchFilterData> filerDataList = SearchFilter.values
                  .map(
                      (e) => SearchFilterFactory.createSearchFilter(context, e))
                  .toList();
              Provider.of<SearchViewModel>(context, listen: false).search(
                  Localizations.localeOf(context), filerDataList,
                  query: myController.text);
            },
          ),
        ),
        Expanded(
          flex: 0,
          child: Container(
            margin: const EdgeInsets.only(
              right: 5,
            ),
            child: widget.responsiveColumns > 4
                ? TextButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white24,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const ImportDeckListScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.importDeckList,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ))
                : IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const ImportDeckListScreen();
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                  ),
          ),
        ),
        Expanded(
          flex: 0,
          child: Container(
            margin: const EdgeInsets.only(
              right: 10,
            ),
            child: widget.responsiveColumns > 4
                ? TextButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white24,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const AdvancedSearchScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.advancedSearchButton,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ))
                : IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const AdvancedSearchScreen();
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.manage_search),
                  ),
          ),
        ),
      ]),
    );
  }
}
