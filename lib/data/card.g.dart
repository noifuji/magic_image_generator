// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetCardCollection on Isar {
  IsarCollection<Card> get cards => getCollection();
}

const CardSchema = CollectionSchema(
  name: 'Card',
  schema:
      '{"name":"Card","idName":"id","properties":[{"name":"artist","type":"String"},{"name":"backFaceMultiverseId","type":"String"},{"name":"cmc","type":"Long"},{"name":"colorIdentity","type":"String"},{"name":"flavor","type":"String"},{"name":"flavorJp","type":"String"},{"name":"imageUrl","type":"String"},{"name":"imageUrlJp","type":"String"},{"name":"isBackFace","type":"Bool"},{"name":"layout","type":"String"},{"name":"legalityAlchemy","type":"Bool"},{"name":"legalityBrawl","type":"Bool"},{"name":"legalityCommander","type":"Bool"},{"name":"legalityDuel","type":"Bool"},{"name":"legalityExplorer","type":"Bool"},{"name":"legalityFuture","type":"Bool"},{"name":"legalityGladiator","type":"Bool"},{"name":"legalityHistoric","type":"Bool"},{"name":"legalityHistoricbrawl","type":"Bool"},{"name":"legalityLegacy","type":"Bool"},{"name":"legalityModern","type":"Bool"},{"name":"legalityPioneer","type":"Bool"},{"name":"legalityStandard","type":"Bool"},{"name":"legalityVintage","type":"Bool"},{"name":"loyalty","type":"String"},{"name":"loyaltyValue","type":"Long"},{"name":"manaCost","type":"String"},{"name":"multiverseId","type":"String"},{"name":"multiverseIdJp","type":"String"},{"name":"name","type":"String"},{"name":"nameJp","type":"String"},{"name":"power","type":"String"},{"name":"powerValue","type":"Long"},{"name":"rarity","type":"String"},{"name":"rarityValue","type":"Long"},{"name":"set","type":"String"},{"name":"text","type":"String"},{"name":"textJp","type":"String"},{"name":"toughness","type":"String"},{"name":"toughnessValue","type":"Long"},{"name":"type","type":"String"},{"name":"typeJp","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'artist': 0,
    'backFaceMultiverseId': 1,
    'cmc': 2,
    'colorIdentity': 3,
    'flavor': 4,
    'flavorJp': 5,
    'imageUrl': 6,
    'imageUrlJp': 7,
    'isBackFace': 8,
    'layout': 9,
    'legalityAlchemy': 10,
    'legalityBrawl': 11,
    'legalityCommander': 12,
    'legalityDuel': 13,
    'legalityExplorer': 14,
    'legalityFuture': 15,
    'legalityGladiator': 16,
    'legalityHistoric': 17,
    'legalityHistoricbrawl': 18,
    'legalityLegacy': 19,
    'legalityModern': 20,
    'legalityPioneer': 21,
    'legalityStandard': 22,
    'legalityVintage': 23,
    'loyalty': 24,
    'loyaltyValue': 25,
    'manaCost': 26,
    'multiverseId': 27,
    'multiverseIdJp': 28,
    'name': 29,
    'nameJp': 30,
    'power': 31,
    'powerValue': 32,
    'rarity': 33,
    'rarityValue': 34,
    'set': 35,
    'text': 36,
    'textJp': 37,
    'toughness': 38,
    'toughnessValue': 39,
    'type': 40,
    'typeJp': 41
  },
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _cardGetId,
  setId: _cardSetId,
  getLinks: _cardGetLinks,
  attachLinks: _cardAttachLinks,
  serializeNative: _cardSerializeNative,
  deserializeNative: _cardDeserializeNative,
  deserializePropNative: _cardDeserializePropNative,
  serializeWeb: _cardSerializeWeb,
  deserializeWeb: _cardDeserializeWeb,
  deserializePropWeb: _cardDeserializePropWeb,
  version: 3,
);

