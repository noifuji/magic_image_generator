import 'dart:convert';
import '../../common/constants.dart';

class ImportDeckListUsecase {
  String call(String rawDeckList, Map<ArenaDeckListGroup, String> groupMap) {
    var jsonDeckList = convertToJson(rawDeckList, groupMap);
    var deckList = json.decode(jsonDeckList);
    List<String> main =
        deckList.map<String>((x) => x[arenaDeckListKeyName] as String).toList();
    return main.fold<String>(
        '', (p, c) => (p == '' ? 'name="$c"' : '$p or name="$c"'));
  }

  String convertToJson(String s, Map<ArenaDeckListGroup, String> groupMap) {
    var l = s.split('\n');
    var result = [];
    ArenaDeckListGroup group = ArenaDeckListGroup.none;

    for (int i = 0; i < l.length; i++) {
      if (l[i].isEmpty) {
      } else if (isNumeric(l[i][0])) {
        if (group == ArenaDeckListGroup.none) {
          throw Exception();
        }
        result.add(convertStrToMap(l[i], group));
      } else {
        if (l[i] == groupMap[ArenaDeckListGroup.main]) {
          group = ArenaDeckListGroup.main;
        } else if (l[i] == groupMap[ArenaDeckListGroup.sideboard]) {
          group = ArenaDeckListGroup.sideboard;
        } else if (l[i] == groupMap[ArenaDeckListGroup.companion]) {
          group = ArenaDeckListGroup.companion;
        } else if (l[i] == groupMap[ArenaDeckListGroup.commander]) {
          group = ArenaDeckListGroup.commander;
        } else {
          throw Exception();
        }
      }
    }

    var j = json.encode(result);

    return j;
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  Map<String, String> convertStrToMap(String s, ArenaDeckListGroup group) {
    Map<String, String> map = {};
    List<String> tmp = s.split(' ');
    if (tmp.isEmpty || !isNumeric(tmp[0])) {
      throw Exception();
    }

    map[arenaDeckListKeyQuantity] = tmp[0];

    int setIndex = tmp.indexWhere((x) => x.contains('('));

    if (setIndex > 1) {
      map[arenaDeckListKeyName] =
          tmp.sublist(1, setIndex).fold<String>('', (p, c) {
        return (p == '' ? c : '$p $c');
      });

      map[arenaDeckListKeySetCode] =
          tmp[setIndex].replaceAll('(', '').replaceAll(')', '');

      if (tmp.asMap().containsKey(setIndex + 1)) {
        map[arenaDeckListKeyNo] = tmp[setIndex + 1];
      }
    } else {
      map[arenaDeckListKeyName] =
          tmp.sublist(1, tmp.length).fold<String>('', (p, c) {
        return (p == '' ? c : '$p $c');
      });
    }

    map[arenaDeckListKeyGroup] = group.name;

    return map;
  }
}
