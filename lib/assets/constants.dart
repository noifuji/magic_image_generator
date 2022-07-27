import 'package:magic_image_generator/assets/search_filter.dart';

const String buildType = "staging";
//const String buildType = "production";

const double rawCardImageWidth = 265.0;
const double rawCardImageHeight = 370.0;
const double cardAspectRatio = rawCardImageWidth / rawCardImageHeight;
const int searchViewRatio = 1;
const int canvasViewRatio = 1;
const String imageUrlS3 = "https://magic-image-generator-card-images.s3.ap-northeast-1.amazonaws.com/";
const String cardMasterUrlS3 = ((buildType == "production") ?
"https://mig.ezway.link/cardmaster.csv" :
"https://magic-image-generator-staging.s3.ap-northeast-1.amazonaws.com/cardmaster.csv.gz");

const String cardMasterVersionUrlS3 = ((buildType == "production") ?
"https://mig.ezway.link/cardmasterVersion.json" :
"https://magic-image-generator-staging.s3.ap-northeast-1.amazonaws.com/cardmasterVersion.json");

const rarityValueMap = {"common":0, "uncommon":1, "rare":2, "mythic":3,};
const sortItems = ["name", "cmc"];

const kofiUrl = "https://ko-fi.com/ezway";
const kofiIcon = "assets/images/icon_kofi.png";

const Map<SearchFilter, String> searchFilterColorImagePath = {
  SearchFilter.colorWhite : "assets/images/white.png",
  SearchFilter.colorBlue : "assets/images/blue.png",
  SearchFilter.colorBlack : "assets/images/black.png",
  SearchFilter.colorRed : "assets/images/red.png",
  SearchFilter.colorGreen : "assets/images/green.png",
  SearchFilter.colorColorless : "assets/images/colorless.png",
  SearchFilter.colorMulti : "assets/images/multi.png"};

final Map<SearchFilter, String> seachFilterKeywordMap = {
  SearchFilter.colorWhite: "c",
  SearchFilter.colorBlue: "c",
  SearchFilter.colorBlack: "c",
  SearchFilter.colorRed: "c",
  SearchFilter.colorGreen: "c",
  SearchFilter.colorColorless: "c",
  SearchFilter.colorMulti: "c",
  SearchFilter.rarityCommon: "r",
  SearchFilter.rarityUncommon: "r",
  SearchFilter.rarityRare: "r",
  SearchFilter.rarityMythic: "r",
  SearchFilter.typeCreature: "t",
  SearchFilter.typePlaneswalker: "t",
  SearchFilter.typeInstant: "t",
  SearchFilter.typeSorcery: "t",
  SearchFilter.typeEnchantment: "t",
  SearchFilter.typeArtifact: "t",
  SearchFilter.typeLand: "t",
  SearchFilter.manaValue0: "cmc",
  SearchFilter.manaValue1: "cmc",
  SearchFilter.manaValue2: "cmc",
  SearchFilter.manaValue3: "cmc",
  SearchFilter.manaValue4: "cmc",
  SearchFilter.manaValue5: "cmc",
  SearchFilter.manaValue6: "cmc",
  SearchFilter.manaValue7AndMore: "cmc",
  SearchFilter.setSnc: "set",
  SearchFilter.setNeo: "set",
  SearchFilter.setVow: "set",
  SearchFilter.setMid: "set",
  SearchFilter.setAfr: "set",
  SearchFilter.setStx: "set",
  SearchFilter.setKhm: "set",
  SearchFilter.setZnr: "set",
  SearchFilter.setM21: "set",
  SearchFilter.setIko: "set",
  SearchFilter.setThb: "set",
  SearchFilter.setEld: "set",
  SearchFilter.setM20: "set",
  SearchFilter.setWar: "set",
  SearchFilter.setRna: "set",
  SearchFilter.setGrn: "set",
  SearchFilter.setM19: "set",
  SearchFilter.setDom: "set",
  SearchFilter.setRix: "set",
  SearchFilter.setXln: "set",

  SearchFilter.setYMid: "set",
  SearchFilter.setYNeo: "set",
  SearchFilter.setYSnc: "set",
  SearchFilter.setHbg: "set"
};

