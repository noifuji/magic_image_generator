import 'package:flutter_test/flutter_test.dart';
import 'package:magic_image_generator/features/deck_import/usecase/import_deck_list_usecase.dart';
import 'package:magic_image_generator/core/constants.dart';

void main() {
  Map<ArenaDeckListGroup, String> groupMap = {
    ArenaDeckListGroup.main: 'Deck',
    ArenaDeckListGroup.sideboard: 'Sideboard',
    ArenaDeckListGroup.companion: 'Companion',
    ArenaDeckListGroup.commander: 'Commander',
  };

  test('Import a deck exported from Arena in English.', () async {
    var deckList = """Deck
4 Corpse Appraiser (SNC) 178
4 Bloodtithe Harvester (VOW) 232

Sideboard
1 Sheoldred, the Apocalypse (DMU) 107
2 Unlicensed Hearse (SNC) 246""";
    var importer = ImportDeckListUsecase();
    var result = importer.call(deckList, groupMap);

    expect(result,
        'name="Corpse Appraiser" or name="Bloodtithe Harvester" or name="Sheoldred, the Apocalypse" or name="Unlicensed Hearse"');
  });

  test('Only main deck.', () async {
    var deckList = """Deck
4 Corpse Appraiser (SNC) 178
4 Bloodtithe Harvester (VOW) 232""";
    var importer = ImportDeckListUsecase();
    var result = importer.call(deckList, groupMap);

    expect(result, 'name="Corpse Appraiser" or name="Bloodtithe Harvester"');
  });

  test('Only sideboard deck.', () async {
    var deckList = """Sideboard
1 Sheoldred, the Apocalypse (DMU) 107
2 Unlicensed Hearse (SNC) 246""";
    var importer = ImportDeckListUsecase();
    var result = importer.call(deckList, groupMap);

    expect(
        result, 'name="Sheoldred, the Apocalypse" or name="Unlicensed Hearse"');
  });

  test('Companion deck.', () async {
    var deckList = """Companion
1 Lurrus of the Dream-Den (IKO) 226

Deck
4 Selfless Savior (M21) 36

Sideboard
1 Expanded Anatomy (STX) 2""";
    var importer = ImportDeckListUsecase();
    var result = importer.call(deckList, groupMap);

    expect(result,
        'name="Lurrus of the Dream-Den" or name="Selfless Savior" or name="Expanded Anatomy"');
  });

  test('No set names.', () async {
    var deckList = """Deck
4 Corpse Appraiser

Sideboard
1 Sheoldred, the Apocalypse""";
    var importer = ImportDeckListUsecase();
    var result = importer.call(deckList, groupMap);

    expect(
        result, 'name="Corpse Appraiser" or name="Sheoldred, the Apocalypse"');
  });

  test('No main and sideboard titles.', () async {
    var deckList = """4 Corpse Appraiser (SNC) 178
4 Bloodtithe Harvester (VOW) 232

2 Unlicensed Hearse (SNC) 246""";
    var importer = ImportDeckListUsecase();

    expect(() => importer.call(deckList, groupMap),
        throwsA(const TypeMatcher<Exception>()));
  });
}
