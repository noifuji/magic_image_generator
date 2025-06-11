import 'package:flutter/material.dart';
import 'package:magic_image_generator/domain/entity/card_info_header.dart';
import 'package:magic_image_generator/domain/entity/search_result.dart';
import 'package:magic_image_generator/view/search_box_widget.dart';
import 'package:magic_image_generator/view/search_card.dart';
import 'package:magic_image_generator/view/sort_drop_down.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../common/constants.dart' as constants;
import '../common/mig_exception.dart';
import '../common/util.dart';
import '../viewmodel/canvas_view_model.dart';
import '../viewmodel/search_view_model.dart';
import 'package:magic_image_generator/l10n/app_localizations.dart';

class SearchViewScreen extends StatefulWidget {
  final int responsiveColumns;
  final double responsiveColumnWidth;
  final double responsiveGutterWidth;

  const SearchViewScreen(
      {Key? key,
      required this.responsiveColumns,
      required this.responsiveColumnWidth,
      required this.responsiveGutterWidth})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchViewScreenState();
}

class _SearchViewScreenState extends State<SearchViewScreen> {
  @override
  Widget build(BuildContext context) {
    Util.printTimeStamp("SearchViewScreen build");

    return FutureBuilder(
        future: Provider.of<SearchViewModel>(context).searchCompleter?.future,
        builder: (context, snapshot) {
          Util.printTimeStamp(snapshot.connectionState.toString());
          return Column(children: [
            Expanded(
              flex: 0,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 5.0,
                ),
                child: SearchBoxWidget(
                  responsiveColumns: widget.responsiveColumns,
                  responsiveColumnWidth: widget.responsiveColumnWidth,
                  responsiveGutterWidth: widget.responsiveGutterWidth,
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 5.0,
                ),
                child: Row(children: [
                  Expanded(flex: 1, child: _createSearchMessage(snapshot)),
                  Expanded(
                    flex: 1,
                    child: SortDropdown(
                      defaultSortKey:
                          Provider.of<SearchViewModel>(context).sortKey,
                      defaultSortOrder:
                          Provider.of<SearchViewModel>(context).order,
                    ),
                  )
                ]),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                    margin: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: _createSearchContent(snapshot)))
          ]);
        });
  }

  Widget _createSearchMessage(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        MIGException e = snapshot.error as MIGException;
        return Text(MIGExceptionMessages.get(context, e.exceptionCode));
      } else {
        SearchResult searchResult =
            Provider.of<SearchViewModel>(context).searchResult;
        List<CardInfoHeader> cards = searchResult.cards;
        var message =
            '''${cards.length} ${AppLocalizations.of(context)!.hit}''';
        return Text(message);
      }
    } else {
      return const Text("");
    }
  }

  Widget _createSearchContent(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.none) {
      return _createTutorialCard(context);
    } else if (snapshot.connectionState == ConnectionState.waiting) {
      //return const Center(child: CircularProgressIndicator());
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.searching),
        ],
      );
    } else {
      SearchResult searchResult =
          Provider.of<SearchViewModel>(context).searchResult;
      List<CardInfoHeader> cards = searchResult.cards;
      return GridView.count(
        controller: ScrollController(),
        crossAxisCount: widget.responsiveColumns ~/ 2,
        crossAxisSpacing: widget.responsiveGutterWidth,
        childAspectRatio: constants.cardAspectRatio,
        children: List.generate(
          cards.length,
          (index) {
            return GestureDetector(
              onTap: () => Provider.of<CanvasViewModel>(context, listen: false)
                  .addSelectedCards(
                      0, cards[index].copyWith(displayId: const Uuid().v1())),
              child: Container(
                  margin: const EdgeInsets.only(
                      top: 3.0, bottom: 3.0, left: 3.0, right: 3.0),
                  child: SearchCard(card: cards[index], scale: 1.0)),
            );
          },
        ),
      );
    }
  }

  Widget _createTutorialCard(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: widget.responsiveColumns * widget.responsiveColumnWidth +
            (widget.responsiveColumns - 1) * widget.responsiveGutterWidth,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20.0, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: ListTile(
                    title: Text(AppLocalizations.of(context)!.includedSets),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: ListTile(
                    title: Text(AppLocalizations.of(context)!.howToUse),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: ListTile(
                    leading: Text(AppLocalizations.of(context)!.step1Title),
                    title: Text(AppLocalizations.of(context)!.step1Content),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: ListTile(
                    leading: Text(AppLocalizations.of(context)!.step2Title),
                    title: Text(AppLocalizations.of(context)!.step2Content),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: ListTile(
                    leading: Text(AppLocalizations.of(context)!.step3Title),
                    title: Text(AppLocalizations.of(context)!.step3Content),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
