import 'dart:ui';

import 'package:magic_image_generator/data/card_local_data_source.dart';
import 'package:magic_image_generator/domain/search_query_symbol.dart';

import 'package:magic_image_generator/model/card_info.dart';

import '../assets/util.dart';
import '../domain/card_repository.dart';
import 'card.dart';
import 'card_remote_data_source.dart';

class CardRepositoryImpl implements CardRepository {
  final CardLocalDataSource _localDataSource;
  final CardRemoteDataSource _remoteDataSource;


  CardRepositoryImpl(this._localDataSource, this._remoteDataSource);

  Future<void> init() async {
    Util.printTimeStamp("CardRepositoryImpl _remoteDataSource.getAll()");
    List<Card> cards = await _remoteDataSource.getAll();
    Util.printTimeStamp("CardRepositoryImpl _localDataSource.countAll()");
    var localRecordCount = await _localDataSource.countAll();
    if(localRecordCount < cards.length) {
      Util.printTimeStamp("CardRepositoryImpl _localDataSource.insertAll(cards)");
      await _localDataSource.insertAll(cards);
    }

  }

  @override
  Future<List<CardInfo>> get(List<SearchQuerySymbol> query, Locale locale) async {
    List<Card> cards = await _localDataSource.get(query, locale);
    return Future<List<CardInfo>>.value(cards.map((e) {
      CardInfo ci = e.convert();
      if(ci.isTransform) {
        ci.backFace = e.backFace!.convert();
      }
      return ci;
    }).toList());
  }

}