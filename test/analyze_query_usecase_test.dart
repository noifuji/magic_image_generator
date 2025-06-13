// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:magic_image_generator/features/search/usecase/analyze_query_usecase.dart';
import 'package:magic_image_generator/features/search/domain/enum/relational_operator_type.dart';
import 'package:magic_image_generator/features/search/domain/entity/search_condition.dart';
import 'package:magic_image_generator/features/search/domain/enum/search_keyword_type.dart';

void main() {
  test('AnalyzeQueryUseCase returns polish notation.', () async {
    var query =
        'legal:standard hello r<=u c:r ((o:"you may" and o:next) or o:draw) (t:insta or t:sorce) or t:crea';
    var analyzer = AnalyzeQueryUseCase();
    var result = analyzer.call(query);

    expect(result.length, 19);
    expect(result[0] is SearchCondition, true);
    expect((result[0] as SearchCondition).keyword, SearchKeywordType.legal);
    expect((result[0] as SearchCondition).relationalOperatorType,
        RelationalOperatorType.contains);
    expect((result[0] as SearchCondition).value, "standard");
  });

  test('AnalyzeQueryUseCase returns ok when query has whitespace in a row.',
      () async {
    var query =
        'legal:standard      hello r<=u c:r ((o:"you may" and o:next) or o:draw) (t:insta or t:sorce) or t:crea';
    var analyzer = AnalyzeQueryUseCase();
    var result = analyzer.call(query);

    expect(result.length, 19);
    expect(result[0] is SearchCondition, true);
    expect((result[0] as SearchCondition).keyword, SearchKeywordType.legal);
    expect((result[0] as SearchCondition).relationalOperatorType,
        RelationalOperatorType.contains);
    expect((result[0] as SearchCondition).value, "standard");
  });

  test('AnalyzeQueryUseCase returns ok when query has whitespace in a row.',
      () async {
    var query = "o:Go";
    var analyzer = AnalyzeQueryUseCase();
    var result = analyzer.call(query);

    expect(result.length, 1);
    expect(result[0] is SearchCondition, true);
    expect((result[0] as SearchCondition).keyword, SearchKeywordType.oracle);
    expect((result[0] as SearchCondition).relationalOperatorType,
        RelationalOperatorType.contains);
    expect((result[0] as SearchCondition).value, "go");
  });

  test(
      'AnalyzeQueryUseCase throws Exception when query has unclosed double quotes.',
      () async {
    var query =
        'legal:standard hello r<=u c:r ((o:"you may"" and o:next) or o:draw) (t:insta or t:sorce) or t:crea';
    var analyzer = AnalyzeQueryUseCase();
    expect(() => analyzer.call(query), throwsA(const TypeMatcher<Exception>()));
  });

  test('AnalyzeQueryUseCase throws Exception when query has only operator.',
      () async {
    var query = 'and';
    var analyzer = AnalyzeQueryUseCase();
    expect(() => analyzer.call(query), throwsA(const TypeMatcher<Exception>()));
  });

  test('AnalyzeQueryUseCase throws Exception when query in unclosed.',
      () async {
    var query =
        'legal:standard hello r<=u c:r ((o:"you may" and o:next) or o:draw (t:insta or t:sorce) or t:crea';
    var analyzer = AnalyzeQueryUseCase();
    expect(() => analyzer.call(query), throwsA(const TypeMatcher<Exception>()));
  });

  test('AnalyzeQueryUseCase replace double-bytes space.', () async {
    var query = 'a　b';
    var analyzer = AnalyzeQueryUseCase();
    var result = analyzer.call(query);
    expect(result[0] is SearchCondition, true);
    expect((result[0] as SearchCondition).value, "a");
    expect((result[1] as SearchCondition).value, "b");
  });

  test('AnalyzeQueryUseCase replace double-bytes space.', () async {
    var query = 'a　b';
    var analyzer = AnalyzeQueryUseCase();
    var result = analyzer.call(query);
    expect(result[0] is SearchCondition, true);
    expect((result[0] as SearchCondition).value, "a");
    expect((result[1] as SearchCondition).value, "b");
  });
}
