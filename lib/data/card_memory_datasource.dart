import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:magic_image_generator/data/card.dart';
import 'package:magic_image_generator/data/card_master_version.dart';
import 'package:magic_image_generator/domain/search/search_query_symbol.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/util.dart';
import '../domain/search/color_type.dart';
import '../domain/search/rarity_type.dart';
import '../domain/search/relational_operator_type.dart';
import '../domain/search/search_condition.dart';
import '../domain/search/search_keyword_type.dart';
import '../domain/search/search_operator.dart';
import '../domain/search/search_operator_type.dart';
import 'data_source.dart';

class CardMemoryDataSource implements DataSource{
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

  List<Card> data = [];

  @override
  Future<void> clearAll() async {
    data = [];
  }

  @override
  Future<int> countAll() async {
    return 0;
  }

  @override
  Future<List<Card>> get(List<SearchQuerySymbol> query, Locale locale, {Function(double p1)? onProgress}) async {
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

    //クエリの変換が完了
    if(onProgress != null) {
      onProgress(0.1);
    }

    final start = DateTime.now();
    final fn = _buildQuery(FilterGroup.and(stack));
    List<Card> results =[];
    for(final card in data) {
      if(fn(card)) {
        results.add(card);
      }
    }
    debugPrint("process time:${DateTime.now().difference(start).inMilliseconds}");
    debugPrint("result length:${results.length}");

    //クエリの実行が完了
    if(onProgress != null) {
      onProgress(0.5);
    }

    List<Card> cards = [];

    for (var r in results) {
      cards.add(r);
    }

    final postProcessSatrt = DateTime.now();

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
    Util.printTimeStamp("start 第一面のみ、片面または、両面がヒットしたカードの第一面");
    final frontFaces = cards.where((element) => !element.isBackFace).toList();
    if(onProgress != null) {
      onProgress(0.6);
    }


    //第二面のみがヒットしたカード
    Util.printTimeStamp("start 第二面のみがヒットしたカード");
    final backFacesWithoutFrontSide = cards
        .where((element) => element.isBackFace)
        .where((element) => !frontFaces
        .map((e) => e.backFaceMultiverseId)
        .where((e) => e != null)
        .contains(element.multiverseId))
        .toList();
    if(onProgress != null) {
      onProgress(0.7);
    }

    if (backFacesWithoutFrontSide.isNotEmpty) {
      //第二面がヒットしたカードの第一面を取得
      Util.printTimeStamp("start 第二面がヒットしたカードの第一面を取得");
      final backFaceIds = backFacesWithoutFrontSide.map((e) => e.multiverseId)
          .toList();
      final frontFacesOfBackFacesWithoutFrontSide = <Card>[];
      for(int i =0; i<data.length; i++) {
        if(backFaceIds.contains(data[i].backFaceMultiverseId)) {
          frontFacesOfBackFacesWithoutFrontSide.add(data[i]);
        }
      }

      //第一面と第二面を紐付けて、リザルトに追加
      Util.printTimeStamp("start 第一面と第二面を紐付けて、リザルトに追加");
      result.addAll(frontFacesOfBackFacesWithoutFrontSide.map((e) {
        if (e.backFaceMultiverseId != null && e.backFaceMultiverseId != "") {
          e.backFace = backFacesWithoutFrontSide
              .firstWhere((ele) => ele.multiverseId == e.backFaceMultiverseId);
        }
        return e;
      }).toList());
      if(onProgress != null) {
        onProgress(0.9);
      }
    }

    //第二面のある札には、第二面の情報をつけておく。
    Util.printTimeStamp("start 第二面のある札には、第二面の情報をつけておく。");
    List<String> frontFacesWithBackSide = frontFaces
        .where((e) =>
    e.backFaceMultiverseId != null && e.backFaceMultiverseId != "")
        .map((e) => e.backFaceMultiverseId!)
        .toList();

    List<Card> backFaces = [];
    if (frontFacesWithBackSide.isNotEmpty) {
      for(int i =0; i<data.length; i++) {
        if(frontFacesWithBackSide.contains(data[i].multiverseId)) {
          backFaces.add(data[i]);
        }
      }
    }
    if(onProgress != null) {
      onProgress(1.0);
    }

    result.addAll(frontFaces.map((e) {
      if (e.backFaceMultiverseId != null && e.backFaceMultiverseId != "") {
        e.backFace = backFaces.firstWhere(
                (element) => element.multiverseId == e.backFaceMultiverseId);
      }
      return e;
    }).toList());

    debugPrint("post process time:${DateTime.now().difference(postProcessSatrt).inMilliseconds}");
    Util.printTimeStamp("end CardLocalDataSource get");
    return Future<List<Card>>.value(result);
  }

