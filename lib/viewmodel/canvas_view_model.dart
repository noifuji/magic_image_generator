import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:magic_image_generator/domain/entity/card_info_header.dart';
import 'package:magic_image_generator/domain/usecase/fetch_card_images_usecase.dart';
import 'package:magic_image_generator/domain/usecase/merge_card_images_usecase.dart';

import '../domain/usecase/copy_image_to_clipboard_usecase_nonweb.dart'
    if (dart.library.html) '../domain/usecase/copy_image_to_clipboard_usecase_web.dart';
import '../domain/usecase/download_image_usecase_nonweb.dart'
    if (dart.library.html) '../domain/usecase/download_image_usecase_web.dart';

class CanvasViewModel extends ChangeNotifier {
  List<List<CardInfoHeader>> _selectedCards = [];

  List<List<CardInfoHeader>> get selectedCards => _selectedCards;

  void setSelectedCards(List<List<CardInfoHeader>> cards) {
    _selectedCards = cards;
    notifyListeners();
  }

  void addSelectedCards(int rowIndex, CardInfoHeader card) {
    if (rowIndex > _selectedCards.length) {
      throw Exception();
    }

    if (rowIndex == _selectedCards.length) {
      _selectedCards.add([card]);
    } else {
      _selectedCards[rowIndex].add(card);
    }

    notifyListeners();
  }

  bool isInCanvas(CardInfoHeader card) {
    bool result = false;
    for (var row in _selectedCards) {
      result = result ||
          row
              .where((element) => element.firstFace.name == card.firstFace.name)
              .toList()
              .isNotEmpty;
    }

    return result;
  }

  void flip(CardInfoHeader card) {
    int rowIndex = selectedCards.indexWhere((row) =>
        row.where((c) => c.displayId == card.displayId).toList().isNotEmpty);
    int colIndex = selectedCards[rowIndex]
        .indexWhere((c) => c.displayId == card.displayId);

    _selectedCards[rowIndex][colIndex] = _selectedCards[rowIndex][colIndex]
        .copyWith(isFront: !_selectedCards[rowIndex][colIndex].isFront);
    notifyListeners();
  }

  void rotate90cw(CardInfoHeader card) {
    int rowIndex = selectedCards.indexWhere((row) =>
        row.where((c) => c.displayId == card.displayId).toList().isNotEmpty);
    int colIndex = selectedCards[rowIndex]
        .indexWhere((c) => c.displayId == card.displayId);

    var angle = _selectedCards[rowIndex][colIndex].rotationAngle;
    angle = (angle + pi / 2) % (2 * pi);
    var size = _selectedCards[rowIndex][colIndex].imageSize;
    _selectedCards[rowIndex][colIndex] = _selectedCards[rowIndex][colIndex]
        .copyWith(rotationAngle: angle, imageSize: size.flipped);
    notifyListeners();
  }

  void removeCard(CardInfoHeader card) {
    int rowIndex = selectedCards.indexWhere((row) =>
        row.where((c) => c.displayId == card.displayId).toList().isNotEmpty);
    int colIndex = selectedCards[rowIndex]
        .indexWhere((c) => c.displayId == card.displayId);

    _selectedCards[rowIndex].removeAt(colIndex);

    _selectedCards =
        _selectedCards.where((element) => element.isNotEmpty).toList();

    notifyListeners();
  }

