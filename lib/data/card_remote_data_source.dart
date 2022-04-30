import 'package:flutter/foundation.dart';
import 'package:magic_image_generator/data/card_fetch_csv_api.dart';

import '../assets/constants.dart' as constants;
import 'card.dart';

class CardRemoteDataSource {
  final CardFetchCsvApi _api;

  CardRemoteDataSource(this._api);

  Future<List<Card>> getAll() async {
    var result = await _api.fetchCardCsv();

    //remove header row
    result.removeAt(0);

    var cards = result.map((e) {
      return Card()
        ..multiverseId = e[0].toString()
        ..layout = e[1].toString()
        ..name = e[2].toString()
        ..manaCost = e[3].toString()
        ..cmc = e[4]
        //..colors = e[5].toString()
        ..colorIdentity = e[5].toString()
        ..type = e[6].toString()
        //..types = e[8].toString()
        //..subtypes = e[9].toString()
        ..rarity = e[7].toString()
        ..rarityValue =
            constants.rarityValueMap[e[7].toString().toLowerCase()]!
        ..set = e[8].toString()
        ..text = e[9].toString()
        ..power = (e[10] == "" ? null : e[10].toString())
        ..powerValue =
            (e[10] == "" ? null : (isInt(e[10]) ? e[10] : 0))
        ..toughness = (e[11] == "" ? null : e[11].toString())
        ..toughnessValue =
            (e[11] == "" ? null : (isInt(e[11]) ? e[11] : 0))
        ..loyalty = e[12].toString()
        ..loyaltyValue =
            (e[12] == "" ? null : (isInt(e[12]) ? e[12] : 0))
        ..flavor = e[13].toString()
        ..artist = e[14].toString()
        ..imageUrl = constants.imageUrlS3 + e[0].toString() + ".png"
        ..nameJp = e[16].toString()
        ..textJp = e[17].toString()
        ..typeJp = e[18].toString()
        //..flavorJp = e[22].toString()
        ..imageUrlJp = constants.imageUrlS3 + e[21].toString() + ".png"
        ..multiverseIdJp = e[21].toString()
        ..legalityAlchemy = (e[22] == "legal")
        ..legalityBrawl = (e[23] == "legal")
        ..legalityCommander = (e[24] == "legal")
        ..legalityDuel = (e[25] == "legal")
        ..legalityExplorer = (e[26] == "legal")
        ..legalityFuture = (e[27] == "legal")
        ..legalityGladiator = (e[28] == "legal")
        ..legalityHistoric = (e[29] == "legal")
        ..legalityHistoricbrawl = (e[30] == "legal")
        ..legalityLegacy = (e[31] == "legal")
        ..legalityModern = (e[32] == "legal")
        ..legalityPioneer = (e[33] == "legal")
        ..legalityStandard = (e[34] == "legal")
        ..legalityVintage = (e[35] == "legal")
        ..backFaceMultiverseId = e[37].toString()
        ..isBackFace = (e[38] != "")
        ..colors = e[5].toString().length;
    }).toList();

    return Future<List<Card>>.value(cards);
  }

  bool isInt(dynamic s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s.toString()) != null;
  }
}
