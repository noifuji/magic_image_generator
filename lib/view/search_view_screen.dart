

import 'package:flutter/cupertino.dart';
import 'package:magic_image_generator/view/search_box_widget.dart';
import 'package:provider/provider.dart';

import '../assets/constants.dart' as constants;
import '../assets/util.dart';
import '../model/card_info.dart';
import '../model/card_info_header.dart';
import '../viewmodel/canvas_view_model.dart';
import '../viewmodel/search_view_model.dart';

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
    List<CardInfoHeader> searchResults = Provider.of<SearchViewModel>(context).searchResults;

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
                flex: 1,
                child: Container(
                    margin: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: GridView.count(
                      crossAxisCount: widget.responsiveColumns~/2,
                      crossAxisSpacing: widget.responsiveGutterWidth,
                      childAspectRatio: constants.cardAspectRatio,
                      children: List.generate(searchResults.length, (index) {
                        return GestureDetector(
                            onTap: () {
                              Provider.of<CanvasViewModel>(context, listen: false).addSelectedCards(0, searchResults[index].copyWith());
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 3.0,
                                  bottom: 3.0,
                                  left: 3.0,
                                  right: 3.0),
                              child: Image.network(searchResults[index].cardFaces[0].imageUrl(Localizations.localeOf(context)),
                                  fit: BoxFit.contain, width: constants.rawCardImageWidth),
                            ));
                      }),
                    )))
          ]);
  }

}