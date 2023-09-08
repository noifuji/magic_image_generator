class CardMasterVersion {
  int? id;

  late int version;

  static CardMasterVersion fromJson(dynamic json) {
    var version = json["version"];

    return CardMasterVersion()..version = version;
  }
}
