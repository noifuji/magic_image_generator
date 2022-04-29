import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:magic_image_generator/data/card.dart';
import 'package:magic_image_generator/data/card_fetch_csv_api.dart';
import 'package:magic_image_generator/data/card_local_data_source.dart';
import 'package:magic_image_generator/data/card_remote_data_source.dart';
import 'package:magic_image_generator/data/card_repository_impl.dart';
import 'package:magic_image_generator/domain/analyze_query_usecase.dart';
import 'package:magic_image_generator/domain/card_repository.dart';
import 'package:magic_image_generator/model/card_info.dart';

void main() {
  late CardRepository _repo;

  setUpAll(()  async {
    Isar _isar = await Isar.open(
        schemas: [CardSchema],
        directory: Directory("${Directory.current.path}/tmp").path
    );

    await _isar.writeTxn((isar) async {
      await isar.cards.clear();
    });
    _repo = CardRepositoryImpl(CardLocalDataSource(_isar), CardRemoteDataSource(CardFetchCsvApi()));
    await _repo.init();
  });

  test('Double quoted query', () async {
    List<CardInfo> result = await _repo.get(
        AnalyzeQueryUseCase().call('o:"you may play" set:neo'), Locale("en"));
    expect(result.length, 10);
  });

  test('Only Name', () async {
    List<CardInfo> result = await _repo.get(
        AnalyzeQueryUseCase().call('kaito set:neo'), Locale("en"));
    expect(result.length, 2);
  });

  test('Brackets.', () async {
    List<CardInfo> result = await _repo.get(
        AnalyzeQueryUseCase().call('o:"you may play" and o:until set:neo'), Locale("en"));
    expect(result.length, 4);
  });

  test('Rarity equals to mythic.', () async {
    List<CardInfo> result = await _repo.get(
        AnalyzeQueryUseCase().call('r=mythic set:neo'), Locale("en"));
    expect(result.length, 18);
  });

  test('Rarity is greater uncommon.', () async {
    List<CardInfo> result = await _repo.get(
        AnalyzeQueryUseCase().call('r>uncommon set:neo'), Locale("en"));
    expect(result.length, 77);
  });

  test('Rarity is greater than or equals to uncommon.', () async {
    List<CardInfo> result = await _repo.get(
        AnalyzeQueryUseCase().call('r>=uncommon set:neo'), Locale("en"));
    expect(result.length, 165);
  });

  test('Rarity letter is m.', () async {
    List<CardInfo> result = await _repo.get(
        AnalyzeQueryUseCase().call('r=m set:neo'), Locale("en"));
    expect(result.length, 18);
  });

  test('Cmc equals to 5.', () async {
    List<CardInfo> result = await _repo.get(
        AnalyzeQueryUseCase().call('cmc:5 set:neo'), Locale("en"));
    expect(result.length, 25);
  });

  test('Cmc is greater 6.', () async {
    List<CardInfo> result = await _repo.get(
        AnalyzeQueryUseCase().call('cmc>6 set:neo'), Locale("en"));

    expect(result.length, 9);
  });

  test('Cmc is lesser than or equals to 2.', () async {
    List<CardInfo> result = await _repo.get(
        AnalyzeQueryUseCase().call('cmc<=2 set:neo'), Locale("en"));
    expect(result.length, 136);
  });

  test('Power equals to 5.', () async {
    List<CardInfo> result = await _repo.get(
        AnalyzeQueryUseCase().call('pow:5 -t:enchant set:neo'), Locale("en"));
    expect(result.length, 7);
  });

  test('Power is greater 6.', () async {
    List<CardInfo> result = await _repo.get(
        AnalyzeQueryUseCase().call('pow>6 -t:enchant set:neo'), Locale("en"));
    expect(result.length, 2);
  });

  test('Power is lesser than or equals to 2.', () async {
    List<CardInfo> result = await _repo.get(
        AnalyzeQueryUseCase().call('pow<=2 -t:enchant set:neo'), Locale("en"));
    expect(result.length, 61);
  });

  test('Multiple not type condition.', () async {
    List<CardInfo> result = await _repo.get(
        AnalyzeQueryUseCase().call('t:creature -t:enchant -t:artifact pow=4 set:neo'), Locale("en"));
    expect(result.length, 10);
  });
}