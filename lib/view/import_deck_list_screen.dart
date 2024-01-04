import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:magic_image_generator/common/search_filter_factory.dart';
import 'package:magic_image_generator/viewmodel/search_view_model.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart';
import '../common/search_filter.dart';

class ImportDeckListScreen extends StatefulWidget {
  const ImportDeckListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ImportDeckListScreenState();
}

class ImportDeckListScreenState extends State<ImportDeckListScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final breakpoint = Breakpoint.fromConstraints(constraints);

      int columnSize;
      int bottomBarMarginColSize;
      int bottomBarCenterSpaceColSize;

      if (breakpoint.columns > 8) {
        columnSize = breakpoint.columns ~/ 2;
        bottomBarMarginColSize = 3;
        bottomBarCenterSpaceColSize = 2;
      } else if (breakpoint.columns <= 8 && breakpoint.columns > 4) {
        columnSize = breakpoint.columns;
        bottomBarMarginColSize = 2;
        bottomBarCenterSpaceColSize = 0;
      } else {
        columnSize = breakpoint.columns;
        bottomBarMarginColSize = 0;
        bottomBarCenterSpaceColSize = 0;
      }

      ResponsiveGridValues responsive = ResponsiveGridValues(
          columnSize: columnSize,
          displayColumnSize: breakpoint.columns,
          maxWidth: constraints.maxWidth,
          gutterWidth: breakpoint.gutters,
          maxHeight: constraints.maxHeight);

      return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.importDeckTitle),
          ),
          body: Container(
              margin: EdgeInsets.only(
                  left: responsive.horizontalMarginWidth,
                  right: responsive.horizontalMarginWidth),
              child: Column(children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: ([
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _controller,
                          maxLines: null,
                          minLines: 6,
                          decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.importDeckHint,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Expanded(
                    flex: 0,
                    child: SizedBox(
                        height: responsive.rowHeight,
                        child: Row(children: [
                          Container(
                            width: responsive.columnWidth *
                                    bottomBarMarginColSize +
                                responsive.horizontalGutterWidth *
                                    bottomBarMarginColSize,
                          ),
                          SizedBox(
                              width: responsive.columnWidth * 2 +
                                  responsive.horizontalGutterWidth,
                              height: responsive.rowHeight * 0.6,
                              child: TextButton(
                                  onPressed: () {
                                    _controller.clear();
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.grey),
                                  child: Text(
                                      AppLocalizations.of(context)!.resetButton,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: responsive.rowHeight *
                                              0.6 *
                                              0.75 *
                                              0.5)))),
                          Container(
                            width: responsive.columnWidth *
                                    bottomBarCenterSpaceColSize +
                                responsive.horizontalGutterWidth *
                                    (bottomBarMarginColSize + 1),
                          ),
                          SizedBox(
                              width: responsive.columnWidth * 2 +
                                  responsive.horizontalGutterWidth,
                              height: responsive.rowHeight * 0.6,
                              child: TextButton(
                                  onPressed: () async {
                                    if (Provider.of<SearchViewModel>(context,
                                            listen: false)
                                        .isSearching()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            AppLocalizations.of(context)!
                                                .exceptionCode310),
                                      ));
                                      return;
                                    }

                                    String rawDeckList = _controller.text;

                                    Navigator.pop(context);
                                    try {
                                      List<SearchFilterData> filerDataList =
                                          SearchFilter.values
                                              .map((e) => SearchFilterFactory
                                                  .createSearchFilter(
                                                      context, e))
                                              .toList();
                                      await Provider.of<SearchViewModel>(
                                              context,
                                              listen: false)
                                          .searchByDeckList(
                                              Localizations.localeOf(context),
                                              filerDataList,
                                              rawDeckList, {
                                        ArenaDeckListGroup.main:
                                            AppLocalizations.of(context)!
                                                .arenaDeckListGroupMain,
                                        ArenaDeckListGroup.sideboard:
                                            AppLocalizations.of(context)!
                                                .arenaDeckListGroupSideboard,
                                        ArenaDeckListGroup.companion:
                                            AppLocalizations.of(context)!
                                                .arenaDeckListGroupCompanion,
                                        ArenaDeckListGroup.commander:
                                            AppLocalizations.of(context)!
                                                .arenaDeckListGroupCommander,
                                      });
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            AppLocalizations.of(context)!
                                                .exceptionCode410),
                                      ));
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.orange),
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .searchButton,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: responsive.rowHeight *
                                              0.6 *
                                              0.75 *
                                              0.5)))),
                        ])))
              ])));
    });
  }
}

class ResponsiveGridValues {
  late int columnSize;
  late int displayColumnSize;
  late double columnWidth;
  late double horizontalGutterWidth;
  late double horizontalMarginWidth;

  int rowSize = 8;
  late double rowHeight;
  late double verticalGutterHeight;
  late double verticalMarginHeight;

  ResponsiveGridValues({
    required this.columnSize,
    required this.displayColumnSize,
    required gutterWidth,
    required double maxWidth,
    required double maxHeight,
  }) {
    horizontalGutterWidth = gutterWidth;
    horizontalMarginWidth = gutterWidth;
    columnWidth = (maxWidth -
            horizontalMarginWidth * 2 -
            horizontalGutterWidth * (displayColumnSize - 1)) /
        displayColumnSize;

    verticalGutterHeight = gutterWidth;
    verticalMarginHeight = gutterWidth;
    rowHeight =
        (maxHeight - (rowSize + 1) * verticalGutterHeight) / (rowSize + 1);
  }
}
