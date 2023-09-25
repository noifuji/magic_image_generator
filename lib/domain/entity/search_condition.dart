import 'package:magic_image_generator/domain/enum/relational_operator_type.dart';
import 'package:magic_image_generator/domain/enum/search_keyword_type.dart';
import 'package:magic_image_generator/domain/entity/search_query_symbol.dart';

class SearchCondition implements SearchQuerySymbol {

  SearchKeywordType keyword;
  RelationalOperatorType relationalOperatorType;
  dynamic value;

  SearchCondition(
      {required this.keyword,
      required this.relationalOperatorType,
      required this.value});

  @override
  String toString() {
    return '''{keyword:${keyword.name}, relationalOperatorType:${relationalOperatorType.name}, value:$value}''';
  }
}
