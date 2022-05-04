import 'dart:ui';

import 'package:magic_image_generator/domain/search_query_symbol.dart';

import '../model/card_info_header.dart';

abstract class CardRepository {
  Future<List<CardInfoHeader>> get(List<SearchQuerySymbol> query, Locale locale);
  Future<void> init();
}