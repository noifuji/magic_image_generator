import '../../domain/entity/card_info.dart';

class Card {
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
  late String nameJpYomi;
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
  late int colors;

  CardInfo convert() {
    CardInfo ci = CardInfo(
        multiverseId: multiverseId,
        name: name,
        nameJpYomi: nameJpYomi,
        imageUrl: imageUrl,
        imageUrlJp: imageUrlJp,
        layout: layout,
        cmc: cmc,
        isFront: !isBackFace);

    return ci;
  }

  dynamic getValue(String property) {
    if (property == "multiverseId") {
      return multiverseId;
    } else if (property == "layout") {
      return layout;
    } else if (property == "name") {
      return name;
    } else if (property == "manaCost") {
      return manaCost;
    } else if (property == "cmc") {
      return cmc;
    } else if (property == "colorIdentity") {
      return colorIdentity;
    } else if (property == "type") {
      return type;
    } else if (property == "rarity") {
      return rarity;
    } else if (property == "rarityValue") {
      return rarityValue;
    } else if (property == "set") {
      return set;
    } else if (property == "text") {
      return text;
    } else if (property == "power") {
      return power;
    } else if (property == "powerValue") {
      return powerValue;
    } else if (property == "toughness") {
      return toughness;
    } else if (property == "toughnessValue") {
      return toughnessValue;
    } else if (property == "loyalty") {
      return loyalty;
    } else if (property == "loyaltyValue") {
      return loyaltyValue;
    } else if (property == "flavor") {
      return flavor;
    } else if (property == "artist") {
      return artist;
    } else if (property == "imageUrl") {
      return imageUrl;
    } else if (property == "nameJp") {
      return nameJp;
    } else if (property == "nameJpYomi") {
      return nameJpYomi;
    } else if (property == "textJp") {
      return textJp;
    } else if (property == "typeJp") {
      return typeJp;
    } else if (property == "flavorJp") {
      return flavorJp;
    } else if (property == "imageUrlJp") {
      return imageUrlJp;
    } else if (property == "multiverseIdJp") {
      return multiverseIdJp;
    } else if (property == "legalityAlchemy") {
      return legalityAlchemy;
    } else if (property == "legalityBrawl") {
      return legalityBrawl;
    } else if (property == "legalityCommander") {
      return legalityCommander;
    } else if (property == "legalityDuel") {
      return legalityDuel;
    } else if (property == "legalityExplorer") {
      return legalityExplorer;
    } else if (property == "legalityFuture") {
      return legalityFuture;
    } else if (property == "legalityGladiator") {
      return legalityGladiator;
    } else if (property == "legalityHistoric") {
      return legalityHistoric;
    } else if (property == "legalityHistoricbrawl") {
      return legalityHistoricbrawl;
    } else if (property == "legalityLegacy") {
      return legalityLegacy;
    } else if (property == "legalityModern") {
      return legalityModern;
    } else if (property == "legalityPioneer") {
      return legalityPioneer;
    } else if (property == "legalityStandard") {
      return legalityStandard;
    } else if (property == "legalityVintage") {
      return legalityVintage;
    } else if (property == "backFaceMultiverseId") {
      return backFaceMultiverseId;
    } else if (property == "isBackFace") {
      return isBackFace;
    } else if (property == "backFace") {
      return backFace;
    } else if (property == "colors") {
      return colors;
    }
  }
}
