import 'dart:math';

import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:magic_image_generator/common/search_filter_factory.dart';
import 'package:magic_image_generator/viewmodel/search_view_model.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart' as constants;
import '../common/search_filter.dart';

class AdvancedSearchScreen extends StatefulWidget {
  const AdvancedSearchScreen({super.key});

  @override
  State<AdvancedSearchScreen> createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  final List<SearchFilter> _rarities = [
    SearchFilter.rarityCommon,
    SearchFilter.rarityUncommon,
    SearchFilter.rarityRare,
    SearchFilter.rarityMythic
  ];

  final List<SearchFilter> _cardTypes = [
    SearchFilter.typeCreature,
    SearchFilter.typePlaneswalker,
    SearchFilter.typeInstant,
    SearchFilter.typeSorcery,
    SearchFilter.typeEnchantment,
    SearchFilter.typeArtifact,
    SearchFilter.typeLand,
    SearchFilter.typeBattle,
  ];

  final List<SearchFilter> _costValues = [
    SearchFilter.manaValue0,
    SearchFilter.manaValue1,
    SearchFilter.manaValue2,
    SearchFilter.manaValue3,
    SearchFilter.manaValue4,
    SearchFilter.manaValue5,
    SearchFilter.manaValue6,
    SearchFilter.manaValue7AndMore
  ];

  final List<SearchFilter> _colors = [
    SearchFilter.colorWhite,
    SearchFilter.colorBlue,
    SearchFilter.colorBlack,
    SearchFilter.colorRed,
    SearchFilter.colorGreen,
    SearchFilter.colorColorless,
    SearchFilter.colorMulti
  ];

  final List<SearchFilter> _cardSets = [
    SearchFilter.setDsk,
    SearchFilter.setBlb,
    SearchFilter.setBig,
    SearchFilter.setOtj,
    SearchFilter.setMkm,
    SearchFilter.setLci,
    SearchFilter.setWoe,
    SearchFilter.setMat,
    SearchFilter.setMom,
    SearchFilter.setOne,
    SearchFilter.setBro,
    SearchFilter.setDmu,
    SearchFilter.setSnc,
    SearchFilter.setNeo,
    SearchFilter.setVow,
    SearchFilter.setMid,
    SearchFilter.setAfr,
    SearchFilter.setStx,
    SearchFilter.setKhm,
    SearchFilter.setZnr,
    SearchFilter.setM21,
    SearchFilter.setIko,
    SearchFilter.setThb,
    SearchFilter.setEld,
    SearchFilter.setM20,
    SearchFilter.setWar,
    SearchFilter.setRna,
    SearchFilter.setGrn,
    SearchFilter.setM19,
    SearchFilter.setDom,
    SearchFilter.setRix,
    SearchFilter.setXln,
    SearchFilter.setHou,
    SearchFilter.setAkh,
    SearchFilter.setAer,
    SearchFilter.setKld,
    SearchFilter.setEmn,
    SearchFilter.setSoi,
    SearchFilter.setOgw,
    SearchFilter.setBfz,
    SearchFilter.setOri,
    SearchFilter.setDtk,
    SearchFilter.setFrf,
    SearchFilter.setKtk,
    SearchFilter.setM15,
    SearchFilter.setJou,
    SearchFilter.setBng,
    SearchFilter.setThs,
    SearchFilter.setM14,
    SearchFilter.setDgm,
    SearchFilter.setGtc,
    SearchFilter.setRtr,
  ];

  final List<SearchFilter> _alchemyCardSets = [
    SearchFilter.setYblb,
    SearchFilter.setYotj,
    SearchFilter.setYmkm,
    SearchFilter.setYlci,
    SearchFilter.setYwoe,
    SearchFilter.setLtr,
    SearchFilter.setYone,
    SearchFilter.setYbro,
    SearchFilter.setYdmu,
    SearchFilter.setHbg,
    SearchFilter.setYSnc,
    SearchFilter.setYNeo,
    SearchFilter.setYMid
  ];

