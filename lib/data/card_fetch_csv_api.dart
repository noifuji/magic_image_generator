import 'dart:convert';

import 'package:csv/csv.dart' as csv;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:magic_image_generator/data/card_master_version.dart';
import '../assets/constants.dart' as constants;

class CardFetchCsvApi {
  Future<List<List<dynamic>>> fetchCardCsv() async {
    Response response = await http.get(Uri.parse(constants.cardMasterUrlS3), headers: {"Cache-Control": "no-cache"});
    String decodedResponseBody = Utf8Decoder().convert(response.bodyBytes);

    csv.CsvToListConverter converter= const csv.CsvToListConverter(
        eol: '\r\n', fieldDelimiter: ','
    );

    List<List> listCreated= converter.convert(decodedResponseBody);

    return Future<List<List<dynamic>>>.value(listCreated);
  }

  Future<CardMasterVersion> fetchCardMasterVersion() async {
    Response response = await http.get(Uri.parse(constants.cardMasterVersionUrlS3), headers: {"Cache-Control": "no-cache"});

    return CardMasterVersion.fromJson(jsonDecode(response.body));
  }

}