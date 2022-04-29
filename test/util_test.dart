// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:magic_image_generator/domain/analyze_query_usecase.dart';
import 'package:magic_image_generator/domain/relational_operator_type.dart';
import 'package:magic_image_generator/domain/search_condition.dart';
import 'package:magic_image_generator/domain/search_keyword_type.dart';


void main() {
  test('12345 -> 13245', () async {
    var query = 'legal:standard hello r<=u c:r ((o:"you may" and o:next) or o:draw) (t:insta or t:sorce) or t:crea';
    var analyzer = AnalyzeQueryUseCase();
    var result = analyzer.call(query);

    expect(result.length, 19);
    expect(result[0] is SearchCondition, true);
    expect((result[0] as SearchCondition).keyword, SearchKeywordType.legal);
    expect((result[0] as SearchCondition).relationalOperatorType, RelationalOperatorType.contains);
    expect((result[0] as SearchCondition).value, "standard");
  });
}
