import 'dart:ui';

import 'package:magic_image_generator/data/card_local_data_source.dart';
import 'package:magic_image_generator/data/card_master_version.dart';
import 'package:magic_image_generator/domain/search_query_symbol.dart';
import 'package:uuid/uuid.dart';

import '../common/util.dart';
import '../domain/card_repository.dart';
import '../model/card_info_header.dart';
import 'card.dart';
import 'card_remote_data_source.dart';
import '../common/constants.dart' as constants;

class CardRepositoryImpl implements CardRepository {
  final CardLocalDataSource _localDataSource;
  final CardRemoteDataSource _remoteDataSource;

  CardRepositoryImpl(this._localDataSource, this._remoteDataSource);

  Future<void> init({required Function(double value) onProgress}) async {
    CardMasterVersion _vRemote = await _remoteDataSource.getVersion();
    onProgress(0.1);
    CardMasterVersion? _vLocal = await _localDataSource.getVersion();
    onProgress(0.2);

    if (_vLocal != null && _vLocal.version >= _vRemote.version) {
      return;
    }

    Util.printTimeStamp("CardRepositoryImpl _remoteDataSource.getAll()");
    List<Card> cards = await _remoteDataSource.getAll();
    onProgress(0.5);
    Util.printTimeStamp("CardRepositoryImpl _localDataSource.clearAll()");
    await _localDataSource.clearAll();
    onProgress(0.6);
    Util.printTimeStamp("CardRepositoryImpl _localDataSource.insertAll(cards)");
    await _localDataSource.insertAll(cards);
    onProgress(0.7);
    Util.printTimeStamp("CardRepositoryImpl _localDataSource.insertVersion(_vRemote)");
    await _localDataSource.insertVersion(_vRemote);
  }

  @override
  Future<List<CardInfoHeader>> get(List<SearchQuerySymbol> query, Locale locale) async {
    List<Card> cards = await _localDataSource.get(query, locale);
    return Future<List<CardInfoHeader>>.value(cards.map((e) {
      var front = e.convert();
      var isTransform = (front.layout == "transform" || front.layout == "modal_dfc" || front.layout == "meld");
      var cardFaces = [front];
      if (isTransform && e.backFace != null) {
        cardFaces.add(e.backFace!.convert());
      }

      CardInfoHeader cih = CardInfoHeader(
          displayId: const Uuid().v1(),
          cardFaces: cardFaces,
          isTransform: isTransform,
          isFront: true,
          imageSize: const Size(constants.rawCardImageWidth, constants.rawCardImageHeight),
          rotationAngle: 0);

      return cih;
    }).toList());
  }
}
