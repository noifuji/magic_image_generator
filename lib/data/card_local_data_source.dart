import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:magic_image_generator/data/card_master_version.dart';
import 'package:magic_image_generator/domain/rarity_type.dart';
import 'package:magic_image_generator/domain/relational_operator_type.dart';
import 'package:magic_image_generator/domain/search_condition.dart';
import 'package:magic_image_generator/domain/search_keyword_type.dart';
import 'package:magic_image_generator/domain/search_operator.dart';
import 'package:magic_image_generator/domain/search_operator_type.dart';

import '../assets/util.dart';
import '../domain/color_type.dart';
import '../domain/search_query_symbol.dart';
import 'card.dart';

/*
逆ポーランド記法形式のConditionとOperatorを解読しつつ、Isarの形式に変換する。
ConditionによってIsarでのクエリが異なる。
各キーワード毎に変換メソッドを作成する。
 */
class CardLocalDataSource {
  static final conditionMap = {
    RelationalOperatorType.contains: ConditionType.contains,
    RelationalOperatorType.equals: ConditionType.eq,
    RelationalOperatorType.greaterThan: ConditionType.gt,
    RelationalOperatorType.lessThan: ConditionType.lt,
  };

  static final propertyMapEn = {
    SearchKeywordType.name: "name",
    SearchKeywordType.color: "colorIdentity",
    SearchKeywordType.cmc: "cmc",
    SearchKeywordType.type: "type",
    SearchKeywordType.rarity: "rarityValue",
    SearchKeywordType.power: "powerValue",
    SearchKeywordType.toughness: "toughnessValue",
    SearchKeywordType.loyalty: "loyaltyValue",
    SearchKeywordType.oracle: "text",
    SearchKeywordType.set: "set",
    SearchKeywordType.legal: "legal",
  };

  static final propertyMapJp = {
    SearchKeywordType.name: "nameJp",
    SearchKeywordType.color: "colorIdentity",
    SearchKeywordType.cmc: "cmc",
    SearchKeywordType.type: "typeJp",
    SearchKeywordType.rarity: "rarityValue",
    SearchKeywordType.power: "powerValue",
    SearchKeywordType.toughness: "toughnessValue",
    SearchKeywordType.loyalty: "loyaltyValue",
    SearchKeywordType.oracle: "textJp",
    SearchKeywordType.set: "set",
    SearchKeywordType.legal: "legal",
  };

  static final colorTypeMap = {
    ColorType.white: "w",
    ColorType.blue: "u",
    ColorType.black: "b",
    ColorType.red: "r",
    ColorType.green: "g",
    ColorType.wu: "wu",
    ColorType.ub: "ub",
    ColorType.br: "br",
    ColorType.rg: "rg",
    ColorType.gw: "gw",
    ColorType.wb: "wb",
    ColorType.bg: "bg",
    ColorType.gu: "gu",
    ColorType.ur: "ur",
    ColorType.wr: "wr",
    ColorType.wub: "wub",
    ColorType.ubr: "ubr",
    ColorType.brg: "brg",
    ColorType.rgw: "rgw",
    ColorType.gwu: "gwu",
    ColorType.wur: "wur",
    ColorType.ubg: "ubg",
    ColorType.brw: "brw",
    ColorType.rgu: "rgu",
    ColorType.wbg: "wbg",
    ColorType.noWhite: "ubrg",
    ColorType.noBlue: "wbrg",
    ColorType.noBlack: "wurg",
    ColorType.noRed: "wubg",
    ColorType.noGreen: "wubr",
    ColorType.fiveColors: "wubrg",
  };

  final rarityTypeMap = {
    RarityType.common: 0,
    RarityType.uncommon: 1,
    RarityType.rare: 2,
    RarityType.mythic: 3
  };

  final intValueKeywords = [
    SearchKeywordType.cmc,
    SearchKeywordType.power,
    SearchKeywordType.toughness,
    SearchKeywordType.loyalty
  ];

  final Isar _isar;

  CardLocalDataSource(this._isar); //TODO:Isarはラップする

  Future<int> countAll() {
    return _isar.cards.where().count();
  }

