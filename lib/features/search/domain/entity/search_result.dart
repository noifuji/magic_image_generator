import 'package:magic_image_generator/core/mig_exception.dart';

import 'card_info_header.dart';

class SearchResult {
  List<CardInfoHeader> cards = [];
  bool isSuccess = false;
  MIGException? exception;

  SearchResult({required this.cards, required this.isSuccess, this.exception});
}
