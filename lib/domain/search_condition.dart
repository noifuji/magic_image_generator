import 'package:magic_image_generator/domain/relational_operator_type.dart';
import 'package:magic_image_generator/domain/search_keyword_type.dart';
import 'package:magic_image_generator/domain/search_query_symbol.dart';

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
    "c" : SearchKeywordType.color,
    "t" : SearchKeywordType.type,
    "cmc" : SearchKeywordType.cmc,
    "pow" : SearchKeywordType.power,
    "tou" : SearchKeywordType.toughness,
    "o" : SearchKeywordType.oracle,
    "name" : SearchKeywordType.name};

  late SearchKeywordType keyword;
  late RelationalOperatorType relationalOperatorType;
  late dynamic value;

  SearchCondition(List<String> raw) {
    if(!isSearchConditionFormat(raw)) {
      throw Exception();
    }

    keyword = keywordMap[raw[0]]!;

    value = raw.last;

    relationalOperatorType = relationalOperatorMap[raw.sublist(1,raw.length-1).join()]!;
  }

  static bool isSearchConditionFormat(List<String> raw) {
    if(raw.length < 3) {
      return false;
    }

    if(!keywordMap.keys.toList().contains(raw[0])) {
      return false;
    }

    if(!relationalOperatorMap.keys.toList().contains(raw.sublist(1,raw.length-1).join())) {
      return false;
    }

    return true;

  }

}