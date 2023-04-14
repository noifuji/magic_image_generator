import 'package:magic_image_generator/domain/search/relational_operator_type.dart';
import 'package:magic_image_generator/domain/search/search_keyword_type.dart';
import 'package:magic_image_generator/domain/search/search_query_symbol.dart';

class SearchCondition implements SearchQuerySymbol {
  static final Map<String, RelationalOperatorType> relationalOperatorMap = {
    ":" : RelationalOperatorType.contains,
    "=":RelationalOperatorType.equals,
    "<":RelationalOperatorType.lessThan,
    ">":RelationalOperatorType.greaterThan,
    "<=":RelationalOperatorType.lessThanOrEquals,
    ">=":RelationalOperatorType.greaterThanOrEquals};

  static final Map<String, SearchKeywordType> keywordMap = {
    "legal" : SearchKeywordType.legal,
    "set" : SearchKeywordType.set,
    "r" : SearchKeywordType.rarity,
    "rarity" : SearchKeywordType.rarity,
    "c" : SearchKeywordType.color,
    "color" : SearchKeywordType.color,
    "t" : SearchKeywordType.type,
    "type" : SearchKeywordType.type,
    "cmc" : SearchKeywordType.cmc,
    "pow" : SearchKeywordType.power,
    "power" : SearchKeywordType.power,
    "tou" : SearchKeywordType.toughness,
    "toughness" : SearchKeywordType.toughness,
    "o" : SearchKeywordType.oracle,
    "oracle" : SearchKeywordType.oracle,
    "name" : SearchKeywordType.name};

  static final Map<String, String> colorMap = {
    "w" : "w",
    "u" : "u",
    "b" : "b",
    "r" : "r",
    "g" : "g",
    "white" : "w",
    "blue" : "u",
    "black" : "b",
    "red" : "r",
    "green" : "g",
    "multicolor" : "m",
    "multi" : "m",
    "colorless" : "",
  };

  static final Map<String, String> rarityMap = {
    "c":"common" ,
    "common":"common" ,
    "u":"uncommon",
    "uncommon":"uncommon",
    "r":"rare" ,
    "rare":"rare" ,
    "m":"mythic",
    "mythic":"mythic",
  };

  SearchKeywordType keyword;
  RelationalOperatorType relationalOperatorType;
  dynamic value;


  SearchCondition({
    required this.keyword,
    required this.relationalOperatorType,
    required this.value});

  @override
  String toString() {
    return '''{keyword:${keyword.name}, relationalOperatorType:${relationalOperatorType.name}, value:$value}''';
  }

}