int? _cardGetId(Card object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _cardSetId(Card object, int id) {
  object.id = id;
}

List<IsarLinkBase> _cardGetLinks(Card object) {
  return [];
}

void _cardSerializeNative(IsarCollection<Card> collection, IsarRawObject rawObj,
    Card object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.artist;
  final _artist = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_artist.length) as int;
  final value1 = object.backFaceMultiverseId;
  IsarUint8List? _backFaceMultiverseId;
  if (value1 != null) {
    _backFaceMultiverseId = IsarBinaryWriter.utf8Encoder.convert(value1);
  }
  dynamicSize += (_backFaceMultiverseId?.length ?? 0) as int;
  final value2 = object.cmc;
  final _cmc = value2;
  final value3 = object.colorIdentity;
  IsarUint8List? _colorIdentity;
  if (value3 != null) {
    _colorIdentity = IsarBinaryWriter.utf8Encoder.convert(value3);
  }
  dynamicSize += (_colorIdentity?.length ?? 0) as int;
  final value4 = object.flavor;
  IsarUint8List? _flavor;
  if (value4 != null) {
    _flavor = IsarBinaryWriter.utf8Encoder.convert(value4);
  }
  dynamicSize += (_flavor?.length ?? 0) as int;
  final value5 = object.flavorJp;
  IsarUint8List? _flavorJp;
  if (value5 != null) {
    _flavorJp = IsarBinaryWriter.utf8Encoder.convert(value5);
  }
  dynamicSize += (_flavorJp?.length ?? 0) as int;
  final value6 = object.imageUrl;
  final _imageUrl = IsarBinaryWriter.utf8Encoder.convert(value6);
  dynamicSize += (_imageUrl.length) as int;
  final value7 = object.imageUrlJp;
  final _imageUrlJp = IsarBinaryWriter.utf8Encoder.convert(value7);
  dynamicSize += (_imageUrlJp.length) as int;
  final value8 = object.isBackFace;
  final _isBackFace = value8;
  final value9 = object.layout;
  final _layout = IsarBinaryWriter.utf8Encoder.convert(value9);
  dynamicSize += (_layout.length) as int;
  final value10 = object.legalityAlchemy;
  final _legalityAlchemy = value10;
  final value11 = object.legalityBrawl;
  final _legalityBrawl = value11;
  final value12 = object.legalityCommander;
  final _legalityCommander = value12;
  final value13 = object.legalityDuel;
  final _legalityDuel = value13;
  final value14 = object.legalityExplorer;
  final _legalityExplorer = value14;
  final value15 = object.legalityFuture;
  final _legalityFuture = value15;
  final value16 = object.legalityGladiator;
  final _legalityGladiator = value16;
  final value17 = object.legalityHistoric;
  final _legalityHistoric = value17;
  final value18 = object.legalityHistoricbrawl;
  final _legalityHistoricbrawl = value18;
  final value19 = object.legalityLegacy;
  final _legalityLegacy = value19;
  final value20 = object.legalityModern;
  final _legalityModern = value20;
  final value21 = object.legalityPioneer;
  final _legalityPioneer = value21;
  final value22 = object.legalityStandard;
  final _legalityStandard = value22;
  final value23 = object.legalityVintage;
  final _legalityVintage = value23;
  final value24 = object.loyalty;
  IsarUint8List? _loyalty;
  if (value24 != null) {
    _loyalty = IsarBinaryWriter.utf8Encoder.convert(value24);
  }
  dynamicSize += (_loyalty?.length ?? 0) as int;
  final value25 = object.loyaltyValue;
  final _loyaltyValue = value25;
  final value26 = object.manaCost;
  final _manaCost = IsarBinaryWriter.utf8Encoder.convert(value26);
  dynamicSize += (_manaCost.length) as int;
  final value27 = object.multiverseId;
  final _multiverseId = IsarBinaryWriter.utf8Encoder.convert(value27);
  dynamicSize += (_multiverseId.length) as int;
  final value28 = object.multiverseIdJp;
  final _multiverseIdJp = IsarBinaryWriter.utf8Encoder.convert(value28);
  dynamicSize += (_multiverseIdJp.length) as int;
  final value29 = object.name;
  final _name = IsarBinaryWriter.utf8Encoder.convert(value29);
  dynamicSize += (_name.length) as int;
  final value30 = object.nameJp;
  final _nameJp = IsarBinaryWriter.utf8Encoder.convert(value30);
  dynamicSize += (_nameJp.length) as int;
  final value31 = object.power;
  IsarUint8List? _power;
  if (value31 != null) {
    _power = IsarBinaryWriter.utf8Encoder.convert(value31);
  }
  dynamicSize += (_power?.length ?? 0) as int;
  final value32 = object.powerValue;
  final _powerValue = value32;
  final value33 = object.rarity;
  final _rarity = IsarBinaryWriter.utf8Encoder.convert(value33);
  dynamicSize += (_rarity.length) as int;
  final value34 = object.rarityValue;
  final _rarityValue = value34;
  final value35 = object.set;
  final _set = IsarBinaryWriter.utf8Encoder.convert(value35);
  dynamicSize += (_set.length) as int;
  final value36 = object.text;
  final _text = IsarBinaryWriter.utf8Encoder.convert(value36);
  dynamicSize += (_text.length) as int;
  final value37 = object.textJp;
  final _textJp = IsarBinaryWriter.utf8Encoder.convert(value37);
  dynamicSize += (_textJp.length) as int;
  final value38 = object.toughness;
  IsarUint8List? _toughness;
  if (value38 != null) {
    _toughness = IsarBinaryWriter.utf8Encoder.convert(value38);
  }
  dynamicSize += (_toughness?.length ?? 0) as int;
  final value39 = object.toughnessValue;
  final _toughnessValue = value39;
  final value40 = object.type;
  final _type = IsarBinaryWriter.utf8Encoder.convert(value40);
  dynamicSize += (_type.length) as int;
  final value41 = object.typeJp;
  final _typeJp = IsarBinaryWriter.utf8Encoder.convert(value41);
  dynamicSize += (_typeJp.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _artist);
  writer.writeBytes(offsets[1], _backFaceMultiverseId);
  writer.writeLong(offsets[2], _cmc);
  writer.writeBytes(offsets[3], _colorIdentity);
  writer.writeBytes(offsets[4], _flavor);
  writer.writeBytes(offsets[5], _flavorJp);
  writer.writeBytes(offsets[6], _imageUrl);
  writer.writeBytes(offsets[7], _imageUrlJp);
  writer.writeBool(offsets[8], _isBackFace);
  writer.writeBytes(offsets[9], _layout);
  writer.writeBool(offsets[10], _legalityAlchemy);
  writer.writeBool(offsets[11], _legalityBrawl);
  writer.writeBool(offsets[12], _legalityCommander);
  writer.writeBool(offsets[13], _legalityDuel);
  writer.writeBool(offsets[14], _legalityExplorer);
  writer.writeBool(offsets[15], _legalityFuture);
  writer.writeBool(offsets[16], _legalityGladiator);
  writer.writeBool(offsets[17], _legalityHistoric);
  writer.writeBool(offsets[18], _legalityHistoricbrawl);
  writer.writeBool(offsets[19], _legalityLegacy);
  writer.writeBool(offsets[20], _legalityModern);
  writer.writeBool(offsets[21], _legalityPioneer);
  writer.writeBool(offsets[22], _legalityStandard);
  writer.writeBool(offsets[23], _legalityVintage);
  writer.writeBytes(offsets[24], _loyalty);
  writer.writeLong(offsets[25], _loyaltyValue);
  writer.writeBytes(offsets[26], _manaCost);
  writer.writeBytes(offsets[27], _multiverseId);
  writer.writeBytes(offsets[28], _multiverseIdJp);
  writer.writeBytes(offsets[29], _name);
  writer.writeBytes(offsets[30], _nameJp);
  writer.writeBytes(offsets[31], _power);
  writer.writeLong(offsets[32], _powerValue);
  writer.writeBytes(offsets[33], _rarity);
  writer.writeLong(offsets[34], _rarityValue);
  writer.writeBytes(offsets[35], _set);
  writer.writeBytes(offsets[36], _text);
  writer.writeBytes(offsets[37], _textJp);
  writer.writeBytes(offsets[38], _toughness);
  writer.writeLong(offsets[39], _toughnessValue);
  writer.writeBytes(offsets[40], _type);
  writer.writeBytes(offsets[41], _typeJp);
}

Card _cardDeserializeNative(IsarCollection<Card> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = Card();
  object.artist = reader.readString(offsets[0]);
  object.backFaceMultiverseId = reader.readStringOrNull(offsets[1]);
  object.cmc = reader.readLong(offsets[2]);
  object.colorIdentity = reader.readStringOrNull(offsets[3]);
  object.flavor = reader.readStringOrNull(offsets[4]);
  object.flavorJp = reader.readStringOrNull(offsets[5]);
  object.id = id;
  object.imageUrl = reader.readString(offsets[6]);
  object.imageUrlJp = reader.readString(offsets[7]);
  object.isBackFace = reader.readBool(offsets[8]);
  object.layout = reader.readString(offsets[9]);
  object.legalityAlchemy = reader.readBool(offsets[10]);
  object.legalityBrawl = reader.readBool(offsets[11]);
  object.legalityCommander = reader.readBool(offsets[12]);
  object.legalityDuel = reader.readBool(offsets[13]);
  object.legalityExplorer = reader.readBool(offsets[14]);
  object.legalityFuture = reader.readBool(offsets[15]);
  object.legalityGladiator = reader.readBool(offsets[16]);
  object.legalityHistoric = reader.readBool(offsets[17]);
  object.legalityHistoricbrawl = reader.readBool(offsets[18]);
  object.legalityLegacy = reader.readBool(offsets[19]);
  object.legalityModern = reader.readBool(offsets[20]);
  object.legalityPioneer = reader.readBool(offsets[21]);
  object.legalityStandard = reader.readBool(offsets[22]);
  object.legalityVintage = reader.readBool(offsets[23]);
  object.loyalty = reader.readStringOrNull(offsets[24]);
  object.loyaltyValue = reader.readLongOrNull(offsets[25]);
  object.manaCost = reader.readString(offsets[26]);
  object.multiverseId = reader.readString(offsets[27]);
  object.multiverseIdJp = reader.readString(offsets[28]);
  object.name = reader.readString(offsets[29]);
  object.nameJp = reader.readString(offsets[30]);
  object.power = reader.readStringOrNull(offsets[31]);
  object.powerValue = reader.readLongOrNull(offsets[32]);
  object.rarity = reader.readString(offsets[33]);
  object.rarityValue = reader.readLong(offsets[34]);
  object.set = reader.readString(offsets[35]);
  object.text = reader.readString(offsets[36]);
  object.textJp = reader.readString(offsets[37]);
  object.toughness = reader.readStringOrNull(offsets[38]);
  object.toughnessValue = reader.readLongOrNull(offsets[39]);
  object.type = reader.readString(offsets[40]);
  object.typeJp = reader.readString(offsets[41]);
  return object;
}