  final List<SearchFilter> _supplementalSet = [
    SearchFilter.setMh3,
    SearchFilter.setOtp,
    SearchFilter.setWot,
    SearchFilter.setSpg,
    SearchFilter.setMul,
    SearchFilter.setSis,
    SearchFilter.setBrr,
    SearchFilter.setJ21,
    SearchFilter.setSta,
    SearchFilter.setJmp,
    SearchFilter.setHa7,
    SearchFilter.setHa6,
    SearchFilter.setHa5,
    SearchFilter.setHa4,
    SearchFilter.setHa3,
    SearchFilter.setHa2,
    SearchFilter.setHa1,
    SearchFilter.setAnb,
  ];

  final List<SearchFilter> kStandardLegalSets = [
    SearchFilter.setDsk,
    SearchFilter.setBlb,
    SearchFilter.setBig,
    SearchFilter.setOtj,
    SearchFilter.setMkm,
    SearchFilter.setLci,
    SearchFilter.setWoe,
    SearchFilter.setMat,
    SearchFilter.setMom,
    SearchFilter.setOne,
    SearchFilter.setBro,
    SearchFilter.setDmu,
  ];

  late final ScrollController rightPaneScrollController;
  late final ScrollController mobilePaneScrollController;

  @override
  void initState() {
    super.initState();
    rightPaneScrollController = ScrollController(
      initialScrollOffset: Provider.of<SearchViewModel>(context, listen: false)
          .advancedSearchScrollPosition,
    );
    mobilePaneScrollController = ScrollController(
      initialScrollOffset: Provider.of<SearchViewModel>(context, listen: false)
          .advancedSearchScrollPositionMobile,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final breakpoint = Breakpoint.fromConstraints(constraints);

      int rarityColNum;
      int cardTypeColNum;
      int cardSetColNum;
      int columnSize;
      int bottomBarMarginColSize;
      int bottomBarCenterSpaceColSize;

      if (breakpoint.columns > 8) {
        rarityColNum = 4;
        cardTypeColNum = 4;
        cardSetColNum = 2;
        columnSize = breakpoint.columns ~/ 2;
        bottomBarMarginColSize = 3;
        bottomBarCenterSpaceColSize = 2;
      } else if (breakpoint.columns <= 8 && breakpoint.columns > 4) {
        rarityColNum = 4;
        cardTypeColNum = 4;
        cardSetColNum = 2;
        columnSize = breakpoint.columns;
        bottomBarMarginColSize = 2;
        bottomBarCenterSpaceColSize = 0;
      } else {
        rarityColNum = 4;
        cardTypeColNum = 2;
        cardSetColNum = 1;
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

      final leftWidgets = <Widget>[
        Container(
          height: responsive.verticalMarginHeight,
        ),
        _createTitle(context, AppLocalizations.of(context)!.filterTitleColor,
            responsive),
        Container(
          height: responsive.verticalGutterHeight,
        ),
        _createColorButtons(context, responsive),
        Container(
          height: responsive.verticalGutterHeight,
        ),
        _createTitle(context, AppLocalizations.of(context)!.filterTitleRarity,
            responsive),
        ..._createButtonRows(context, _rarities, rarityColNum, responsive),
        _createTitle(
            context, AppLocalizations.of(context)!.filterTitleType, responsive),
        ..._createButtonRows(context, _cardTypes, cardTypeColNum, responsive),
      ];

      final rightWidgets = <Widget>[
        Container(
          height: responsive.verticalMarginHeight,
        ),

        //マナコスト
        _createTitle(context,
            AppLocalizations.of(context)!.filterTitleManaValue, responsive),
        Container(
          height: responsive.verticalGutterHeight,
        ),
        _createManaValueButtons(context, responsive),
        Container(
          height: responsive.verticalGutterHeight,
        ),

        //カードセット
        _createTitle(
            context, AppLocalizations.of(context)!.filterTitleSet, responsive),
        _createCardSetFilter(context, responsive),
        ..._createButtonRows(context, _cardSets, cardSetColNum, responsive),

        //アルケミーカードセット
        _createTitle(context,
            AppLocalizations.of(context)!.filterTitleAlchemySet, responsive),
        ..._createButtonRows(
            context, _alchemyCardSets, cardSetColNum, responsive),

        //サプリメントセット
        _createTitle(
            context,
            AppLocalizations.of(context)!.filterTitleSupplementalSet,
            responsive),
        ..._createButtonRows(
            context, _supplementalSet, cardSetColNum, responsive)
      ];

      final widgetsForMobile = <Widget>[
        Container(
          height: responsive.verticalMarginHeight,
        ),

        _createTitle(context, AppLocalizations.of(context)!.filterTitleColor,
            responsive),
        Container(
          height: responsive.verticalGutterHeight,
        ),
        _createColorButtons(context, responsive),
        Container(
          height: responsive.verticalGutterHeight,
        ),

        //マナコスト
        _createTitle(context,
            AppLocalizations.of(context)!.filterTitleManaValue, responsive),
        Container(
          height: responsive.verticalGutterHeight,
        ),
        _createManaValueButtons(context, responsive),
        Container(
          height: responsive.verticalGutterHeight,
        ),

        //レアリティ
        _createTitle(context, AppLocalizations.of(context)!.filterTitleRarity,
            responsive),
        Container(
          height: responsive.verticalGutterHeight,
        ),
        ..._createButtonRows(context, _rarities, rarityColNum, responsive),
        Container(
          height: responsive.verticalGutterHeight,
        ),

        //カードタイプ
        _createTitle(
            context, AppLocalizations.of(context)!.filterTitleType, responsive),
        ..._createButtonRows(context, _cardTypes, cardTypeColNum, responsive),
        Container(
          height: responsive.verticalGutterHeight,
        ),

        //カードセット
        _createTitle(
            context, AppLocalizations.of(context)!.filterTitleSet, responsive),
        _createCardSetFilter(context, responsive),
        ..._createButtonRows(context, _cardSets, cardSetColNum, responsive),
        Container(
          height: responsive.verticalGutterHeight,
        ),

        //アルケミーカードセット
        _createTitle(context,
            AppLocalizations.of(context)!.filterTitleAlchemySet, responsive),
        ..._createButtonRows(
            context, _alchemyCardSets, cardSetColNum, responsive),

        //サプリメントセット
        _createTitle(
            context,
            AppLocalizations.of(context)!.filterTitleSupplementalSet,
            responsive),
        ..._createButtonRows(
            context, _supplementalSet, cardSetColNum, responsive),
      ];

      return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.advancedSearch),
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
                    children: breakpoint.columns > 8
                        ? ([
                            Expanded(
                                flex: 1,
                                child: ListView.builder(
                                    itemCount: leftWidgets.length,
                                    itemBuilder: (context, index) =>
                                        leftWidgets[index])),
                            Container(width: responsive.horizontalGutterWidth),
                            Expanded(
                                flex: 1,
                                child: ListView.builder(
                                    controller: rightPaneScrollController,
                                    itemCount: rightWidgets.length,
                                    itemBuilder: (context, index) =>
                                        rightWidgets[index])),
                          ])
                        : ([
                            Expanded(
                              flex: 1,
                              child: ListView.builder(
                                  controller: mobilePaneScrollController,
                                  scrollDirection: Axis.vertical,
                                  itemCount: widgetsForMobile.length,
                                  itemBuilder: (context, index) =>
                                      widgetsForMobile[index]),
                            ),
                          ]),
                  ),
                ),
                SizedBox(
                    height: responsive.rowHeight,
                    child: Row(children: [
                      Container(
                        width: responsive.columnWidth * bottomBarMarginColSize +
                            responsive.horizontalGutterWidth *
                                bottomBarMarginColSize,
                      ),
                      SizedBox(
                        width: responsive.columnWidth * 2 +
                            responsive.horizontalGutterWidth,
                        height: responsive.rowHeight * 0.6,
                        child: TextButton(
                          onPressed: () {
                            Provider.of<SearchViewModel>(context, listen: false)
                                .resetSearchFilter();
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.grey),
                          child: Text(
                            AppLocalizations.of(context)!.resetButton,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    responsive.rowHeight * 0.6 * 0.75 * 0.5),
                          ),
                        ),
                      ),
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
                                    content: Text(AppLocalizations.of(context)!
                                        .exceptionCode310),
                                  ));
                                  return;
                                }

                                if (rightPaneScrollController.hasClients) {
                                  Provider.of<SearchViewModel>(context,
                                              listen: false)
                                          .advancedSearchScrollPosition =
                                      rightPaneScrollController.position.pixels;
                                }
                                if (mobilePaneScrollController.hasClients) {
                                  Provider.of<SearchViewModel>(context,
                                              listen: false)
                                          .advancedSearchScrollPositionMobile =
                                      mobilePaneScrollController
                                          .position.pixels;
                                }
                                Navigator.pop(context);
                                List<SearchFilterData> filerDataList =
                                    SearchFilter.values
                                        .map((e) => SearchFilterFactory
                                            .createSearchFilter(context, e))
                                        .toList();
                                Provider.of<SearchViewModel>(context,
                                        listen: false)
                                    .search(Localizations.localeOf(context),
                                        filerDataList);
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.orange),
                              child: Text(
                                  AppLocalizations.of(context)!.searchButton,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsive.rowHeight *
                                          0.6 *
                                          0.75 *
                                          0.5)))),
                    ]))
              ])));
    });
  }

  Widget _createCardSetFilter(context, responsive) {
    return SizedBox(
      height: responsive.rowHeight,
      child: Row(children: [
        Container(width: responsive.horizontalGutterWidth),
        SizedBox(
          width: responsive.columnWidth * 2 + responsive.horizontalGutterWidth,
          height: responsive.rowHeight * 0.6,
          child: TextButton(
            onPressed: () {
              final model =
                  Provider.of<SearchViewModel>(context, listen: false);
              model.resetSearchFilter();
              model.setSearchFilters(kStandardLegalSets);
            },
            style: TextButton.styleFrom(backgroundColor: Colors.grey),
            child: Text(
              AppLocalizations.of(context)!.filterStandardButton,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: responsive.rowHeight * 0.6 * 0.75 * 0.5),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _createTitle(
      BuildContext context, String title, ResponsiveGridValues res) {
    return SizedBox(
        width: res.columnSize * res.columnWidth +
            (res.columnSize - 1) * res.horizontalGutterWidth,
        height: res.rowHeight,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              height: res.rowHeight * 0.6,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withAlpha(50),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                  padding: EdgeInsets.only(left: res.horizontalGutterWidth),
                  child: Row(children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: res.rowHeight * 0.6 * 0.75 * 0.8),
                    )
                  ])))
        ]));
  }

  Widget _createColorButtons(BuildContext context, ResponsiveGridValues res) {
    double w = res.columnWidth *
        (res.columnSize * res.columnWidth +
            (res.columnSize - 1) * res.horizontalGutterWidth) /
        (_colors.length * res.columnWidth +
            (_colors.length - 1) * res.horizontalGutterWidth);
    double g = w * res.horizontalGutterWidth / res.columnWidth;
    List<Widget> result = [];

    for (var i = 0; i < _colors.length; i++) {
      bool isOn =
          Provider.of<SearchViewModel>(context).searchFilters[_colors[i]]!;
      result.add(Container(
          margin: i < _colors.length - 1
              ? EdgeInsets.only(right: g)
              : const EdgeInsets.only(),
          width: w,
          height: res.rowHeight,
          child: Opacity(
              opacity: isOn ? 1.0 : 0.3,
              child: IconButton(
                  onPressed: () {
                    Provider.of<SearchViewModel>(context, listen: false)
                        .switchSearchFilter(_colors[i]);
                  },
                  padding: EdgeInsets.zero,
                  splashColor: Colors.transparent,
                  icon: Image.asset(
                      constants.searchFilterColorImagePath[_colors[i]]!)))));
    }
    return Row(children: result);
  }

  Widget _createManaValueButtons(
      BuildContext context, ResponsiveGridValues res) {
    double w = res.columnWidth *
        (res.columnSize * res.columnWidth +
            (res.columnSize - 1) * res.horizontalGutterWidth) /
        (_costValues.length * res.columnWidth +
            (_costValues.length - 1) * res.horizontalGutterWidth);
    double g = w * res.horizontalGutterWidth / res.columnWidth;

    List<Widget> result = [];

    for (var i = 0; i < _costValues.length; i++) {
      bool isOn =
          Provider.of<SearchViewModel>(context).searchFilters[_costValues[i]]!;
      result.add(Container(
          margin: i < _costValues.length - 1
              ? EdgeInsets.only(right: g)
              : const EdgeInsets.only(),
          width: w,
          height: res.rowHeight,
          child: /* FittedBox(
              fit: BoxFit.contain,
              child: */
              Opacity(
                  opacity: isOn ? 1.0 : 0.3,
                  child: TextButton(
                    onPressed: () {
                      Provider.of<SearchViewModel>(context, listen: false)
                          .switchSearchFilter(_costValues[i]);
                    },
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white70,
                      side: const BorderSide(color: Colors.black),
                    ),
                    child: Text(
                        SearchFilterFactory.createSearchFilter(
                                context, _costValues[i])
                            .name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: min(w, res.rowHeight) * 0.75 * 0.5)),
                  ))));
    }
    return Row(children: result);
  }

  List<Widget> _createButtonRows(BuildContext context,
      List<SearchFilter> filters, int column, ResponsiveGridValues res) {
    int rows = filters.length ~/ column;
    rows = rows + (filters.length % column > 0 ? 1 : 0);

    List<Widget> result = [
      Container(height: res.verticalGutterHeight),
    ];
    for (var i = 0; i < rows; i++) {
      result.add(_createTextButtons(
          context,
          filters.sublist(
              i * column,
              (i * column + column) >= filters.length
                  ? filters.length
                  : (i * column + column)),
          column,
          res));
      result.add(
        Container(
          height: res.verticalGutterHeight,
        ),
      );
    }
    return result;
  }

  //トグルボタンの行を作成
  Widget _createTextButtons(BuildContext context, List<SearchFilter> filters,
      int length, ResponsiveGridValues res) {
    double w = res.columnWidth *
        (res.columnSize * res.columnWidth +
            (res.columnSize - 1) * res.horizontalGutterWidth) /
        (length * res.columnWidth + (length - 1) * res.horizontalGutterWidth);
    double g = w * res.horizontalGutterWidth / res.columnWidth;

    List<Widget> result = [];

    for (var i = 0; i < filters.length; i++) {
      result.add(Container(
          margin: i < filters.length - 1
              ? EdgeInsets.only(right: g)
              : const EdgeInsets.only(),
          child:
              _createToggleTextButton(context, filters[i], w, res.rowHeight)));
    }
    return Row(children: result);
  }

