import 'package:flutter_test/flutter_test.dart';
import 'package:magic_image_generator/data/card_fetch_csv_api.dart';

void main() {
  test('AnalyzeQueryUseCase returns polish notation.', () async {
    var api = CardFetchCsvApi();
    var result = await api.fetchCardCsv();

    expect(result.isNotEmpty, true);
  });
}