final Map<SearchFilter, String> searchFilterValueMap = {
  SearchFilter.colorWhite: "w",
  SearchFilter.colorBlue: "u",
  SearchFilter.colorBlack: "b",
  SearchFilter.colorRed: "r",
  SearchFilter.colorGreen: "g",
  SearchFilter.colorColorless: "colorless",
  SearchFilter.colorMulti: "m",
  SearchFilter.rarityCommon: "c",
  SearchFilter.rarityUncommon: "u",
  SearchFilter.rarityRare: "r",
  SearchFilter.rarityMythic: "m",
  SearchFilter.typeCreature: "creature",
  SearchFilter.typePlaneswalker: "planeswalker",
  SearchFilter.typeInstant: "instant",
  SearchFilter.typeSorcery: "sorcery",
  SearchFilter.typeEnchantment: "enchantment",
  SearchFilter.typeArtifact: "artifact",
  SearchFilter.typeLand: "land",
  SearchFilter.manaValue0: "0",
  SearchFilter.manaValue1: "1",
  SearchFilter.manaValue2: "2",
  SearchFilter.manaValue3: "3",
  SearchFilter.manaValue4: "4",
  SearchFilter.manaValue5: "5",
  SearchFilter.manaValue6: "6",
  SearchFilter.manaValue7AndMore: "7",
  SearchFilter.setSnc: "snc",
  SearchFilter.setNeo: "neo",
  SearchFilter.setVow: "vow",
  SearchFilter.setMid: "mid",
  SearchFilter.setAfr: "afr",
  SearchFilter.setStx: "stx",
  SearchFilter.setKhm: "khm",
  SearchFilter.setZnr: "znr",
  SearchFilter.setM21: "m21",
  SearchFilter.setIko: "iko",
  SearchFilter.setThb: "thb",
  SearchFilter.setEld: "eld",
  SearchFilter.setM20: "m20",
  SearchFilter.setWar: "war",
  SearchFilter.setRna: "rna",
  SearchFilter.setGrn: "grn",
  SearchFilter.setM19: "m19",
  SearchFilter.setDom: "dom",
  SearchFilter.setRix: "rix",
  SearchFilter.setXln: "xln",

  SearchFilter.setYMid: "ymid",
  SearchFilter.setYNeo: "yneo",
  SearchFilter.setYSnc: "ysnc",
  SearchFilter.setHbg: "hbg"
};

final Map<SearchFilter, String> searchFilterValueMapJa = {
  SearchFilter.colorWhite: "w",
  SearchFilter.colorBlue: "u",
  SearchFilter.colorBlack: "b",
  SearchFilter.colorRed: "r",
  SearchFilter.colorGreen: "g",
  SearchFilter.colorColorless: "colorless",
  SearchFilter.colorMulti: "m",
  SearchFilter.rarityCommon: "c",
  SearchFilter.rarityUncommon: "u",
  SearchFilter.rarityRare: "r",
  SearchFilter.rarityMythic: "m",
  SearchFilter.typeCreature: "クリーチャー",
  SearchFilter.typePlaneswalker: "プレインズウォーカー",
  SearchFilter.typeInstant: "インスタント",
  SearchFilter.typeSorcery: "ソーサリー",
  SearchFilter.typeEnchantment: "エンチャント",
  SearchFilter.typeArtifact: "アーティファクト",
  SearchFilter.typeLand: "土地",
  SearchFilter.manaValue0: "0",
  SearchFilter.manaValue1: "1",
  SearchFilter.manaValue2: "2",
  SearchFilter.manaValue3: "3",
  SearchFilter.manaValue4: "4",
  SearchFilter.manaValue5: "5",
  SearchFilter.manaValue6: "6",
  SearchFilter.manaValue7AndMore: "7",
  SearchFilter.setSnc: "snc",
  SearchFilter.setNeo: "neo",
  SearchFilter.setVow: "vow",
  SearchFilter.setMid: "mid",
  SearchFilter.setAfr: "afr",
  SearchFilter.setStx: "stx",
  SearchFilter.setKhm: "khm",
  SearchFilter.setZnr: "znr",
  SearchFilter.setM21: "m21",
  SearchFilter.setIko: "iko",
  SearchFilter.setThb: "thb",
  SearchFilter.setEld: "eld",
  SearchFilter.setM20: "m20",
  SearchFilter.setWar: "war",
  SearchFilter.setRna: "rna",
  SearchFilter.setGrn: "grn",
  SearchFilter.setM19: "m19",
  SearchFilter.setDom: "dom",
  SearchFilter.setRix: "rix",
  SearchFilter.setXln: "xln",

  SearchFilter.setYMid: "ymid",
  SearchFilter.setYNeo: "yneo",
  SearchFilter.setYSnc: "ysnc",
  SearchFilter.setHbg: "hbg"
};

const String languageCodeJa = "ja";