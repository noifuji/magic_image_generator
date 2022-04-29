

import 'package:flutter/cupertino.dart';
import 'package:magic_image_generator/view/search_box_widget.dart';
import 'package:provider/provider.dart';

import '../assets/constants.dart' as constants;
import '../assets/util.dart';
import '../model/card_info.dart';
import '../viewmodel/canvas_view_model.dart';
import '../viewmodel/search_view_model.dart';

class SearchViewScreen extends StatefulWidget {
  SearchViewScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchViewScreenState();
}

class _SearchViewScreenState extends State<SearchViewScreen> {

  @override
  Widget build(BuildContext context) {
    Util.printTimeStamp("SearchViewScreen build");
    List<CardInfo> searchResults = Provider.of<SearchViewModel>(context).searchResults;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(children: [
            Expanded(
                flex: 0,
                child: Container(
                  margin:const EdgeInsets.only(top: 5.0,),
                    child:SearchBoxWidget(parentWidth: constraints.maxWidth))),
            Expanded(
                flex: 1,
                child: Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: (constraints.maxWidth % constants.cardWidth) / 2 + 10.0,
                      right: (constraints.maxWidth % constants.cardWidth) / 2 + 10.0,
                    ),
                    child: GridView.count(
                      crossAxisCount: constraints.maxWidth ~/ constants.cardWidth,
                      childAspectRatio: constants.cardWidth / constants.cardHeight,
                      children: List.generate(searchResults.length, (index) {
                        return GestureDetector(
                            onTap: () {
                              Provider.of<CanvasViewModel>(context, listen: false).addSelectedCards(0, searchResults[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 3.0,
                                  bottom: 3.0,
                                  left: 3.0,
                                  right: 3.0),
                              child: Image.network(searchResults[index].imageUrl(Localizations.localeOf(context)),
                                  fit: BoxFit.contain, width: constants.cardWidth),
                            ));
                      }),
                    )))
          ]);
        });
  }

}