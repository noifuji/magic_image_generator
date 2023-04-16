import 'package:isar/isar.dart';

import 'card.dart';
import 'card_master_version.dart';

class IsarFactory {
  static Future<Isar> getInstance() async {
    var isar = Isar.getInstance();
    if (isar == null || !isar.isOpen) {
      isar = await Isar.open(
          schemas: [CardSchema, CardMasterVersionSchema]
      );
    }

    return isar;
  }
}