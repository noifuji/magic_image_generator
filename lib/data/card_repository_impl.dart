import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:magic_image_generator/data/card_master_version.dart';
import 'package:magic_image_generator/domain/entity/card_info_header.dart';
import 'package:magic_image_generator/domain/entity/search_query_symbol.dart';
import 'package:uuid/uuid.dart';

import '../common/util.dart';
import '../domain/card_repository.dart';
import 'card.dart';
import 'card_remote_data_source.dart';
import '../common/constants.dart' as constants;
import 'data_source.dart';

class CardRepositoryImpl implements CardRepository {
  final DataSource _localDataSource;
  final CardRemoteDataSource _remoteDataSource;

  CardRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<void> init({required Function(double value, String task) onProgress}) async {
    onProgress(0, "Downloading Database Version");
    CardMasterVersion vRemote = await _remoteDataSource.getVersion();
    onProgress(0.1, "Checking Database Version");
    CardMasterVersion? vLocal = await _localDataSource.getVersion();

    bool useCache = false;
    if (vLocal != null && vLocal.version >= vRemote.version) {
      useCache = true;
    }

    Util.printTimeStamp("CardRepositoryImpl _remoteDataSource.getAll()");
    onProgress(0.2, "Downloading Database");
    List<Card> cards = await _remoteDataSource.getAll(cache: useCache);
    Util.printTimeStamp("CardRepositoryImpl _localDataSource.clearAll()");
    onProgress(0.5, "Refreshing Database");
    await _localDataSource.clearAll();
    Util.printTimeStamp("CardRepositoryImpl _localDataSource.insertAll(cards)");
    onProgress(0.6, "Refreshing Database");
    await _localDataSource.insertAll(cards);
    Util.printTimeStamp(
        "CardRepositoryImpl _localDataSource.insertVersion(_vRemote)");
    onProgress(0.7, "Refreshing Database");
    await _localDataSource.insertVersion(vRemote);
  }

  @override
  Future<List<CardInfoHeader>> get(List<SearchQuerySymbol> query, Locale locale,
      {Function(double)? onProgress}) async {
    List<Card> cards =
        await _localDataSource.get(query, locale, onProgress: onProgress);
    return Future<List<CardInfoHeader>>.value(cards.map((e) {
      var front = e.convert();
      var isTransform = (front.layout == "transform" ||
          front.layout == "modal_dfc" ||
          front.layout == "meld");
      var cardFaces = [front];
      if (isTransform && e.backFace != null) {
        cardFaces.add(e.backFace!.convert());
      }

      CardInfoHeader cih = CardInfoHeader(
          displayId: const Uuid().v1(),
          cardFaces: cardFaces,
          isTransform: isTransform,
          isFront: true,
          imageSize: const Size(
              constants.rawCardImageWidth, constants.rawCardImageHeight),
          rotationAngle: 0);

      return cih;
    }).toList());
  }
}
