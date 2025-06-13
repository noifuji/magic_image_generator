import 'package:magic_image_generator/features/search/domain/enum/search_operator_type.dart';
import 'package:magic_image_generator/features/search/domain/entity/search_query_symbol.dart';

class SearchOperator implements SearchQuerySymbol {
  static final Map<String, SearchOperatorType> searchOperatorMap = {
    "and": SearchOperatorType.and,
    "or": SearchOperatorType.or,
    "-": SearchOperatorType.not,
    "(": SearchOperatorType.openedBracket,
    ")": SearchOperatorType.closedBracket,
  };

  static final Map<SearchOperatorType, int> priorityMap = {
    SearchOperatorType.and: 3,
    SearchOperatorType.or: 3,
    SearchOperatorType.not: 4,
    SearchOperatorType.openedBracket: 1,
    SearchOperatorType.closedBracket: 1,
  };

  late SearchOperatorType searchOperatorType;
  late int priority;

  SearchOperator(List<String> raw) {
    if (!isSearchOperator(raw)) {
      throw Exception();
    }

    searchOperatorType = searchOperatorMap[raw[0]]!;
    priority = priorityMap[searchOperatorType]!;
  }

  static bool isSearchOperator(List<String> raw) {
    if (raw.length != 1) {
      return false;
    }

    return searchOperatorMap.keys.toList().contains(raw[0]);
  }

  @override
  String toString() {
    return '''{searchOperatorType:${searchOperatorType.name}}''';
  }
}
