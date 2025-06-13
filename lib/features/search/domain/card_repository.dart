import 'dart:ui';

import 'package:magic_image_generator/features/search/domain/entity/card_info_header.dart';
import 'package:magic_image_generator/features/search/domain/entity/search_query_symbol.dart';

abstract class CardRepository {
  Future<List<CardInfoHeader>> get(List<SearchQuerySymbol> query, Locale locale,
      {Function(double)? onProgress});
  Future<void> init({required Function(double value, String task) onProgress});
}
