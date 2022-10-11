import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:csv/csv.dart' as csv;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:magic_image_generator/data/card_master_version.dart';
import '../common/constants.dart' as constants;
import '../common/util.dart';

class CardFetchCsvApi {
  Future<List<List<dynamic>>> fetchCardCsv() async {
    Response response = await http.get(Uri.parse(Util.getCardMasterUrl()), headers: {"Cache-Control": "no-cache"});

    var rawBytes = GZipDecoder().decodeBytes(response.bodyBytes);
    String decodedResponseBody = const Utf8Decoder().convert(rawBytes);

    csv.CsvToListConverter converter= const csv.CsvToListConverter(
        eol: '\r\n', fieldDelimiter: ','
    );

    List<List> listCreated= converter.convert(decodedResponseBody);

    return Future<List<List<dynamic>>>.value(listCreated);
  }

  Future<CardMasterVersion> fetchCardMasterVersion() async {
    Response response = await http.get(Uri.parse(Util.cardMasterVersionUrl()), headers: {"Cache-Control": "no-cache"});

    return CardMasterVersion.fromJson(jsonDecode(response.body));
  }

}