  void moveCard(Map<String, int> from, Map<String, int> to) {
    List<List<CardInfoHeader>> copy =
        _selectedCards.map((row) => <CardInfoHeader>[]).toList();

    if (!from.containsKey("row") || !from.containsKey("col")) {
      throw Exception();
    }

    if (!to.containsKey("row") || !to.containsKey("col")) {
      throw Exception();
    }

    int fromRow = from["row"]!;
    int fromCol = from["col"]!;
    int toRow = to["row"]!;
    int toCol = to["col"]!;

    if (fromCol < 0 ||
        toCol < 0 ||
        fromRow < 0 ||
        toRow < 0 ||
        fromRow >= _selectedCards.length ||
        toRow > _selectedCards.length ||
        fromCol >= _selectedCards[fromRow].length) {
      return;
    }

    if (fromCol == toCol && fromRow == toRow) {
      return;
    }

    //同じ行の場合
    if (fromRow == toRow) {
      int row = fromRow;

      if (fromCol > toCol) {
        //右から左へ
        copy[row].addAll(_selectedCards[row].sublist(0, toCol));
        copy[row].add(_selectedCards[row][fromCol]);
        copy[row].addAll(_selectedCards[row].sublist(toCol, fromCol));
        copy[row].addAll(_selectedCards[row].sublist(fromCol + 1));
      } else {
        //左から右へ
        copy[row].insertAll(0, _selectedCards[row].sublist(toCol + 1));
        copy[row].insert(0, _selectedCards[row][fromCol]);
        copy[row]
            .insertAll(0, _selectedCards[row].sublist(fromCol + 1, toCol + 1));
        copy[row].insertAll(0, _selectedCards[row].sublist(0, fromCol));
      }
    } else if (toRow == _selectedCards.length) {
      copy.add([]);
      copy[toRow].add(_selectedCards[fromRow][fromCol]);

      copy[fromRow].addAll(_selectedCards[fromRow].sublist(0, fromCol));
      copy[fromRow].addAll(_selectedCards[fromRow].sublist(fromCol + 1));
    } else {
      copy[toRow].addAll(_selectedCards[toRow].sublist(0, toCol));
      copy[toRow].add(_selectedCards[fromRow][fromCol]);
      copy[toRow].addAll(_selectedCards[toRow].sublist(toCol));

      copy[fromRow].addAll(_selectedCards[fromRow].sublist(0, fromCol));
      copy[fromRow].addAll(_selectedCards[fromRow].sublist(fromCol + 1));
    }

    for (var i = 0; i < _selectedCards.length; i++) {
      if (i != fromRow && i != toRow) {
        copy[i].addAll(_selectedCards[i]);
      }
    }

    _selectedCards = copy;
    _removeEmptyRow();
    notifyListeners();
  }

  void _removeEmptyRow() {
    _selectedCards =
        _selectedCards.where((element) => element.isNotEmpty).toList();
  }

  double getMatrixRowWidth(int row) {
    if (row < 0 || row >= _selectedCards.length) {
      return 0;
    }
    return _selectedCards[row].fold<double>(
        0, (previousValue, element) => previousValue + element.imageSize.width);
  }

  double getMatrixRowHeight(int row) {
    if (row < 0 || row >= _selectedCards.length) {
      return 0;
    }
    return _selectedCards[row].fold<double>(
        0,
        (previous, e) => previous =
            (previous < e.imageSize.height ? e.imageSize.height : previous));
  }

  double getMatrixWidth() {
    var rows = _selectedCards
        .asMap()
        .entries
        .map((e) => getMatrixRowWidth(e.key))
        .toList();
    if (rows.isEmpty) {
      return 0;
    }
    return rows.fold(0, max);
  }

  double getMatrixHeight() {
    return _selectedCards.asMap().entries.fold(
        0,
        (previousValue, element) =>
            previousValue + getMatrixRowHeight(element.key));
  }

  Future<void> copyImageToClipBoard(Locale locale,
      {Function? callback, Function()? error}) async {
    var fetch = FetchCardImagesUsecase();
    var merge = MergeCardImageUseCase();
    var copy = CopyImageToClipboardUsecase();

    try {
      _selectedCards = await fetch.call(_selectedCards, locale);
      ui.Image image =
          await merge.call(_selectedCards, getMatrixWidth(), getMatrixHeight());
      await copy.call(image);
      if (callback != null) {
        callback();
      }
    } catch (e) {
      if (error != null) {
        error();
      }
    }
  }

  Future<void> downloadImage(Locale locale,
      {Function? callback, Function? error}) async {
    var fetch = FetchCardImagesUsecase();
    var merge = MergeCardImageUseCase();
    var download = DownloadImageUsecase();

    try {
      _selectedCards = await fetch.call(_selectedCards, locale);
      ui.Image image =
          await merge.call(_selectedCards, getMatrixWidth(), getMatrixHeight());
      await download.call(image);
      if (callback != null) {
        callback();
      }
    } catch (e) {
      if (error != null) {
        error();
      }
    }
  }
}