P _cardDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readBool(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    case 15:
      return (reader.readBool(offset)) as P;
    case 16:
      return (reader.readBool(offset)) as P;
    case 17:
      return (reader.readBool(offset)) as P;
    case 18:
      return (reader.readBool(offset)) as P;
    case 19:
      return (reader.readBool(offset)) as P;
    case 20:
      return (reader.readBool(offset)) as P;
    case 21:
      return (reader.readBool(offset)) as P;
    case 22:
      return (reader.readBool(offset)) as P;
    case 23:
      return (reader.readBool(offset)) as P;
    case 24:
      return (reader.readStringOrNull(offset)) as P;
    case 25:
      return (reader.readLongOrNull(offset)) as P;
    case 26:
      return (reader.readString(offset)) as P;
    case 27:
      return (reader.readString(offset)) as P;
    case 28:
      return (reader.readString(offset)) as P;
    case 29:
      return (reader.readString(offset)) as P;
    case 30:
      return (reader.readString(offset)) as P;
    case 31:
      return (reader.readStringOrNull(offset)) as P;
    case 32:
      return (reader.readLongOrNull(offset)) as P;
    case 33:
      return (reader.readString(offset)) as P;
    case 34:
      return (reader.readLong(offset)) as P;
    case 35:
      return (reader.readString(offset)) as P;
    case 36:
      return (reader.readString(offset)) as P;
    case 37:
      return (reader.readString(offset)) as P;
    case 38:
      return (reader.readStringOrNull(offset)) as P;
    case 39:
      return (reader.readLongOrNull(offset)) as P;
    case 40:
      return (reader.readString(offset)) as P;
    case 41:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _cardSerializeWeb(IsarCollection<Card> collection, Card object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'artist', object.artist);
  IsarNative.jsObjectSet(
      jsObj, 'backFaceMultiverseId', object.backFaceMultiverseId);
  IsarNative.jsObjectSet(jsObj, 'cmc', object.cmc);
  IsarNative.jsObjectSet(jsObj, 'colorIdentity', object.colorIdentity);
  IsarNative.jsObjectSet(jsObj, 'flavor', object.flavor);
  IsarNative.jsObjectSet(jsObj, 'flavorJp', object.flavorJp);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'imageUrl', object.imageUrl);
  IsarNative.jsObjectSet(jsObj, 'imageUrlJp', object.imageUrlJp);
  IsarNative.jsObjectSet(jsObj, 'isBackFace', object.isBackFace);
  IsarNative.jsObjectSet(jsObj, 'layout', object.layout);
  IsarNative.jsObjectSet(jsObj, 'legalityAlchemy', object.legalityAlchemy);
  IsarNative.jsObjectSet(jsObj, 'legalityBrawl', object.legalityBrawl);
  IsarNative.jsObjectSet(jsObj, 'legalityCommander', object.legalityCommander);
  IsarNative.jsObjectSet(jsObj, 'legalityDuel', object.legalityDuel);
  IsarNative.jsObjectSet(jsObj, 'legalityExplorer', object.legalityExplorer);
  IsarNative.jsObjectSet(jsObj, 'legalityFuture', object.legalityFuture);
  IsarNative.jsObjectSet(jsObj, 'legalityGladiator', object.legalityGladiator);
  IsarNative.jsObjectSet(jsObj, 'legalityHistoric', object.legalityHistoric);
  IsarNative.jsObjectSet(
      jsObj, 'legalityHistoricbrawl', object.legalityHistoricbrawl);
  IsarNative.jsObjectSet(jsObj, 'legalityLegacy', object.legalityLegacy);
  IsarNative.jsObjectSet(jsObj, 'legalityModern', object.legalityModern);
  IsarNative.jsObjectSet(jsObj, 'legalityPioneer', object.legalityPioneer);
  IsarNative.jsObjectSet(jsObj, 'legalityStandard', object.legalityStandard);
  IsarNative.jsObjectSet(jsObj, 'legalityVintage', object.legalityVintage);
  IsarNative.jsObjectSet(jsObj, 'loyalty', object.loyalty);
  IsarNative.jsObjectSet(jsObj, 'loyaltyValue', object.loyaltyValue);
  IsarNative.jsObjectSet(jsObj, 'manaCost', object.manaCost);
  IsarNative.jsObjectSet(jsObj, 'multiverseId', object.multiverseId);
  IsarNative.jsObjectSet(jsObj, 'multiverseIdJp', object.multiverseIdJp);
  IsarNative.jsObjectSet(jsObj, 'name', object.name);
  IsarNative.jsObjectSet(jsObj, 'nameJp', object.nameJp);
  IsarNative.jsObjectSet(jsObj, 'power', object.power);
  IsarNative.jsObjectSet(jsObj, 'powerValue', object.powerValue);
  IsarNative.jsObjectSet(jsObj, 'rarity', object.rarity);
  IsarNative.jsObjectSet(jsObj, 'rarityValue', object.rarityValue);
  IsarNative.jsObjectSet(jsObj, 'set', object.set);
  IsarNative.jsObjectSet(jsObj, 'text', object.text);
  IsarNative.jsObjectSet(jsObj, 'textJp', object.textJp);
  IsarNative.jsObjectSet(jsObj, 'toughness', object.toughness);
  IsarNative.jsObjectSet(jsObj, 'toughnessValue', object.toughnessValue);
  IsarNative.jsObjectSet(jsObj, 'type', object.type);
  IsarNative.jsObjectSet(jsObj, 'typeJp', object.typeJp);
  return jsObj;
}

