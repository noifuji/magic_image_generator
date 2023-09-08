import 'dart:ui';

import 'package:magic_image_generator/domain/usecase/search_query_symbol.dart';

import '../model/card_info_header.dart';

abstract class CardRepository {
  Future<List<CardInfoHeader>> get(List<SearchQuerySymbol> query, Locale locale,
      {Function(double)? onProgress});
  Future<void> init({required Function(double value) onProgress});
}
