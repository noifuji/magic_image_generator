import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magic_image_generator/viewmodel/search_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AdvancedSearchScreen extends StatelessWidget {
  final List<SearchFilter> _rarities = [
    SearchFilter.rarityCommon,
    SearchFilter.rarityUncommon,
    SearchFilter.rarityRare,
    SearchFilter.rarityMythic,];

  final List<SearchFilter> _cardTypes =[
    SearchFilter.typeCreature,SearchFilter.typePlaneswalker,SearchFilter.typeInstant,
  SearchFilter.typeSorcery,SearchFilter.typeEnchantment,SearchFilter.typeArtifact,
  SearchFilter.typeLand,];

  final List<SearchFilter> _cardSets = [
    SearchFilter.setSnc,SearchFilter.setNeo,SearchFilter.setVow,SearchFilter.setMid,
  SearchFilter.setAfr,SearchFilter.setStx,SearchFilter.setKhm,SearchFilter.setZnr,];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final _breakpoint = Breakpoint.fromConstraints(constraints);

      int rarityColNum ;
      int cardTypeColNum;
      int cardSetColNum;
      int columnSize;
      int bottomBarMarginColSize;
      int bottomBarCenterSpaceColSize;

      if(_breakpoint.columns > 8) {
        rarityColNum = 4;
        cardTypeColNum = 4;
        cardSetColNum = 2;
        columnSize = _breakpoint.columns ~/ 2;
        bottomBarMarginColSize = 3;
        bottomBarCenterSpaceColSize = 2;
      } else if(_breakpoint.columns <= 8 && _breakpoint.columns > 4) {
        rarityColNum = 4;
        cardTypeColNum = 4;
        cardSetColNum = 2;
        columnSize = _breakpoint.columns;
        bottomBarMarginColSize = 2;
        bottomBarCenterSpaceColSize = 0;
      } else {
        rarityColNum = 4;
        cardTypeColNum = 2;
        cardSetColNum = 1;
        columnSize = _breakpoint.columns;
        bottomBarMarginColSize = 0;
        bottomBarCenterSpaceColSize = 0;
      }

      ResponsiveGridValues responsive = ResponsiveGridValues(
          columnSize: columnSize,
          displayColumnSize: _breakpoint.columns,
          maxWidth: constraints.maxWidth,
          gutterWidth: _breakpoint.gutters,
          maxHeight: constraints.maxHeight);

      return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.advancedSearch),
          ),
          body: Container(
              margin: EdgeInsets.only(left: responsive.horizontalMarginWidth, right: responsive.horizontalMarginWidth),
              child: Column(children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _breakpoint.columns > 8? ([
                      Expanded(
                          flex: 1,
                          child: Column(children: [
                            Container(height: responsive.horizontalMarginWidth,),

                            _createTitle(context, AppLocalizations.of(context)!.filterTitleColor, responsive),
                            Container(height: responsive.verticalGutterHeight,),
                            _createColorButtons(context, responsive),
                            Container(height: responsive.verticalGutterHeight,),

                            _createTitle(context, AppLocalizations.of(context)!.filterTitleRarity, responsive),
                            Container(height: responsive.verticalGutterHeight,),
                            _createButtonGrid(context,_rarities, rarityColNum, responsive),
                            Container(height: responsive.verticalGutterHeight,),
                            _createTitle(context, AppLocalizations.of(context)!.filterTitleType, responsive),
                            _createButtonGrid(context,_cardTypes, cardTypeColNum,responsive)
                          ])),
                      Container(width:responsive.horizontalGutterWidth),
                      Expanded(
                          flex: 1,
                          child: SingleChildScrollView(child:Column(children: [
                            Container(height: responsive.verticalMarginHeight,),

                            //マナコスト
                            _createTitle(context, AppLocalizations.of(context)!.filterTitleManaValue, responsive),
                            Container(height: responsive.verticalGutterHeight,),
                            _createManaValueButtons(context,  responsive),
                            Container(height: responsive.verticalGutterHeight,),

                            //カードセット
                            _createTitle(context, AppLocalizations.of(context)!.filterTitleSet, responsive),
                            _createButtonGrid(context,_cardSets, cardSetColNum, responsive)
                          ]))),
                    ]) : ([

                      SingleChildScrollView(child:
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Container(height: responsive.verticalMarginHeight,),

                        _createTitle(context, AppLocalizations.of(context)!.filterTitleColor, responsive),
                        Container(height: responsive.verticalGutterHeight,),
                        _createColorButtons(context, responsive),
                        Container(height: responsive.verticalGutterHeight,),

                        //マナコスト
                        _createTitle(context, AppLocalizations.of(context)!.filterTitleManaValue, responsive),
                        Container(height: responsive.verticalGutterHeight,),
                        _createManaValueButtons(context,  responsive),
                        Container(height: responsive.verticalGutterHeight,),

                        //レアリティ
                        _createTitle(context, AppLocalizations.of(context)!.filterTitleRarity, responsive),
                        Container(height: responsive.verticalGutterHeight,),
                        _createButtonGrid(context,_rarities, rarityColNum, responsive),
                        Container(height: responsive.verticalGutterHeight,),

                        //カードタイプ
                        _createTitle(context, AppLocalizations.of(context)!.filterTitleType, responsive),
                        _createButtonGrid(context,_cardTypes, cardTypeColNum,responsive),
                        Container(height: responsive.verticalGutterHeight,),

                        //カードセット
                        _createTitle(context, AppLocalizations.of(context)!.filterTitleSet, responsive),
                        _createButtonGrid(context,_cardSets, cardSetColNum, responsive)
                      ]))

                    ]),
                  ),
                ),
                Expanded(
                    flex: 0,
                    child: Container(
                        height: responsive.rowHeight,
                        child: Row(children: [
                          Container(width: responsive.columnWidth*bottomBarMarginColSize + responsive.horizontalGutterWidth*bottomBarMarginColSize,),
                          Container(
                              width: responsive.columnWidth*2 + responsive.horizontalGutterWidth,
                              height: responsive.rowHeight * 0.6,
                              child:TextButton(
                                  onPressed: () {
                                    Provider.of<SearchViewModel>(context, listen: false).resetSearchFilter();
                                  },
                                  style: TextButton.styleFrom(backgroundColor: Colors.grey),
                                  child: Text(AppLocalizations.of(context)!.resetButton,
                                      style: const TextStyle(color:Colors.white, fontSize: 20)))),
                          Container(width: responsive.columnWidth*bottomBarCenterSpaceColSize + responsive.horizontalGutterWidth*(bottomBarMarginColSize + 1),),
                          Container(
                              width: responsive.columnWidth*2 + responsive.horizontalGutterWidth,
                              height: responsive.rowHeight * 0.6,
                              child:TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await Provider.of<SearchViewModel>(context, listen: false).searchFromAdvanced(Localizations.localeOf(context));
                                  },
                                  style: TextButton.styleFrom(backgroundColor: Colors.orange),
                                  child: Text(AppLocalizations.of(context)!.searchButton,
                                      style: const TextStyle(color:Colors.white, fontSize: 20)))),
                        ])))
              ])));
    });
  }

  Widget _createTitle(BuildContext context, String title, ResponsiveGridValues res) {
    return Container(
      width: res.columnSize * res.columnWidth + (res.columnSize -1) * res.horizontalGutterWidth,
      height:res.rowHeight,
          child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Container(
            height: res.rowHeight*0.6,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withAlpha(50),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(padding: EdgeInsets.only(left:res.horizontalGutterWidth),
            child:Row(children:[Text(title, style: TextStyle(fontSize: 24),)])))]));
  }

  Widget _createColorButtons(BuildContext context, ResponsiveGridValues res) {
    List<SearchFilter> filters = [SearchFilter.colorWhite,SearchFilter.colorBlue,
      SearchFilter.colorBlack, SearchFilter.colorRed,
      SearchFilter.colorGreen, SearchFilter.colorColorless,
      SearchFilter.colorMulti,];

    double w = res.columnWidth *
        (res.columnSize * res.columnWidth + (res.columnSize - 1) * res.horizontalGutterWidth) /
        (filters.length * res.columnWidth + (filters.length - 1) * res.horizontalGutterWidth);
    double g = w * res.horizontalGutterWidth / res.columnWidth;

    List<Widget> result = [];

    for (var i = 0; i < filters.length; i++) {
      bool isOn = Provider.of<SearchViewModel>(context).searchFilters[filters[i]]!;
      result.add(Container(
          margin: i < filters.length - 1
              ? EdgeInsets.only(right: g)
              : const EdgeInsets.only(),
          width: w,
          height: res.rowHeight,
          child: IconButton(
              onPressed: () {
                Provider.of<SearchViewModel>(context, listen: false).switchSearchFilter(filters[i]);
                },
              icon: Opacity(opacity:isOn? 1.0: 0.3, child:Image.asset(_getFilterText(context, filters[i]),)))));
    }
    return Row(children: result);
  }

  Widget _createManaValueButtons(BuildContext context,ResponsiveGridValues res) {
  List<SearchFilter> filters = [
      SearchFilter.manaValue0,
      SearchFilter.manaValue1,
      SearchFilter.manaValue2,
      SearchFilter.manaValue3,
      SearchFilter.manaValue4,
      SearchFilter.manaValue5,
      SearchFilter.manaValue6,
      SearchFilter.manaValue7AndMore,
    ];
    double w = res.columnWidth *
        (res.columnSize * res.columnWidth + (res.columnSize - 1) * res.horizontalGutterWidth) /
        (filters.length * res.columnWidth + (filters.length - 1) * res.horizontalGutterWidth);
    double g = w * res.horizontalGutterWidth / res.columnWidth;

    List<Widget> result = [];

    for (var i = 0; i < filters.length; i++) {

      bool isOn = Provider.of<SearchViewModel>(context).searchFilters[filters[i]]!;
      result.add(Container(
          margin: i < filters.length - 1
              ? EdgeInsets.only(right: g)
              : const EdgeInsets.only(),
          width: w,
          height: res.rowHeight,
          child: FittedBox(
              fit: BoxFit.contain,
              child: Opacity(opacity:isOn? 1.0: 0.3, child:TextButton(
              onPressed: () {
                Provider.of<SearchViewModel>(context, listen: false).switchSearchFilter(filters[i]);
              },
              style: TextButton.styleFrom(
                  shape: const CircleBorder(),
                backgroundColor: Colors.white70,
              ),
            child: Text(_getFilterText(context, filters[i]),
                style: TextStyle(color: Colors.black)),)
          ))));
    }
    return Row(children: result);
  }

  Widget _createButtonGrid(BuildContext context, List<SearchFilter> filters,  int column, ResponsiveGridValues res) {

    int rows = filters.length ~/ column;
    rows = rows + (filters.length % column > 0 ? 1 : 0);

    List<Widget> result = [Container(height: res.verticalGutterHeight),];
    for(var i = 0; i< rows; i++ ) {
      result.add(
        _createTextButtons(context,
            filters.sublist(i*column, (i*column+column) >= filters.length? filters.length: (i*column+column)),
            column,res)
      );
      result.add(Container(height: res.verticalGutterHeight,),);
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start,children:result);
  }

  Widget _createTextButtons(BuildContext context, List<SearchFilter> filters, int length, ResponsiveGridValues res) {
    double w = res.columnWidth *
        (res.columnSize * res.columnWidth + (res.columnSize - 1) * res.horizontalGutterWidth) /
        (length * res.columnWidth + (length - 1) * res.horizontalGutterWidth);
    double g = w * res.horizontalGutterWidth / res.columnWidth;

    List<Widget> result = [];

    for (var i = 0; i < filters.length; i++) {
      result.add(Container(
          margin: i < filters.length - 1
              ? EdgeInsets.only(right: g)
              : const EdgeInsets.only(),
          width: w,
          height:res.rowHeight,
          child: _createToggleTextButton(context, filters[i])));
    }
    return Row(children:result);
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
      BuildContext context, SearchFilter filter) {
    bool isOn = Provider.of<SearchViewModel>(context).searchFilters[filter]!;
    return Container(
      decoration: isOn? BoxDecoration(
        gradient: RadialGradient(
          radius: 1,
          colors: [Colors.orange.withAlpha(100), Theme.of(context).canvasColor],
        ),
      ) : const BoxDecoration(),
        child: TextButton(
            onPressed: () {
              //ビューモデルの値を変更する
              Provider.of<SearchViewModel>(context, listen: false).switchSearchFilter(filter);
            },
            style:isOn? TextButton.styleFrom(backgroundColor: Colors.orange.withAlpha(10)):
            TextButton.styleFrom(),
            child: Text(_getFilterText(context, filter),
            style: TextStyle(color: isOn? Colors.white.withAlpha(255) : Colors.white.withAlpha(150)),)));
  }

  String _getFilterText(BuildContext context, SearchFilter f) {
    if(f == SearchFilter.rarityCommon) {
      return AppLocalizations.of(context)!.rarityCommon;
    } else if(f == SearchFilter.rarityUncommon) {
      return AppLocalizations.of(context)!.rarityUncommon;
    } else if(f == SearchFilter.rarityRare) {
      return AppLocalizations.of(context)!.rarityRare;
    } else if(f == SearchFilter.rarityMythic) {
      return AppLocalizations.of(context)!.rarityMythic;
    } else if(f == SearchFilter.typeCreature) {
      return AppLocalizations.of(context)!.typeCreature;
    } else if(f == SearchFilter.typePlaneswalker) {
      return AppLocalizations.of(context)!.typePlaneswalker;
    } else if(f == SearchFilter.typeInstant) {
      return AppLocalizations.of(context)!.typeInstant;
    } else if(f == SearchFilter.typeSorcery) {
      return AppLocalizations.of(context)!.typeSorcery;
    } else if(f == SearchFilter.typeEnchantment) {
      return AppLocalizations.of(context)!.typeEnchantment;
    } else if(f == SearchFilter.typeArtifact) {
      return AppLocalizations.of(context)!.typeArtifact;
    } else if(f == SearchFilter.typeLand) {
      return AppLocalizations.of(context)!.typeLand;
    } else if(f == SearchFilter.manaValue0) {
      return AppLocalizations.of(context)!.manaValue0;
    } else if(f == SearchFilter.manaValue1) {
      return AppLocalizations.of(context)!.manaValue1;
    } else if(f == SearchFilter.manaValue2) {
      return AppLocalizations.of(context)!.manaValue2;
    } else if(f == SearchFilter.manaValue3) {
      return AppLocalizations.of(context)!.manaValue3;
    } else if(f == SearchFilter.manaValue4) {
      return AppLocalizations.of(context)!.manaValue4;
    } else if(f == SearchFilter.manaValue5) {
      return AppLocalizations.of(context)!.manaValue5;
    } else if(f == SearchFilter.manaValue6) {
      return AppLocalizations.of(context)!.manaValue6;
    } else if(f == SearchFilter.manaValue7AndMore) {
      return AppLocalizations.of(context)!.manaValue7AndMore;
    } else if(f == SearchFilter.setAfr) {
      return AppLocalizations.of(context)!.setAfr;
    } else if(f == SearchFilter.setKhm) {
      return AppLocalizations.of(context)!.setKhm;
    } else if(f == SearchFilter.setMid) {
      return AppLocalizations.of(context)!.setMid;
    } else if(f == SearchFilter.setNeo) {
      return AppLocalizations.of(context)!.setNeo;
    } else if(f == SearchFilter.setSnc) {
      return AppLocalizations.of(context)!.setSnc;
    } else if(f == SearchFilter.setStx) {
      return AppLocalizations.of(context)!.setStx;
    } else if(f == SearchFilter.setVow) {
      return AppLocalizations.of(context)!.setVow;
    } else if(f == SearchFilter.setZnr) {
      return AppLocalizations.of(context)!.setZnr;
    } else if(f == SearchFilter.colorWhite) {
      return "assets/images/white.png";
    } else if(f == SearchFilter.colorBlue) {
      return "assets/images/blue.png";
    } else if(f == SearchFilter.colorBlack) {
      return "assets/images/black.png";
    } else if(f == SearchFilter.colorRed) {
      return "assets/images/red.png";
    } else if(f == SearchFilter.colorGreen) {
      return "assets/images/green.png";
    } else if(f == SearchFilter.colorColorless) {
      return "assets/images/colorless.png";
    } else if(f == SearchFilter.colorMulti) {
      return "assets/images/multi.png";
    }

    return "";
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
    rowHeight = (maxHeight - (rowSize + 1)*verticalGutterHeight)/(rowSize + 1);
  }
}