Card _cardDeserializeWeb(IsarCollection<Card> collection, dynamic jsObj) {
  final object = Card();
  object.artist = IsarNative.jsObjectGet(jsObj, 'artist') ?? '';
  object.backFaceMultiverseId =
      IsarNative.jsObjectGet(jsObj, 'backFaceMultiverseId');
  object.cmc = IsarNative.jsObjectGet(jsObj, 'cmc') ?? double.negativeInfinity;
  object.colorIdentity = IsarNative.jsObjectGet(jsObj, 'colorIdentity');
  object.flavor = IsarNative.jsObjectGet(jsObj, 'flavor');
  object.flavorJp = IsarNative.jsObjectGet(jsObj, 'flavorJp');
  object.id = IsarNative.jsObjectGet(jsObj, 'id');
  object.imageUrl = IsarNative.jsObjectGet(jsObj, 'imageUrl') ?? '';
  object.imageUrlJp = IsarNative.jsObjectGet(jsObj, 'imageUrlJp') ?? '';
  object.isBackFace = IsarNative.jsObjectGet(jsObj, 'isBackFace') ?? false;
  object.layout = IsarNative.jsObjectGet(jsObj, 'layout') ?? '';
  object.legalityAlchemy =
      IsarNative.jsObjectGet(jsObj, 'legalityAlchemy') ?? false;
  object.legalityBrawl =
      IsarNative.jsObjectGet(jsObj, 'legalityBrawl') ?? false;
  object.legalityCommander =
      IsarNative.jsObjectGet(jsObj, 'legalityCommander') ?? false;
  object.legalityDuel = IsarNative.jsObjectGet(jsObj, 'legalityDuel') ?? false;
  object.legalityExplorer =
      IsarNative.jsObjectGet(jsObj, 'legalityExplorer') ?? false;
  object.legalityFuture =
      IsarNative.jsObjectGet(jsObj, 'legalityFuture') ?? false;
  object.legalityGladiator =
      IsarNative.jsObjectGet(jsObj, 'legalityGladiator') ?? false;
  object.legalityHistoric =
      IsarNative.jsObjectGet(jsObj, 'legalityHistoric') ?? false;
  object.legalityHistoricbrawl =
      IsarNative.jsObjectGet(jsObj, 'legalityHistoricbrawl') ?? false;
  object.legalityLegacy =
      IsarNative.jsObjectGet(jsObj, 'legalityLegacy') ?? false;
  object.legalityModern =
      IsarNative.jsObjectGet(jsObj, 'legalityModern') ?? false;
  object.legalityPioneer =
      IsarNative.jsObjectGet(jsObj, 'legalityPioneer') ?? false;
  object.legalityStandard =
      IsarNative.jsObjectGet(jsObj, 'legalityStandard') ?? false;
  object.legalityVintage =
      IsarNative.jsObjectGet(jsObj, 'legalityVintage') ?? false;
  object.loyalty = IsarNative.jsObjectGet(jsObj, 'loyalty');
  object.loyaltyValue = IsarNative.jsObjectGet(jsObj, 'loyaltyValue');
  object.manaCost = IsarNative.jsObjectGet(jsObj, 'manaCost') ?? '';
  object.multiverseId = IsarNative.jsObjectGet(jsObj, 'multiverseId') ?? '';
  object.multiverseIdJp = IsarNative.jsObjectGet(jsObj, 'multiverseIdJp') ?? '';
  object.name = IsarNative.jsObjectGet(jsObj, 'name') ?? '';
  object.nameJp = IsarNative.jsObjectGet(jsObj, 'nameJp') ?? '';
  object.power = IsarNative.jsObjectGet(jsObj, 'power');
  object.powerValue = IsarNative.jsObjectGet(jsObj, 'powerValue');
  object.rarity = IsarNative.jsObjectGet(jsObj, 'rarity') ?? '';
  object.rarityValue =
      IsarNative.jsObjectGet(jsObj, 'rarityValue') ?? double.negativeInfinity;
  object.set = IsarNative.jsObjectGet(jsObj, 'set') ?? '';
  object.text = IsarNative.jsObjectGet(jsObj, 'text') ?? '';
  object.textJp = IsarNative.jsObjectGet(jsObj, 'textJp') ?? '';
  object.toughness = IsarNative.jsObjectGet(jsObj, 'toughness');
  object.toughnessValue = IsarNative.jsObjectGet(jsObj, 'toughnessValue');
  object.type = IsarNative.jsObjectGet(jsObj, 'type') ?? '';
  object.typeJp = IsarNative.jsObjectGet(jsObj, 'typeJp') ?? '';
  return object;
}

