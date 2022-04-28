import 'dart:ui';

import 'package:isar/isar.dart';

import '../model/card_info.dart';
part 'card.g.dart';

@Collection()
class Card {
  @Id()
  int? id;

  late String multiverseId;
  late String layout;
  late String name;
  late String manaCost;
  late int cmc;
  String? colorIdentity;
  late String type;
  late String rarity;
  late int rarityValue;
  late String set;
  late String text;
  String? power;
  int? powerValue;
  String? toughness;
  int? toughnessValue;
  String? loyalty;
  int? loyaltyValue;
  String? flavor;
  late String artist;
  late String imageUrl;
  late String nameJp;
  late String textJp;
  late String typeJp;
  String? flavorJp;
  late String imageUrlJp;
  late String multiverseIdJp;
  late bool legalityAlchemy;
  late bool legalityBrawl;
  late bool legalityCommander;
  late bool legalityDuel;
  late bool legalityExplorer;
  late bool legalityFuture;
  late bool legalityGladiator;
  late bool legalityHistoric;
  late bool legalityHistoricbrawl;
  late bool legalityLegacy;
  late bool legalityModern;
  late bool legalityPioneer;
  late bool legalityStandard;
  late bool legalityVintage;
  String? backFaceMultiverseId;
  late bool isBackFace;
  Card? backFace;

  CardInfo convert() {
      return CardInfo(
          multiverseId: multiverseId,
          name: name,
          imageUrl: imageUrl,
          imageUrlJp: imageUrlJp,
          isTransform: layout == "transform",
      );
  }
}