  /*
  1つずつ取り出す。
  conditionならスタックへ
  演算子and or ならスタックから2つ取り出してisar形式を生成してスタックへ
  演算子notならスタックから1つとりだしてisar形式を生成してスタックへ

  queryがなくなったら、スタックに残ってるconditionを取り出してisar形式を生成

   */
  Future<List<Card>> get(List<SearchQuerySymbol> query, Locale locale) async {
    Util.printTimeStamp("start CardLocalDataSource get");
    var propertyMap = {};
    if (locale.languageCode == "ja") {
      propertyMap = propertyMapJp;
    } else if (locale.languageCode == "en") {
      propertyMap = propertyMapEn;
    } else {
      throw Exception();
    }

    for (var s in query) {
      print(s);
    }

    List<FilterOperation> stack = [];

    //queryを変換していく。
    while (query.isNotEmpty) {
      var t = query.first;
      query.removeAt(0);

      if (t is SearchCondition) {
        //いくつかのパターンではcontainsはequals扱いとする。
        if (intValueKeywords.contains(t.keyword)) {
          if (t.relationalOperatorType == RelationalOperatorType.contains) {
            t.relationalOperatorType = RelationalOperatorType.equals;
          }
        }

        if (t.keyword == SearchKeywordType.rarity) {
          stack.add(_createRarityIsarFilter(t, propertyMap));
        } else if (t.keyword == SearchKeywordType.color) {
          stack.add(_createColorIsarFilter(t, propertyMap));
        } else if (intValueKeywords.contains(t.keyword)) {
          t.value = int.parse(t.value.toString());
          stack.add(_createIsarFilter<int>(t, propertyMap));
        } else if (t.value is String) {
          stack.add(_createIsarFilter<String>(t, propertyMap));
        }
      } else if (t is SearchOperator &&
          t.searchOperatorType == SearchOperatorType.and) {
        var right = stack.last;
        stack.removeLast();
        var left = stack.last;
        stack.removeLast();

        stack.add(FilterGroup.and([left, right]));
      } else if (t is SearchOperator &&
          t.searchOperatorType == SearchOperatorType.or) {
        var right = stack.last;
        stack.removeLast();
        var left = stack.last;
        stack.removeLast();

        stack.add(FilterGroup.or([left, right]));
      } else if (t is SearchOperator &&
          t.searchOperatorType == SearchOperatorType.not) {
        var condition = stack.last;
        stack.removeLast();

        stack.add(FilterGroup.not(condition));
      } else {
        if (kDebugMode) {
          print(t);
        }
        throw Exception();
      }
    }

    Util.printTimeStamp(
        "start _isar.cards.buildQuery(filter: FilterGroup.and(stack)).findAll()");
    var results =
        await _isar.cards.buildQuery(filter: FilterGroup.and(stack)).findAll();

    List<Card> cards = [];

    for (var r in results) {
      cards.add(r);
    }

    //第二面を抽出
    //第一面を抽出　b
    //第一面のうち、
    //抽出された第二面の第一面を検索 a
    //bにaを追加する。ただし、かぶりはなし。TODO:修正
    /*
     *DBからヒットしたデータを分類
     * ・第一面のみがヒット -> そのままリザルトへ追加
     * ・第二面のみがヒット -> 第一面を検索してリザルトへ追加
     * ・第一面と第二面両方がヒット -> 第一面のみ抽出してリザルトへ追加
     * ・片面カードがヒット ->　リザルトへ追加
     *
     * ・リザルト ->　第二面が存在するものは、検索して第二面の情報を追加
     *
     */
    final List<Card> result = [];

    //第一面のみ、片面または、両面がヒットしたカードの第一面
    final frontFaces = cards.where((element) => !element.isBackFace).toList();

    //第二面のみがヒットしたカード
    final backFacesWithoutFrontSide = cards
        .where((element) => element.isBackFace)
        .where((element) => !frontFaces.map((e) => e.backFaceMultiverseId).where((e) => e!=null).contains(element.multiverseId))
        .toList();

    if (backFacesWithoutFrontSide.isNotEmpty) {
      //第二面がヒットしたカードの第一面を取得
      final frontFacesOfBackFacesWithoutFrontSide = await _isar.cards
          .filter()
          .repeat(backFacesWithoutFrontSide.map((e) => e.multiverseId).toList(),
              (q, String id) => q.backFaceMultiverseIdEqualTo(id).or())
          .buildInternal()
          .findAll();

      //第一面と第二面を紐付けて、リザルトに追加
      result.addAll(frontFacesOfBackFacesWithoutFrontSide.map((e) {
        if(e.backFaceMultiverseId != null && e.backFaceMultiverseId != "") {
          e.backFace = backFacesWithoutFrontSide.firstWhere((ele) => ele.multiverseId == e.backFaceMultiverseId);
        }
        return e;
      }).toList());
    }

    //第二面のある札には、第二面の情報をつけておく。
    List<String> frontFacesWithBackSide = frontFaces
        .where((e) =>
            e.backFaceMultiverseId != null && e.backFaceMultiverseId != "")
        .map((e) => e.backFaceMultiverseId!)
        .toList();

    List<Card> backFaces = await _isar.cards
        .filter()
        .repeat(frontFacesWithBackSide,
            (q, String id) => q.multiverseIdEqualTo(id).or())
        .buildInternal()
        .findAll();

     result.addAll(frontFaces.map((e) {
      if (e.backFaceMultiverseId != null && e.backFaceMultiverseId != "") {
        e.backFace = backFaces.firstWhere(
            (element) => element.multiverseId == e.backFaceMultiverseId);
      }
      return e;
    }).toList());

    Util.printTimeStamp("end CardLocalDataSource get");
    return Future<List<Card>>.value(result);
  }

