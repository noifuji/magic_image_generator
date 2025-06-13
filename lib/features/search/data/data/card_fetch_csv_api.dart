import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:csv/csv.dart' as csv;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:magic_image_generator/features/search/data/data/card_master_version.dart';
import 'package:magic_image_generator/core/util.dart';

class CardFetchCsvApi {
  Future<List<List<dynamic>>> fetchCardCsv({bool cache = true}) async {
    DateTime start = DateTime.now();
    Response response = await http.get(Uri.parse(Util.getCardMasterUrl()),
        headers: cache ? {} : {"Cache-Control": "no-cache"});
    Util.printTimeStamp(
        "http.get:${DateTime.now().difference(start).inMilliseconds}");

    start = DateTime.now();
    var rawBytes = GZipDecoder().decodeBytes(response.bodyBytes);
    Util.printTimeStamp(
        "GZipDecoder().decodeBytes:${DateTime.now().difference(start).inMilliseconds}");
    start = DateTime.now();
    String decodedResponseBody = const Utf8Decoder().convert(rawBytes);
    Util.printTimeStamp(
        "Utf8Decoder().convert:${DateTime.now().difference(start).inMilliseconds}");

    csv.CsvToListConverter converter =
        const csv.CsvToListConverter(eol: '\r\n', fieldDelimiter: ',');

    start = DateTime.now();
    List<List> listCreated = converter.convert(decodedResponseBody);
    Util.printTimeStamp(
        "converter.convert:${DateTime.now().difference(start).inMilliseconds}");

    return Future<List<List<dynamic>>>.value(listCreated);
  }

  Future<CardMasterVersion> fetchCardMasterVersion() async {
    Response response = await http.get(Uri.parse(Util.cardMasterVersionUrl()),
        headers: {"Cache-Control": "no-cache"});

    return CardMasterVersion.fromJson(jsonDecode(response.body));
  }
}