P _cardDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'artist':
      return (IsarNative.jsObjectGet(jsObj, 'artist') ?? '') as P;
    case 'backFaceMultiverseId':
      return (IsarNative.jsObjectGet(jsObj, 'backFaceMultiverseId')) as P;
    case 'cmc':
      return (IsarNative.jsObjectGet(jsObj, 'cmc') ?? double.negativeInfinity)
          as P;
    case 'colorIdentity':
      return (IsarNative.jsObjectGet(jsObj, 'colorIdentity')) as P;
    case 'flavor':
      return (IsarNative.jsObjectGet(jsObj, 'flavor')) as P;
    case 'flavorJp':
      return (IsarNative.jsObjectGet(jsObj, 'flavorJp')) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id')) as P;
    case 'imageUrl':
      return (IsarNative.jsObjectGet(jsObj, 'imageUrl') ?? '') as P;
    case 'imageUrlJp':
      return (IsarNative.jsObjectGet(jsObj, 'imageUrlJp') ?? '') as P;
    case 'isBackFace':
      return (IsarNative.jsObjectGet(jsObj, 'isBackFace') ?? false) as P;
    case 'layout':
      return (IsarNative.jsObjectGet(jsObj, 'layout') ?? '') as P;
    case 'legalityAlchemy':
      return (IsarNative.jsObjectGet(jsObj, 'legalityAlchemy') ?? false) as P;
    case 'legalityBrawl':
      return (IsarNative.jsObjectGet(jsObj, 'legalityBrawl') ?? false) as P;
    case 'legalityCommander':
      return (IsarNative.jsObjectGet(jsObj, 'legalityCommander') ?? false) as P;
    case 'legalityDuel':
      return (IsarNative.jsObjectGet(jsObj, 'legalityDuel') ?? false) as P;
    case 'legalityExplorer':
      return (IsarNative.jsObjectGet(jsObj, 'legalityExplorer') ?? false) as P;
    case 'legalityFuture':
      return (IsarNative.jsObjectGet(jsObj, 'legalityFuture') ?? false) as P;
    case 'legalityGladiator':
      return (IsarNative.jsObjectGet(jsObj, 'legalityGladiator') ?? false) as P;
    case 'legalityHistoric':
      return (IsarNative.jsObjectGet(jsObj, 'legalityHistoric') ?? false) as P;
    case 'legalityHistoricbrawl':
      return (IsarNative.jsObjectGet(jsObj, 'legalityHistoricbrawl') ?? false)
          as P;
    case 'legalityLegacy':
      return (IsarNative.jsObjectGet(jsObj, 'legalityLegacy') ?? false) as P;
    case 'legalityModern':
      return (IsarNative.jsObjectGet(jsObj, 'legalityModern') ?? false) as P;
    case 'legalityPioneer':
      return (IsarNative.jsObjectGet(jsObj, 'legalityPioneer') ?? false) as P;
    case 'legalityStandard':
      return (IsarNative.jsObjectGet(jsObj, 'legalityStandard') ?? false) as P;
    case 'legalityVintage':
      return (IsarNative.jsObjectGet(jsObj, 'legalityVintage') ?? false) as P;
    case 'loyalty':
      return (IsarNative.jsObjectGet(jsObj, 'loyalty')) as P;
    case 'loyaltyValue':
      return (IsarNative.jsObjectGet(jsObj, 'loyaltyValue')) as P;
    case 'manaCost':
      return (IsarNative.jsObjectGet(jsObj, 'manaCost') ?? '') as P;
    case 'multiverseId':
      return (IsarNative.jsObjectGet(jsObj, 'multiverseId') ?? '') as P;
    case 'multiverseIdJp':
      return (IsarNative.jsObjectGet(jsObj, 'multiverseIdJp') ?? '') as P;
    case 'name':
      return (IsarNative.jsObjectGet(jsObj, 'name') ?? '') as P;
    case 'nameJp':
      return (IsarNative.jsObjectGet(jsObj, 'nameJp') ?? '') as P;
    case 'power':
      return (IsarNative.jsObjectGet(jsObj, 'power')) as P;
    case 'powerValue':
      return (IsarNative.jsObjectGet(jsObj, 'powerValue')) as P;
    case 'rarity':
      return (IsarNative.jsObjectGet(jsObj, 'rarity') ?? '') as P;
    case 'rarityValue':
      return (IsarNative.jsObjectGet(jsObj, 'rarityValue') ??
          double.negativeInfinity) as P;
    case 'set':
      return (IsarNative.jsObjectGet(jsObj, 'set') ?? '') as P;
    case 'text':
      return (IsarNative.jsObjectGet(jsObj, 'text') ?? '') as P;
    case 'textJp':
      return (IsarNative.jsObjectGet(jsObj, 'textJp') ?? '') as P;
    case 'toughness':
      return (IsarNative.jsObjectGet(jsObj, 'toughness')) as P;
    case 'toughnessValue':
      return (IsarNative.jsObjectGet(jsObj, 'toughnessValue')) as P;
    case 'type':
      return (IsarNative.jsObjectGet(jsObj, 'type') ?? '') as P;
    case 'typeJp':
      return (IsarNative.jsObjectGet(jsObj, 'typeJp') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _cardAttachLinks(IsarCollection col, int id, Card object) {}

extension CardQueryWhereSort on QueryBuilder<Card, Card, QWhere> {
  QueryBuilder<Card, Card, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension CardQueryWhere on QueryBuilder<Card, Card, QWhereClause> {
  QueryBuilder<Card, Card, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Card, Card, QAfterWhereClause> idNotEqualTo(int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<Card, Card, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Card, Card, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Card, Card, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }
}

extension CardQueryFilter on QueryBuilder<Card, Card, QFilterCondition> {
  QueryBuilder<Card, Card, QAfterFilterCondition> artistEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'artist',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> artistGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'artist',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> artistLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'artist',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> artistBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'artist',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> artistStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'artist',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> artistEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'artist',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> artistContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'artist',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> artistMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'artist',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> backFaceMultiverseIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'backFaceMultiverseId',
      value: null,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> backFaceMultiverseIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'backFaceMultiverseId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition>
      backFaceMultiverseIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'backFaceMultiverseId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> backFaceMultiverseIdLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'backFaceMultiverseId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> backFaceMultiverseIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'backFaceMultiverseId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition>
      backFaceMultiverseIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'backFaceMultiverseId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> backFaceMultiverseIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'backFaceMultiverseId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> backFaceMultiverseIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'backFaceMultiverseId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> backFaceMultiverseIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'backFaceMultiverseId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> cmcEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'cmc',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> cmcGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'cmc',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> cmcLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'cmc',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> cmcBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'cmc',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> colorIdentityIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'colorIdentity',
      value: null,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> colorIdentityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'colorIdentity',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> colorIdentityGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'colorIdentity',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> colorIdentityLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'colorIdentity',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> colorIdentityBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'colorIdentity',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> colorIdentityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'colorIdentity',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> colorIdentityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'colorIdentity',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> colorIdentityContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'colorIdentity',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> colorIdentityMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'colorIdentity',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'flavor',
      value: null,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'flavor',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'flavor',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'flavor',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'flavor',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'flavor',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'flavor',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'flavor',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'flavor',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorJpIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'flavorJp',
      value: null,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorJpEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'flavorJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorJpGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'flavorJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorJpLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'flavorJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorJpBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'flavorJp',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorJpStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'flavorJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorJpEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'flavorJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorJpContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'flavorJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> flavorJpMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'flavorJp',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> idIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> idEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> idGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> idLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> idBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> imageUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'imageUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> imageUrlGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'imageUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> imageUrlLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'imageUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> imageUrlBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'imageUrl',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> imageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'imageUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> imageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'imageUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> imageUrlContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'imageUrl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> imageUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'imageUrl',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> imageUrlJpEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'imageUrlJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> imageUrlJpGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'imageUrlJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> imageUrlJpLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'imageUrlJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> imageUrlJpBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'imageUrlJp',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> imageUrlJpStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'imageUrlJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> imageUrlJpEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'imageUrlJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> imageUrlJpContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'imageUrlJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> imageUrlJpMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'imageUrlJp',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> isBackFaceEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isBackFace',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> layoutEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'layout',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> layoutGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'layout',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> layoutLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'layout',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> layoutBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'layout',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> layoutStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'layout',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> layoutEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'layout',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> layoutContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'layout',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> layoutMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'layout',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> legalityAlchemyEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'legalityAlchemy',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> legalityBrawlEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'legalityBrawl',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> legalityCommanderEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'legalityCommander',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> legalityDuelEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'legalityDuel',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> legalityExplorerEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'legalityExplorer',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> legalityFutureEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'legalityFuture',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> legalityGladiatorEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'legalityGladiator',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> legalityHistoricEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'legalityHistoric',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> legalityHistoricbrawlEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'legalityHistoricbrawl',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> legalityLegacyEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'legalityLegacy',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> legalityModernEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'legalityModern',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> legalityPioneerEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'legalityPioneer',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> legalityStandardEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'legalityStandard',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> legalityVintageEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'legalityVintage',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> loyaltyIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'loyalty',
      value: null,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> loyaltyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'loyalty',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> loyaltyGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'loyalty',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> loyaltyLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'loyalty',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> loyaltyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'loyalty',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> loyaltyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'loyalty',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> loyaltyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'loyalty',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> loyaltyContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'loyalty',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> loyaltyMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'loyalty',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> loyaltyValueIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'loyaltyValue',
      value: null,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> loyaltyValueEqualTo(
      int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'loyaltyValue',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> loyaltyValueGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'loyaltyValue',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> loyaltyValueLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'loyaltyValue',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> loyaltyValueBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'loyaltyValue',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> manaCostEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'manaCost',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> manaCostGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'manaCost',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> manaCostLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'manaCost',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> manaCostBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'manaCost',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> manaCostStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'manaCost',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> manaCostEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'manaCost',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> manaCostContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'manaCost',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> manaCostMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'manaCost',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> multiverseIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'multiverseId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> multiverseIdGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'multiverseId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> multiverseIdLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'multiverseId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> multiverseIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'multiverseId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> multiverseIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'multiverseId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> multiverseIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'multiverseId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> multiverseIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'multiverseId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> multiverseIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'multiverseId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> multiverseIdJpEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'multiverseIdJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> multiverseIdJpGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'multiverseIdJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> multiverseIdJpLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'multiverseIdJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> multiverseIdJpBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'multiverseIdJp',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> multiverseIdJpStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'multiverseIdJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> multiverseIdJpEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'multiverseIdJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> multiverseIdJpContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'multiverseIdJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> multiverseIdJpMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'multiverseIdJp',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> nameLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'name',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> nameJpEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'nameJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> nameJpGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'nameJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> nameJpLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'nameJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> nameJpBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'nameJp',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> nameJpStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'nameJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> nameJpEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'nameJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> nameJpContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'nameJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> nameJpMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'nameJp',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> powerIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'power',
      value: null,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> powerEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'power',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> powerGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'power',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> powerLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'power',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> powerBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'power',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> powerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'power',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> powerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'power',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> powerContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'power',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> powerMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'power',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> powerValueIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'powerValue',
      value: null,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> powerValueEqualTo(
      int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'powerValue',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> powerValueGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'powerValue',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> powerValueLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'powerValue',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> powerValueBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'powerValue',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> rarityEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'rarity',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> rarityGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'rarity',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> rarityLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'rarity',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> rarityBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'rarity',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> rarityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'rarity',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> rarityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'rarity',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> rarityContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'rarity',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> rarityMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'rarity',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> rarityValueEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'rarityValue',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> rarityValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'rarityValue',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> rarityValueLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'rarityValue',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> rarityValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'rarityValue',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> setEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'set',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> setGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'set',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> setLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'set',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> setBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'set',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> setStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'set',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> setEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'set',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> setContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'set',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> setMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'set',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> textGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> textLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'text',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> textContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> textMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'text',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> textJpEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'textJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> textJpGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'textJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> textJpLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'textJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> textJpBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'textJp',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> textJpStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'textJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> textJpEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'textJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> textJpContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'textJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> textJpMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'textJp',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> toughnessIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'toughness',
      value: null,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> toughnessEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'toughness',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> toughnessGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'toughness',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> toughnessLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'toughness',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> toughnessBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'toughness',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> toughnessStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'toughness',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> toughnessEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'toughness',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> toughnessContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'toughness',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> toughnessMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'toughness',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> toughnessValueIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'toughnessValue',
      value: null,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> toughnessValueEqualTo(
      int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'toughnessValue',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> toughnessValueGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'toughnessValue',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> toughnessValueLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'toughnessValue',
      value: value,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> toughnessValueBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'toughnessValue',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> typeGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> typeLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'type',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> typeContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> typeMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'type',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> typeJpEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'typeJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> typeJpGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'typeJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> typeJpLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'typeJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> typeJpBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'typeJp',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> typeJpStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'typeJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> typeJpEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'typeJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> typeJpContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'typeJp',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Card, Card, QAfterFilterCondition> typeJpMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'typeJp',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension CardQueryLinks on QueryBuilder<Card, Card, QFilterCondition> {}

extension CardQueryWhereSortBy on QueryBuilder<Card, Card, QSortBy> {
  QueryBuilder<Card, Card, QAfterSortBy> sortByArtist() {
    return addSortByInternal('artist', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByArtistDesc() {
    return addSortByInternal('artist', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByBackFaceMultiverseId() {
    return addSortByInternal('backFaceMultiverseId', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByBackFaceMultiverseIdDesc() {
    return addSortByInternal('backFaceMultiverseId', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByCmc() {
    return addSortByInternal('cmc', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByCmcDesc() {
    return addSortByInternal('cmc', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByColorIdentity() {
    return addSortByInternal('colorIdentity', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByColorIdentityDesc() {
    return addSortByInternal('colorIdentity', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByFlavor() {
    return addSortByInternal('flavor', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByFlavorDesc() {
    return addSortByInternal('flavor', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByFlavorJp() {
    return addSortByInternal('flavorJp', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByFlavorJpDesc() {
    return addSortByInternal('flavorJp', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByImageUrl() {
    return addSortByInternal('imageUrl', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByImageUrlDesc() {
    return addSortByInternal('imageUrl', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByImageUrlJp() {
    return addSortByInternal('imageUrlJp', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByImageUrlJpDesc() {
    return addSortByInternal('imageUrlJp', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByIsBackFace() {
    return addSortByInternal('isBackFace', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByIsBackFaceDesc() {
    return addSortByInternal('isBackFace', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLayout() {
    return addSortByInternal('layout', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLayoutDesc() {
    return addSortByInternal('layout', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityAlchemy() {
    return addSortByInternal('legalityAlchemy', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityAlchemyDesc() {
    return addSortByInternal('legalityAlchemy', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityBrawl() {
    return addSortByInternal('legalityBrawl', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityBrawlDesc() {
    return addSortByInternal('legalityBrawl', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityCommander() {
    return addSortByInternal('legalityCommander', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityCommanderDesc() {
    return addSortByInternal('legalityCommander', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityDuel() {
    return addSortByInternal('legalityDuel', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityDuelDesc() {
    return addSortByInternal('legalityDuel', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityExplorer() {
    return addSortByInternal('legalityExplorer', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityExplorerDesc() {
    return addSortByInternal('legalityExplorer', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityFuture() {
    return addSortByInternal('legalityFuture', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityFutureDesc() {
    return addSortByInternal('legalityFuture', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityGladiator() {
    return addSortByInternal('legalityGladiator', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityGladiatorDesc() {
    return addSortByInternal('legalityGladiator', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityHistoric() {
    return addSortByInternal('legalityHistoric', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityHistoricDesc() {
    return addSortByInternal('legalityHistoric', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityHistoricbrawl() {
    return addSortByInternal('legalityHistoricbrawl', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityHistoricbrawlDesc() {
    return addSortByInternal('legalityHistoricbrawl', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityLegacy() {
    return addSortByInternal('legalityLegacy', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityLegacyDesc() {
    return addSortByInternal('legalityLegacy', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityModern() {
    return addSortByInternal('legalityModern', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityModernDesc() {
    return addSortByInternal('legalityModern', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityPioneer() {
    return addSortByInternal('legalityPioneer', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityPioneerDesc() {
    return addSortByInternal('legalityPioneer', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityStandard() {
    return addSortByInternal('legalityStandard', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityStandardDesc() {
    return addSortByInternal('legalityStandard', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityVintage() {
    return addSortByInternal('legalityVintage', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLegalityVintageDesc() {
    return addSortByInternal('legalityVintage', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLoyalty() {
    return addSortByInternal('loyalty', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLoyaltyDesc() {
    return addSortByInternal('loyalty', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLoyaltyValue() {
    return addSortByInternal('loyaltyValue', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByLoyaltyValueDesc() {
    return addSortByInternal('loyaltyValue', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByManaCost() {
    return addSortByInternal('manaCost', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByManaCostDesc() {
    return addSortByInternal('manaCost', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByMultiverseId() {
    return addSortByInternal('multiverseId', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByMultiverseIdDesc() {
    return addSortByInternal('multiverseId', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByMultiverseIdJp() {
    return addSortByInternal('multiverseIdJp', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByMultiverseIdJpDesc() {
    return addSortByInternal('multiverseIdJp', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByNameJp() {
    return addSortByInternal('nameJp', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByNameJpDesc() {
    return addSortByInternal('nameJp', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByPower() {
    return addSortByInternal('power', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByPowerDesc() {
    return addSortByInternal('power', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByPowerValue() {
    return addSortByInternal('powerValue', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByPowerValueDesc() {
    return addSortByInternal('powerValue', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByRarity() {
    return addSortByInternal('rarity', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByRarityDesc() {
    return addSortByInternal('rarity', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByRarityValue() {
    return addSortByInternal('rarityValue', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByRarityValueDesc() {
    return addSortByInternal('rarityValue', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortBySet() {
    return addSortByInternal('set', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortBySetDesc() {
    return addSortByInternal('set', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByText() {
    return addSortByInternal('text', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByTextDesc() {
    return addSortByInternal('text', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByTextJp() {
    return addSortByInternal('textJp', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByTextJpDesc() {
    return addSortByInternal('textJp', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByToughness() {
    return addSortByInternal('toughness', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByToughnessDesc() {
    return addSortByInternal('toughness', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByToughnessValue() {
    return addSortByInternal('toughnessValue', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByToughnessValueDesc() {
    return addSortByInternal('toughnessValue', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByType() {
    return addSortByInternal('type', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByTypeDesc() {
    return addSortByInternal('type', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByTypeJp() {
    return addSortByInternal('typeJp', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> sortByTypeJpDesc() {
    return addSortByInternal('typeJp', Sort.desc);
  }
}

extension CardQueryWhereSortThenBy on QueryBuilder<Card, Card, QSortThenBy> {
  QueryBuilder<Card, Card, QAfterSortBy> thenByArtist() {
    return addSortByInternal('artist', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByArtistDesc() {
    return addSortByInternal('artist', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByBackFaceMultiverseId() {
    return addSortByInternal('backFaceMultiverseId', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByBackFaceMultiverseIdDesc() {
    return addSortByInternal('backFaceMultiverseId', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByCmc() {
    return addSortByInternal('cmc', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByCmcDesc() {
    return addSortByInternal('cmc', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByColorIdentity() {
    return addSortByInternal('colorIdentity', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByColorIdentityDesc() {
    return addSortByInternal('colorIdentity', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByFlavor() {
    return addSortByInternal('flavor', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByFlavorDesc() {
    return addSortByInternal('flavor', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByFlavorJp() {
    return addSortByInternal('flavorJp', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByFlavorJpDesc() {
    return addSortByInternal('flavorJp', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByImageUrl() {
    return addSortByInternal('imageUrl', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByImageUrlDesc() {
    return addSortByInternal('imageUrl', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByImageUrlJp() {
    return addSortByInternal('imageUrlJp', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByImageUrlJpDesc() {
    return addSortByInternal('imageUrlJp', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByIsBackFace() {
    return addSortByInternal('isBackFace', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByIsBackFaceDesc() {
    return addSortByInternal('isBackFace', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLayout() {
    return addSortByInternal('layout', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLayoutDesc() {
    return addSortByInternal('layout', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityAlchemy() {
    return addSortByInternal('legalityAlchemy', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityAlchemyDesc() {
    return addSortByInternal('legalityAlchemy', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityBrawl() {
    return addSortByInternal('legalityBrawl', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityBrawlDesc() {
    return addSortByInternal('legalityBrawl', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityCommander() {
    return addSortByInternal('legalityCommander', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityCommanderDesc() {
    return addSortByInternal('legalityCommander', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityDuel() {
    return addSortByInternal('legalityDuel', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityDuelDesc() {
    return addSortByInternal('legalityDuel', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityExplorer() {
    return addSortByInternal('legalityExplorer', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityExplorerDesc() {
    return addSortByInternal('legalityExplorer', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityFuture() {
    return addSortByInternal('legalityFuture', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityFutureDesc() {
    return addSortByInternal('legalityFuture', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityGladiator() {
    return addSortByInternal('legalityGladiator', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityGladiatorDesc() {
    return addSortByInternal('legalityGladiator', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityHistoric() {
    return addSortByInternal('legalityHistoric', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityHistoricDesc() {
    return addSortByInternal('legalityHistoric', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityHistoricbrawl() {
    return addSortByInternal('legalityHistoricbrawl', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityHistoricbrawlDesc() {
    return addSortByInternal('legalityHistoricbrawl', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityLegacy() {
    return addSortByInternal('legalityLegacy', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityLegacyDesc() {
    return addSortByInternal('legalityLegacy', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityModern() {
    return addSortByInternal('legalityModern', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityModernDesc() {
    return addSortByInternal('legalityModern', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityPioneer() {
    return addSortByInternal('legalityPioneer', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityPioneerDesc() {
    return addSortByInternal('legalityPioneer', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityStandard() {
    return addSortByInternal('legalityStandard', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityStandardDesc() {
    return addSortByInternal('legalityStandard', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityVintage() {
    return addSortByInternal('legalityVintage', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLegalityVintageDesc() {
    return addSortByInternal('legalityVintage', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLoyalty() {
    return addSortByInternal('loyalty', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLoyaltyDesc() {
    return addSortByInternal('loyalty', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLoyaltyValue() {
    return addSortByInternal('loyaltyValue', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByLoyaltyValueDesc() {
    return addSortByInternal('loyaltyValue', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByManaCost() {
    return addSortByInternal('manaCost', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByManaCostDesc() {
    return addSortByInternal('manaCost', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByMultiverseId() {
    return addSortByInternal('multiverseId', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByMultiverseIdDesc() {
    return addSortByInternal('multiverseId', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByMultiverseIdJp() {
    return addSortByInternal('multiverseIdJp', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByMultiverseIdJpDesc() {
    return addSortByInternal('multiverseIdJp', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByNameJp() {
    return addSortByInternal('nameJp', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByNameJpDesc() {
    return addSortByInternal('nameJp', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByPower() {
    return addSortByInternal('power', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByPowerDesc() {
    return addSortByInternal('power', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByPowerValue() {
    return addSortByInternal('powerValue', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByPowerValueDesc() {
    return addSortByInternal('powerValue', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByRarity() {
    return addSortByInternal('rarity', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByRarityDesc() {
    return addSortByInternal('rarity', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByRarityValue() {
    return addSortByInternal('rarityValue', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByRarityValueDesc() {
    return addSortByInternal('rarityValue', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenBySet() {
    return addSortByInternal('set', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenBySetDesc() {
    return addSortByInternal('set', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByText() {
    return addSortByInternal('text', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByTextDesc() {
    return addSortByInternal('text', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByTextJp() {
    return addSortByInternal('textJp', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByTextJpDesc() {
    return addSortByInternal('textJp', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByToughness() {
    return addSortByInternal('toughness', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByToughnessDesc() {
    return addSortByInternal('toughness', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByToughnessValue() {
    return addSortByInternal('toughnessValue', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByToughnessValueDesc() {
    return addSortByInternal('toughnessValue', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByType() {
    return addSortByInternal('type', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByTypeDesc() {
    return addSortByInternal('type', Sort.desc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByTypeJp() {
    return addSortByInternal('typeJp', Sort.asc);
  }

  QueryBuilder<Card, Card, QAfterSortBy> thenByTypeJpDesc() {
    return addSortByInternal('typeJp', Sort.desc);
  }
}

extension CardQueryWhereDistinct on QueryBuilder<Card, Card, QDistinct> {
  QueryBuilder<Card, Card, QDistinct> distinctByArtist(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('artist', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByBackFaceMultiverseId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('backFaceMultiverseId',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByCmc() {
    return addDistinctByInternal('cmc');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByColorIdentity(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('colorIdentity', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByFlavor(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('flavor', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByFlavorJp(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('flavorJp', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByImageUrl(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('imageUrl', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByImageUrlJp(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('imageUrlJp', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByIsBackFace() {
    return addDistinctByInternal('isBackFace');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByLayout(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('layout', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByLegalityAlchemy() {
    return addDistinctByInternal('legalityAlchemy');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByLegalityBrawl() {
    return addDistinctByInternal('legalityBrawl');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByLegalityCommander() {
    return addDistinctByInternal('legalityCommander');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByLegalityDuel() {
    return addDistinctByInternal('legalityDuel');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByLegalityExplorer() {
    return addDistinctByInternal('legalityExplorer');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByLegalityFuture() {
    return addDistinctByInternal('legalityFuture');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByLegalityGladiator() {
    return addDistinctByInternal('legalityGladiator');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByLegalityHistoric() {
    return addDistinctByInternal('legalityHistoric');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByLegalityHistoricbrawl() {
    return addDistinctByInternal('legalityHistoricbrawl');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByLegalityLegacy() {
    return addDistinctByInternal('legalityLegacy');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByLegalityModern() {
    return addDistinctByInternal('legalityModern');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByLegalityPioneer() {
    return addDistinctByInternal('legalityPioneer');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByLegalityStandard() {
    return addDistinctByInternal('legalityStandard');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByLegalityVintage() {
    return addDistinctByInternal('legalityVintage');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByLoyalty(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('loyalty', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByLoyaltyValue() {
    return addDistinctByInternal('loyaltyValue');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByManaCost(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('manaCost', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByMultiverseId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('multiverseId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByMultiverseIdJp(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('multiverseIdJp',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByNameJp(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('nameJp', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByPower(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('power', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByPowerValue() {
    return addDistinctByInternal('powerValue');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByRarity(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('rarity', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByRarityValue() {
    return addDistinctByInternal('rarityValue');
  }

  QueryBuilder<Card, Card, QDistinct> distinctBySet(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('set', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('text', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByTextJp(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('textJp', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByToughness(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('toughness', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByToughnessValue() {
    return addDistinctByInternal('toughnessValue');
  }

  QueryBuilder<Card, Card, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('type', caseSensitive: caseSensitive);
  }

  QueryBuilder<Card, Card, QDistinct> distinctByTypeJp(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('typeJp', caseSensitive: caseSensitive);
  }
}

extension CardQueryProperty on QueryBuilder<Card, Card, QQueryProperty> {
  QueryBuilder<Card, String, QQueryOperations> artistProperty() {
    return addPropertyNameInternal('artist');
  }

  QueryBuilder<Card, String?, QQueryOperations> backFaceMultiverseIdProperty() {
    return addPropertyNameInternal('backFaceMultiverseId');
  }

  QueryBuilder<Card, int, QQueryOperations> cmcProperty() {
    return addPropertyNameInternal('cmc');
  }

  QueryBuilder<Card, String?, QQueryOperations> colorIdentityProperty() {
    return addPropertyNameInternal('colorIdentity');
  }

  QueryBuilder<Card, String?, QQueryOperations> flavorProperty() {
    return addPropertyNameInternal('flavor');
  }

  QueryBuilder<Card, String?, QQueryOperations> flavorJpProperty() {
    return addPropertyNameInternal('flavorJp');
  }

  QueryBuilder<Card, int?, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Card, String, QQueryOperations> imageUrlProperty() {
    return addPropertyNameInternal('imageUrl');
  }

  QueryBuilder<Card, String, QQueryOperations> imageUrlJpProperty() {
    return addPropertyNameInternal('imageUrlJp');
  }

  QueryBuilder<Card, bool, QQueryOperations> isBackFaceProperty() {
    return addPropertyNameInternal('isBackFace');
  }

  QueryBuilder<Card, String, QQueryOperations> layoutProperty() {
    return addPropertyNameInternal('layout');
  }

  QueryBuilder<Card, bool, QQueryOperations> legalityAlchemyProperty() {
    return addPropertyNameInternal('legalityAlchemy');
  }

  QueryBuilder<Card, bool, QQueryOperations> legalityBrawlProperty() {
    return addPropertyNameInternal('legalityBrawl');
  }

  QueryBuilder<Card, bool, QQueryOperations> legalityCommanderProperty() {
    return addPropertyNameInternal('legalityCommander');
  }

  QueryBuilder<Card, bool, QQueryOperations> legalityDuelProperty() {
    return addPropertyNameInternal('legalityDuel');
  }

  QueryBuilder<Card, bool, QQueryOperations> legalityExplorerProperty() {
    return addPropertyNameInternal('legalityExplorer');
  }

  QueryBuilder<Card, bool, QQueryOperations> legalityFutureProperty() {
    return addPropertyNameInternal('legalityFuture');
  }

  QueryBuilder<Card, bool, QQueryOperations> legalityGladiatorProperty() {
    return addPropertyNameInternal('legalityGladiator');
  }

  QueryBuilder<Card, bool, QQueryOperations> legalityHistoricProperty() {
    return addPropertyNameInternal('legalityHistoric');
  }

  QueryBuilder<Card, bool, QQueryOperations> legalityHistoricbrawlProperty() {
    return addPropertyNameInternal('legalityHistoricbrawl');
  }

  QueryBuilder<Card, bool, QQueryOperations> legalityLegacyProperty() {
    return addPropertyNameInternal('legalityLegacy');
  }

  QueryBuilder<Card, bool, QQueryOperations> legalityModernProperty() {
    return addPropertyNameInternal('legalityModern');
  }

  QueryBuilder<Card, bool, QQueryOperations> legalityPioneerProperty() {
    return addPropertyNameInternal('legalityPioneer');
  }

  QueryBuilder<Card, bool, QQueryOperations> legalityStandardProperty() {
    return addPropertyNameInternal('legalityStandard');
  }

  QueryBuilder<Card, bool, QQueryOperations> legalityVintageProperty() {
    return addPropertyNameInternal('legalityVintage');
  }

  QueryBuilder<Card, String?, QQueryOperations> loyaltyProperty() {
    return addPropertyNameInternal('loyalty');
  }

  QueryBuilder<Card, int?, QQueryOperations> loyaltyValueProperty() {
    return addPropertyNameInternal('loyaltyValue');
  }

  QueryBuilder<Card, String, QQueryOperations> manaCostProperty() {
    return addPropertyNameInternal('manaCost');
  }

  QueryBuilder<Card, String, QQueryOperations> multiverseIdProperty() {
    return addPropertyNameInternal('multiverseId');
  }

  QueryBuilder<Card, String, QQueryOperations> multiverseIdJpProperty() {
    return addPropertyNameInternal('multiverseIdJp');
  }

  QueryBuilder<Card, String, QQueryOperations> nameProperty() {
    return addPropertyNameInternal('name');
  }

  QueryBuilder<Card, String, QQueryOperations> nameJpProperty() {
    return addPropertyNameInternal('nameJp');
  }

  QueryBuilder<Card, String?, QQueryOperations> powerProperty() {
    return addPropertyNameInternal('power');
  }

  QueryBuilder<Card, int?, QQueryOperations> powerValueProperty() {
    return addPropertyNameInternal('powerValue');
  }

  QueryBuilder<Card, String, QQueryOperations> rarityProperty() {
    return addPropertyNameInternal('rarity');
  }

  QueryBuilder<Card, int, QQueryOperations> rarityValueProperty() {
    return addPropertyNameInternal('rarityValue');
  }

  QueryBuilder<Card, String, QQueryOperations> setProperty() {
    return addPropertyNameInternal('set');
  }

  QueryBuilder<Card, String, QQueryOperations> textProperty() {
    return addPropertyNameInternal('text');
  }

  QueryBuilder<Card, String, QQueryOperations> textJpProperty() {
    return addPropertyNameInternal('textJp');
  }

  QueryBuilder<Card, String?, QQueryOperations> toughnessProperty() {
    return addPropertyNameInternal('toughness');
  }

  QueryBuilder<Card, int?, QQueryOperations> toughnessValueProperty() {
    return addPropertyNameInternal('toughnessValue');
  }

  QueryBuilder<Card, String, QQueryOperations> typeProperty() {
    return addPropertyNameInternal('type');
  }

  QueryBuilder<Card, String, QQueryOperations> typeJpProperty() {
    return addPropertyNameInternal('typeJp');
  }
}
