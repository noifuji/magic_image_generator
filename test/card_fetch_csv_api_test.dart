import 'package:flutter_test/flutter_test.dart';
import 'package:magic_image_generator/data/card_fetch_csv_api.dart';
import 'package:magic_image_generator/domain/analyze_query_usecase.dart';
import 'package:magic_image_generator/domain/relational_operator_type.dart';
import 'package:magic_image_generator/domain/search_condition.dart';
import 'package:magic_image_generator/domain/search_keyword_type.dart';


void main() {
  test('AnalyzeQueryUseCase returns polish notation.', () async {
    var api = CardFetchCsvApi();
    var result = await api.fetchCardCsv();

    expect(result.length, 311);
  });
}