import 'dart:ui';

import '../../domain/entity/search_query_symbol.dart';
import 'card.dart';
import 'card_master_version.dart';

abstract class DataSource {
  Future<int> countAll();
  Future<List<Card>> getAll({bool cache = true});
  Future<List<Card>> get(List<SearchQuerySymbol> query, Locale locale,
      {Function(double)? onProgress});
  Future<void> insertAll(List<Card> cards);
  Future<void> clearAll();

  Future<CardMasterVersion?> getVersion();
  Future<void> insertVersion(CardMasterVersion v);
}