/*テキストトグルボタンの仕様
   * ・width, heightを指定できる
   * ・クリックするとON/OFFがスイッチする
   * ・ON/OFFの状態に応じて表示を切り替える
   * ・ONのとき　透明度100% 　オレンジの放射状グラデーション　文字色白
   * ・OFFのとき　透明度50%　文字色白
   * ・表示するテキストを指定できる
   */
  Widget _createToggleTextButton(
      BuildContext context, SearchFilter filter, double w, double h) {
    bool isOn = Provider.of<SearchViewModel>(context).searchFilters[filter]!;
    return Stack(
      children: [
        Transform.scale(
            scaleY: 0.5,
            scaleX: 2,
            origin: Offset(-w * 0.25, 0),
            child: Container(
              width: 0.5 * w,
              height: h,
              decoration: isOn
                  ? BoxDecoration(
                      gradient: RadialGradient(
                        radius: 0.5,
                        colors: [
                          Colors.orange.withAlpha(100),
                          Theme.of(context).canvasColor
                        ],
                      ),
                    )
                  : const BoxDecoration(),
            )),
        SizedBox(
            width: w,
            height: h,
            child: TextButton(
                onPressed: () {
                  //ビューモデルの値を変更する
                  Provider.of<SearchViewModel>(context, listen: false)
                      .switchSearchFilter(filter);
                },
                style: isOn
                    ? TextButton.styleFrom(
                        backgroundColor: Colors.orange.withAlpha(10),
                        splashFactory: NoSplash.splashFactory)
                    : TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory),
                child: Text(
                  SearchFilterFactory.createSearchFilter(context, filter).name,
                  style: TextStyle(
                      color: isOn
                          ? Colors.white.withAlpha(255)
                          : Colors.white.withAlpha(150),
                      fontSize: h * 0.75 * 0.3),
                )))
      ],
    );
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
