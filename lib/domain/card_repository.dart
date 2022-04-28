import 'dart:ui';

import 'package:magic_image_generator/domain/search_query_symbol.dart';

import '../model/card_info.dart';

abstract class CardRepository {
  Future<List<CardInfo>> get(List<SearchQuerySymbol> query, Locale locale);
  Future<void> init();
}