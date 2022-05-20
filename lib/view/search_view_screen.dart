

import 'package:flutter/cupertino.dart';
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
                    margin: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: GridView.count(
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
                    )))
          ]);
  }

}