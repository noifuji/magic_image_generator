import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'card.dart';
import 'card_master_version.dart';

class IsarFactory {
  static Future<Isar> getInstance() async {
    var isar = Isar.getInstance();
    if (isar == null || !isar.isOpen) {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        schemas: [CardSchema, CardMasterVersionSchema],
        directory: dir.path
      );
    }

    return isar;
  }
}