  Future<void> insertAll(List<Card> cards) async {
    await _isar.writeTxn((isar) async {
      for (var card in cards) {
        await isar.cards.put(card);
      }
    });
  }

  Future<void> clearAll() async {
    await _isar.writeTxn((isar) async {
      final cardList = await isar.cards.where().idProperty().findAll();

      if (cardList.isEmpty) {
        return;
      }

      await isar.cards
          .deleteAll(cardList.where((e) => e != null).map((e) => e!).toList());
    });
  }

  Future<CardMasterVersion?> getVersion() async {
    int? version =
        await _isar.cardMasterVersions.where().versionProperty().max();

    return Future.value(
        version == null ? null : (CardMasterVersion()..version = version));
  }

  Future<void> insertVersion(CardMasterVersion v) async {
    await _isar.writeTxn((isar) async {
      await isar.cardMasterVersions.put(v);
    });
  }

  FilterOperation _createIsarFilter<T>(
      SearchCondition condition, Map propertyMap) {
    if (condition.relationalOperatorType ==
        RelationalOperatorType.greaterThanOrEquals) {
      return FilterGroup.and([
        FilterCondition<T>(
            type: ConditionType.gt,
            property: propertyMap[condition.keyword]!,
            value: condition.value,
            include: true,
            caseSensitive: false),
        FilterGroup.not(FilterCondition<T>(
            type: ConditionType.isNull,
            property: propertyMap[condition.keyword]!)),
      ]);
    } else if (condition.relationalOperatorType ==
        RelationalOperatorType.lessThanOrEquals) {
      return FilterGroup.and([
        FilterCondition<T>(
            type: ConditionType.lt,
            property: propertyMap[condition.keyword]!,
            value: condition.value,
            include: true,
            caseSensitive: false),
        FilterGroup.not(FilterCondition<T>(
            type: ConditionType.isNull,
            property: propertyMap[condition.keyword]!)),
      ]);
    } else {
      return FilterGroup.and([
        FilterCondition<T>(
            type: conditionMap[condition.relationalOperatorType]!,
            property: propertyMap[condition.keyword]!,
            value: condition.value,
            caseSensitive: false),
        FilterGroup.not(FilterCondition<T>(
            type: ConditionType.isNull,
            property: propertyMap[condition.keyword]!)),
      ]);
    }
  }

  FilterOperation _createRarityIsarFilter(
      SearchCondition condition, Map propertyMap) {
    condition.value = rarityTypeMap[condition.value];

    if (condition.relationalOperatorType == RelationalOperatorType.contains) {
      condition.relationalOperatorType = RelationalOperatorType.equals;
    }

    return _createIsarFilter(condition, propertyMap);
  }

  /*
  relation:  contains, =のみ使用可能
  value: multi, colorlessは特殊

  = colorless -> colorsが0
  : colorless -> colorsが0
  = m    -> colors 1より大きい
  : m   -> colorsが1より大きい
  : 単色　-> Xを含む
  : 複数色 -> Xを含むかつYを含む
  = 単色 ->Xを含むかつcolorsが1
  = 複数色　-> Xを含むかつYを含むかつ色数がcolorsが一致
   */
  FilterOperation _createColorIsarFilter(
      SearchCondition condition, Map propertyMap) {
    if (![RelationalOperatorType.equals, RelationalOperatorType.contains]
        .contains(condition.relationalOperatorType)) {
      throw Exception();
    }

    if (condition.value == ColorType.colorless) {
      //colorlessの場合
      return FilterCondition<int>(
          type: ConditionType.eq,
          property: "colors",
          value: 0,
          caseSensitive: false);
    } else if (condition.value == ColorType.multiColor) {
      //multicolorの場合
      return FilterCondition<int>(
          type: ConditionType.gt,
          property: "colors",
          value: 1,
          caseSensitive: false);
    } else if (condition.relationalOperatorType ==
        RelationalOperatorType.contains) {
      //containの場合
      List<FilterCondition<String>> filters = [];
      String colorString = colorTypeMap[condition.value]!;
      for (var i = 0; i < colorString.length; i++) {
        filters.add(FilterCondition<String>(
            type: ConditionType.contains,
            property: "colorIdentity",
            value: colorString[i],
            caseSensitive: false));
      }

      return FilterGroup.and(filters);
    } else if (condition.relationalOperatorType ==
        RelationalOperatorType.equals) {
      //equalsの場合
      List<FilterCondition<dynamic>> filters = [];
      String colorString = colorTypeMap[condition.value]!;
      for (var i = 0; i < colorString.length; i++) {
        filters.add(FilterCondition<String>(
            type: ConditionType.contains,
            property: "colorIdentity",
            value: colorString[i],
            caseSensitive: false));
      }

      filters.add(FilterCondition<int>(
          type: ConditionType.eq,
          property: "colors",
          value: colorString.length,
          caseSensitive: false));

      return FilterGroup.and(filters);
    }

    throw Exception();
  }
}
