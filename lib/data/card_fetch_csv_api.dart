import 'dart:convert';

import 'package:csv/csv.dart' as csv;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../assets/constants.dart' as constants;

class CardFetchCsvApi {
  Future<List<List<dynamic>>> fetchCardCsv() async {
    Response response = await http.get(Uri.parse("https://magic-image-generator-staging.s3.ap-northeast-1.amazonaws.com/cardmaster_neo.csv"));
    String decodedResponseBody = Utf8Decoder().convert(response.bodyBytes);

    csv.CsvToListConverter converter= const csv.CsvToListConverter(
        eol: '\r\n', fieldDelimiter: ','
    );

    List<List> listCreated= converter.convert(decodedResponseBody);

    return Future<List<List<dynamic>>>.value(listCreated);
  }

}