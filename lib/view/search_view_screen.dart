

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:magic_image_generator/view/search_box_widget.dart';
import 'package:magic_image_generator/view/search_card.dart';
import 'package:magic_image_generator/view/sort_drop_down.dart';
import 'package:provider/provider.dart';

import '../assets/constants.dart' as constants;
import '../assets/mig_exception.dart';
import '../assets/util.dart';
import '../model/card_info_header.dart';
import '../model/search_result.dart';
import '../viewmodel/canvas_view_model.dart';
import '../viewmodel/search_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchViewScreen extends StatefulWidget {
  int responsiveColumns;
  double responsiveColumnWidth;
  double responsiveGutterWidth;

  SearchViewScreen({
    Key? key,
    required this.responsiveColumns,
    required this.responsiveColumnWidth,
    required this.responsiveGutterWidth
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchViewScreenState();
}

class _SearchViewScreenState extends State<SearchViewScreen> {

  @override
  Widget build(BuildContext context) {
    Util.printTimeStamp("SearchViewScreen build");

    SearchResult searchResult = Provider.of<SearchViewModel>(context).searchResult;
    List<CardInfoHeader> cards = searchResult.cards;

    if(cards.isNotEmpty) {
      print(cards[0].firstFace.name);
    }

    String message = "";

    if(searchResult.isSuccess) {
      message = '''${cards.length} ${AppLocalizations.of(context)!.hit}''';
    } else if(searchResult.exception != null) {
      message = MIGExceptionMessages.get(context, searchResult.exception!.exceptionCode);
    }

    return Column(children: [
            Expanded(
                flex: 0,
                child: Container(
                  margin:const EdgeInsets.only(top: 5.0,),
                    child:SearchBoxWidget(
                      responsiveColumns: widget.responsiveColumns,
                      responsiveColumnWidth: widget.responsiveColumnWidth,
                      responsiveGutterWidth: widget.responsiveGutterWidth,
                    ))),
            Expanded(
              flex: 0,
              child: Container(
                margin: const EdgeInsets.only(top: 5.0,),
                child: Row(children:[
                  Expanded(flex: 1,
                  child: Text(message)),
                  Expanded(flex: 1,
                    child: SortDropdown(
                      defaultSortKey: Provider.of<SearchViewModel>(context).sortKey,
                      defaultSortOrder: Provider.of<SearchViewModel>(context).order,
                    )
                  )
                ])
              )
            ),
            Expanded(
                flex: 1,
                child: Container(
                    margin: const EdgeInsets.only(top: 10.0,),
                    child: _createSearchContent(context, cards)))
          ]);
  }

  Widget _createSearchContent(BuildContext context, List<CardInfoHeader> cards) {
    if(Provider.of<SearchViewModel>(context).isSearching) {
      return const Center(child:CircularProgressIndicator());
    } else if(Provider.of<SearchViewModel>(context).searchResult.cards.isEmpty) {
      return _createTutorialCard(context);
    } else {
      return GridView.count(
        controller: ScrollController(),
        crossAxisCount: widget.responsiveColumns~/2,
        crossAxisSpacing: widget.responsiveGutterWidth,
        childAspectRatio: constants.cardAspectRatio,
        children: List.generate(cards.length, (index) {
          return GestureDetector(
              onTap: () => Provider.of<CanvasViewModel>(context, listen: false).addSelectedCards(0, cards[index].copyWith()),
              child: Container(
                  margin: const EdgeInsets.only(
                      top: 3.0,
                      bottom: 3.0,
                      left: 3.0,
                      right: 3.0),
                  child: SearchCard(card:cards[index], scale: 1.0)
              ));
        }),
      );
    }
  }

  Widget _createTutorialCard(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            width: widget.responsiveColumns * widget.responsiveColumnWidth + (widget.responsiveColumns-1) * widget.responsiveGutterWidth,
            child:Card(child:Padding(
                padding: const EdgeInsets.only(top:10,left: 20.0,bottom: 20),
                child:Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        margin:const EdgeInsets.only(top:5),
                        child: ListTile(
                          title: Text(AppLocalizations.of(context)!.includedSets),
                        )),
                    Container(
                        margin:const EdgeInsets.only(top:5),
                        child: ListTile(
                          title: Text(AppLocalizations.of(context)!.howToUse),
                        )),
                    Container(
                        margin:const EdgeInsets.only(top:5),
                        child: ListTile(
                          leading: Text(AppLocalizations.of(context)!.step1Title),
                          title: Text(AppLocalizations.of(context)!.step1Content),
                        )),
                    Container(
                        margin:const EdgeInsets.only(top:5),
                        child: ListTile(
                          leading: const Icon(Icons.tune),
                          title: Text(AppLocalizations.of(context)!.step1_5Content),
                        )),
                    Container(
                        margin:const EdgeInsets.only(top:5),
                        child: ListTile(
                          leading: Text(AppLocalizations.of(context)!.step2Title),
                          title: Text(AppLocalizations.of(context)!.step2Content),
                        )),
                    Container(
                        margin:const EdgeInsets.only(top:5),
                        child: ListTile(
                          leading: Text(AppLocalizations.of(context)!.step3Title),
                          title: Text(AppLocalizations.of(context)!.step3Content),
                        ))
                  ],
                )))));
  }

}