  @override
  Future<List<Card>> getAll({bool cache=true}) {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<CardMasterVersion?> getVersion() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final int? version = pref.getInt('master_version');

    return Future.value(CardMasterVersion()..version = version ?? 0);
  }

  @override
  Future<void> insertAll(List<Card> cards) async {
    for(int i = 0; i < cards.length; i++) {
      cards[i].id = i;
    }
    data = cards;
  }

  @override
  Future<void> insertVersion(CardMasterVersion v) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('master_version', v.version);
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

  bool Function(Card) _buildQuery(FilterOperation filter,
      {FilterGroupType filterGroupType = FilterGroupType.and}) {
    if(filter is FilterGroup) {
      List<bool Function(Card)> results = [];
      for(final filterInFilterGroup in filter.filters) {
        results.add(_buildQuery(filterInFilterGroup,
            filterGroupType: filter.type
        ));
      }
      if(filter.type == FilterGroupType.and) {
        return (Card card) {
          bool isTargetCard = true;
          for(final r in results) {
            isTargetCard = isTargetCard && r(card);
          }
          return isTargetCard;
        };
      } else if(filter.type == FilterGroupType.or) {
        return (Card card) {
          bool isTargetCard = false;
          for(final r in results) {
            isTargetCard = isTargetCard || r(card);
          }
          return isTargetCard;
        };
      } else if(filter.type == FilterGroupType.not) {
        return (Card card) {
          bool isTargetCard = true;
          for(final r in results) {
            isTargetCard = !r(card);
          }
          return isTargetCard;
        };
      } else {
        throw Exception("Unexpected FilterGroupType:${filter.type}");
      }
    } else if (filter is FilterCondition) {
      if(filter.type == ConditionType.eq) {
        return (Card card) {
          if(card.getValue(filter.property) == null) {
            return false;
          }
          if(filter.value1 is String && !filter.caseSensitive) {
            return (card.getValue(filter.property) as String).toLowerCase()
                == (filter.value1 as String).toLowerCase();
          } else {
            return card.getValue(filter.property) == filter.value1;
          }
        };
      } else if(filter.type == ConditionType.contains) {
        return (Card card) {
          if(card.getValue(filter.property) == null) {
            return false;
          }
          if(filter.value1 is String && !filter.caseSensitive) {
            return (card.getValue(filter.property) as String).toLowerCase()
                .contains((filter.value1 as String).toLowerCase());
          } else {
            return card.getValue(filter.property).contains(filter.value1);
          }
        };
      } else if(filter.type == ConditionType.gt) {
        return (Card card) {
          if(card.getValue(filter.property) == null) {
            return false;
          }
          return filter.include1 ?
          card.getValue(filter.property) >= (filter.value1)
          :card.getValue(filter.property) > (filter.value1);
        };
      } else if(filter.type == ConditionType.lt) {
        return (Card card) {
          if(card.getValue(filter.property) == null) {
            return false;
          }
          return filter.include1 ?
          card.getValue(filter.property) <= (filter.value1)
              :card.getValue(filter.property) < (filter.value1);
        };
      } else if(filter.type == ConditionType.isNull) {
        return (Card card) {
          return card.getValue(filter.property) == null;
        };
      }
    } else {
      throw Exception("Unexpected Type");
    }

    throw Exception("never reached");
  }

}

abstract class FilterOperation {
  const FilterOperation();
}

/// The type of dynamic filter conditions.
///
/// For lists, at least one of the values in the list has to match. For
/// `isNull`, the entire list hast to be null.
enum ConditionType {
  eq,
  gt,
  lt,
  contains,
  isNull,
}

/// Create a filter condition dynamically.
class FilterCondition<T> extends FilterOperation {
  /// Type of the filter condition.
  final ConditionType type;

  /// Property used for comparisons.
  final String property;

  /// Value used for comparisons. Lower bound for `ConditionType.between`.
  final T? value1;

  /// Should `value1` be part of the results.
  final bool include1;

  /// Are string operations case sensitive.
  final bool caseSensitive;

  const FilterCondition({
    required this.type,
    required this.property,
    T? value,
    bool include = false,
    this.caseSensitive = true,
  })  : value1 = value,
        include1 = include;
}

/// Thw type of filter groups.
enum FilterGroupType {
  and,
  or,
  not,
}

class FilterGroup extends FilterOperation {
  /// The filter(s) to be grouped.
  final List<FilterOperation> filters;

  /// Type of this group.
  final FilterGroupType type;

  /// Create a logical AND filter group.
  const FilterGroup.and(this.filters) : type = FilterGroupType.and;

  /// Create a logical OR filter group.
  const FilterGroup.or(this.filters) : type = FilterGroupType.or;

  /// Negate a filter.
  FilterGroup.not(FilterOperation filter)
      : filters = [filter],
        type = FilterGroupType.not;
}