import 'package:isar/isar.dart';

part 'card_master_version.g.dart';

@Collection()
class CardMasterVersion {
  @Id()
  int? id;

  late int version;

  static CardMasterVersion fromJson(dynamic json) {
    var version = json["version"];

    return CardMasterVersion()..version = version;
  }
}
