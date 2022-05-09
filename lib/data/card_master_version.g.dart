// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_master_version.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetCardMasterVersionCollection on Isar {
  IsarCollection<CardMasterVersion> get cardMasterVersions => getCollection();
}

const CardMasterVersionSchema = CollectionSchema(
  name: 'CardMasterVersion',
  schema:
      '{"name":"CardMasterVersion","idName":"id","properties":[{"name":"version","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'version': 0},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _cardMasterVersionGetId,
  setId: _cardMasterVersionSetId,
  getLinks: _cardMasterVersionGetLinks,
  attachLinks: _cardMasterVersionAttachLinks,
  serializeNative: _cardMasterVersionSerializeNative,
  deserializeNative: _cardMasterVersionDeserializeNative,
  deserializePropNative: _cardMasterVersionDeserializePropNative,
  serializeWeb: _cardMasterVersionSerializeWeb,
  deserializeWeb: _cardMasterVersionDeserializeWeb,
  deserializePropWeb: _cardMasterVersionDeserializePropWeb,
  version: 3,
);

int? _cardMasterVersionGetId(CardMasterVersion object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _cardMasterVersionSetId(CardMasterVersion object, int id) {
  object.id = id;
}

List<IsarLinkBase> _cardMasterVersionGetLinks(CardMasterVersion object) {
  return [];
}

void _cardMasterVersionSerializeNative(
    IsarCollection<CardMasterVersion> collection,
    IsarRawObject rawObj,
    CardMasterVersion object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.version;
  final _version = value0;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _version);
}

CardMasterVersion _cardMasterVersionDeserializeNative(
    IsarCollection<CardMasterVersion> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = CardMasterVersion();
  object.id = id;
  object.version = reader.readLong(offsets[0]);
  return object;
}

P _cardMasterVersionDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLong(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _cardMasterVersionSerializeWeb(
    IsarCollection<CardMasterVersion> collection, CardMasterVersion object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'version', object.version);
  return jsObj;
}

CardMasterVersion _cardMasterVersionDeserializeWeb(
    IsarCollection<CardMasterVersion> collection, dynamic jsObj) {
  final object = CardMasterVersion();
  object.id = IsarNative.jsObjectGet(jsObj, 'id');
  object.version =
      IsarNative.jsObjectGet(jsObj, 'version') ?? double.negativeInfinity;
  return object;
}

P _cardMasterVersionDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id')) as P;
    case 'version':
      return (IsarNative.jsObjectGet(jsObj, 'version') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _cardMasterVersionAttachLinks(
    IsarCollection col, int id, CardMasterVersion object) {}

extension CardMasterVersionQueryWhereSort
    on QueryBuilder<CardMasterVersion, CardMasterVersion, QWhere> {
  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension CardMasterVersionQueryWhere
    on QueryBuilder<CardMasterVersion, CardMasterVersion, QWhereClause> {
  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterWhereClause>
      idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterWhereClause>
      idNotEqualTo(int id) {
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

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterWhereClause>
      idGreaterThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterWhereClause>
      idLessThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterWhereClause>
      idBetween(
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

extension CardMasterVersionQueryFilter
    on QueryBuilder<CardMasterVersion, CardMasterVersion, QFilterCondition> {
  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterFilterCondition>
      idIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterFilterCondition>
      idEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterFilterCondition>
      versionEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'version',
      value: value,
    ));
  }

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterFilterCondition>
      versionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'version',
      value: value,
    ));
  }

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterFilterCondition>
      versionLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'version',
      value: value,
    ));
  }

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterFilterCondition>
      versionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'version',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension CardMasterVersionQueryLinks
    on QueryBuilder<CardMasterVersion, CardMasterVersion, QFilterCondition> {}

extension CardMasterVersionQueryWhereSortBy
    on QueryBuilder<CardMasterVersion, CardMasterVersion, QSortBy> {
  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterSortBy>
      sortByVersion() {
    return addSortByInternal('version', Sort.asc);
  }

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterSortBy>
      sortByVersionDesc() {
    return addSortByInternal('version', Sort.desc);
  }
}

extension CardMasterVersionQueryWhereSortThenBy
    on QueryBuilder<CardMasterVersion, CardMasterVersion, QSortThenBy> {
  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterSortBy>
      thenByVersion() {
    return addSortByInternal('version', Sort.asc);
  }

  QueryBuilder<CardMasterVersion, CardMasterVersion, QAfterSortBy>
      thenByVersionDesc() {
    return addSortByInternal('version', Sort.desc);
  }
}

extension CardMasterVersionQueryWhereDistinct
    on QueryBuilder<CardMasterVersion, CardMasterVersion, QDistinct> {
  QueryBuilder<CardMasterVersion, CardMasterVersion, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<CardMasterVersion, CardMasterVersion, QDistinct>
      distinctByVersion() {
    return addDistinctByInternal('version');
  }
}

extension CardMasterVersionQueryProperty
    on QueryBuilder<CardMasterVersion, CardMasterVersion, QQueryProperty> {
  QueryBuilder<CardMasterVersion, int?, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<CardMasterVersion, int, QQueryOperations> versionProperty() {
    return addPropertyNameInternal('version');
  }
}
