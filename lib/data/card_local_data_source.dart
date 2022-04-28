import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:magic_image_generator/domain/relational_operator_type.dart';
import 'package:magic_image_generator/domain/search_condition.dart';
import 'package:magic_image_generator/domain/search_keyword_type.dart';
import 'package:magic_image_generator/domain/search_operator.dart';
import 'package:magic_image_generator/domain/search_operator_type.dart';

import '../domain/search_query_symbol.dart';
import 'card.dart';

import '../assets/constants.dart' as constants;

class CardLocalDataSource {
  static final conditionMap = {
    RelationalOperatorType.contains :ConditionType.contains,
    RelationalOperatorType.equals :ConditionType.eq,
    RelationalOperatorType.greaterThan :ConditionType.gt,
    RelationalOperatorType.lessThan :ConditionType.lt,
  };

  static final propertyMapEn = {
    SearchKeywordType.name : "name",
    SearchKeywordType.color : "colorIdentity",
    SearchKeywordType.cmc : "cmc",
    SearchKeywordType.type : "type",
    SearchKeywordType.rarity : "rarityValue",
    SearchKeywordType.power : "powerValue",
    SearchKeywordType.toughness : "toughnessValue",
    SearchKeywordType.loyalty : "loyaltyValue",
    SearchKeywordType.oracle : "text",
    SearchKeywordType.set : "set",
    SearchKeywordType.legal : "legal",
  };

  static final propertyMapJp = {
    SearchKeywordType.name : "nameJp",
    SearchKeywordType.color : "colorIdentity",
    SearchKeywordType.cmc : "cmc",
    SearchKeywordType.type : "typeJp",
    SearchKeywordType.rarity : "rarityValue",
    SearchKeywordType.power : "powerValue",
    SearchKeywordType.toughness : "toughnessValue",
    SearchKeywordType.loyalty : "loyaltyValue",
    SearchKeywordType.oracle : "textJp",
    SearchKeywordType.set : "set",
    SearchKeywordType.legal : "legal",
  };

  final intValueKeywords = [SearchKeywordType.rarity,SearchKeywordType.cmc,
    SearchKeywordType.power,SearchKeywordType.toughness,
    SearchKeywordType.loyalty];

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
    var propertyMap = {};
    if(locale.languageCode == "ja") {
      propertyMap = propertyMapJp;
    } else if (locale.languageCode == "en") {
      propertyMap = propertyMapEn;
    } else {
      throw Exception();
    }

    List<FilterOperation> stack = [];

    //queryを変換していく。
    while(query.isNotEmpty) {
      var t = query.first;
      query.removeAt(0);

      if(t is SearchCondition) {
        //いくつかのパターンではcontainsはequals扱いとする。
        if(intValueKeywords.contains(t.keyword)) {
          if (t.relationalOperatorType == RelationalOperatorType.contains) {
            t.relationalOperatorType = RelationalOperatorType.equals;
          }
        }

        if(t.keyword == SearchKeywordType.rarity) {
          t = rarityToValue(t);
        }

        if(intValueKeywords.contains(t.keyword)) {
          t.value = int.parse(t.value.toString());
          stack.add(createIsarCondition<int>(t, propertyMap));
        } else if(t.value is String) {
          stack.add(createIsarCondition<String>(t, propertyMap));
        }


      } else if (t is SearchOperator && t.searchOperatorType == SearchOperatorType.and) {
        var right = stack.last;
        stack.removeLast();
        var left = stack.last;
        stack.removeLast();

        stack.add(FilterGroup.and([left, right]));

      } else if (t is SearchOperator && t.searchOperatorType == SearchOperatorType.or) {
        var right = stack.last;
        stack.removeLast();
        var left = stack.last;
        stack.removeLast();

        stack.add(FilterGroup.or([left, right]));

      } else if (t is SearchOperator && t.searchOperatorType == SearchOperatorType.not) {
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


    var results = await _isar.cards.buildQuery(filter: FilterGroup.and(stack)).findAll();

    List<Card> cards = [];

    for(var r in results) {
      cards.add(r);
    }

    //第二面を抽出
    //第一面を抽出　b
    //第一面のうち、
    //抽出された第二面の第一面を検索 a
    //bにaを追加する。ただし、かぶりはなし。TODO:修正
    List<Card> backFaces = cards.where((element) => element.isBackFace).toList();
    List<Card> frontFaces = cards.where((element) => !element.isBackFace).toList();
    List<Card> onlyBackFaces = backFaces.where((element) => !frontFaces.fold<bool>(false, (p, e) => p && (e.backFaceMultiverseId == element.multiverseId))).toList();

    if(onlyBackFaces.isNotEmpty) {
      var results = await _isar.cards.filter()
          .repeat(
          onlyBackFaces.map((e) => e.multiverseId).toList(),
              (q, String id) => q.backFaceMultiverseIdEqualTo(id).or()
      ).buildInternal().findAll();

      List<String> frontIds = frontFaces.map((e) => e.multiverseId).toList();
      for(var r in results) {
        if(!frontIds.contains(r.multiverseId)) {
          frontFaces.add(r);
        }
      }
    }

    //第二面のある札には、第二面の情報をつけておく。
    frontFaces = await Future.wait(frontFaces.map((e) async {
      if(e.backFaceMultiverseId!=null && e.backFaceMultiverseId!="") {
        e.backFace = await _isar.cards.filter().multiverseIdEqualTo(e.backFaceMultiverseId!).findFirst();
      }
      return e;
    }).toList());


    return Future<List<Card>>.value(frontFaces);
  }

  Future<void> insertAll(List<Card> cards) async {

    await _isar.writeTxn((isar) async {
      for(var card in cards) {
        await isar.cards.put(card);
      }
    });
  }

  FilterOperation createIsarCondition<T>(SearchCondition condition, Map propertyMap) {
    if(condition.relationalOperatorType == RelationalOperatorType.greaterThanOrEquals) {
      return FilterGroup.and(
          [FilterCondition<T>(type: ConditionType.gt,
              property: propertyMap[condition.keyword]!, value: condition.value, include:true, caseSensitive: false),
            FilterGroup.not(FilterCondition<T>(type: ConditionType.isNull, property: propertyMap[condition.keyword]!)),]);

    } else if(condition.relationalOperatorType == RelationalOperatorType.lessThanOrEquals) {
      return FilterGroup.and(
      [FilterCondition<T>(type: ConditionType.lt,
          property: propertyMap[condition.keyword]!, value: condition.value, include:true, caseSensitive: false),
        FilterGroup.not(FilterCondition<T>(type: ConditionType.isNull, property: propertyMap[condition.keyword]!)),]);


    } else {
      return FilterGroup.and(
          [FilterCondition<T>(type: conditionMap[condition.relationalOperatorType]!,
              property: propertyMap[condition.keyword]!, value: condition.value, caseSensitive: false),
            FilterGroup.not(FilterCondition<T>(type: ConditionType.isNull, property: propertyMap[condition.keyword]!)),]);

    }

  }

  SearchCondition rarityToValue(SearchCondition c) {
    if(constants.rarityLetterMap.keys.toList().contains(c.value.toLowerCase())) {
      c.value = constants.rarityLetterMap[c.value.toLowerCase()]!;
    }

    if(!constants.rarityValueMap.keys.toList().contains(c.value.toLowerCase())) {
      throw Exception();
    }

    c.value = constants.rarityValueMap[c.value.toLowerCase()]!;

    return c;
  }
}