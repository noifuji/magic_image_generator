import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_image_generator/data/card_fetch_csv_api.dart';
import 'package:magic_image_generator/data/card_memory_datasource.dart';
import 'package:magic_image_generator/data/card_remote_data_source.dart';
import 'package:magic_image_generator/data/card_repository_impl.dart';
import 'package:magic_image_generator/domain/card_repository.dart';
import 'package:magic_image_generator/domain/entity/card_info_header.dart';
import 'package:magic_image_generator/domain/usecase/analyze_query_usecase.dart';

void main() {
  late CardRepository repo;

  setUpAll(() async {
    repo = CardRepositoryImpl(
        CardMemoryDataSource(), CardRemoteDataSource(CardFetchCsvApi()));
    await repo.init(onProgress: (value, task) => {});
  });

  test('Double quoted query', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('o:"you may play" set=neo'),
        const Locale("en"));
    expect(result.length, 10);
  });

  test('Only Name', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('kaito set=neo'), const Locale("en"));
    expect(result.length, 2);
  });

  test('Brackets.', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('o:"you may play" and o:until set=neo'),
        const Locale("en"));
    expect(result.length, 4);
  });

  test('Rarity equals to mythic.', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('r=mythic set=neo'), const Locale("en"));
    expect(result.length, 18);
  });

  test('Rarity is greater uncommon.', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('r>uncommon set=neo'), const Locale("en"));
    expect(result.length, 77);
  });

  test('Rarity is greater than or equals to uncommon.', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('r>=uncommon set=neo'), const Locale("en"));
    expect(result.length, 165);
  });

  test('Rarity letter is m.', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('r=m set=neo'), const Locale("en"));
    expect(result.length, 18);
  });

  test('Cmc equals to 5.', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('cmc:5 set=neo'), const Locale("en"));
    expect(result.length, 25);
  });

  test('Cmc is greater 6.', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('cmc>6 set=neo'), const Locale("en"));

    expect(result.length, 9);
  });

  test('Cmc is lesser than or equals to 2.', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('cmc<=2 set=neo'), const Locale("en"));
    expect(result.length, 131);
  });

  test('Power equals to 5.', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('pow:5 -t:enchant set=neo'),
        const Locale("en"));
    expect(result.length, 7);
  });

  test('Power is greater 6.', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('pow>6 -t:enchant set=neo'),
        const Locale("en"));
    expect(result.length, 2);
  });

  test('Power is lesser than or equals to 2.', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('pow<=2 -t:enchant set=neo'),
        const Locale("en"));
    expect(result.length, 61);
  });

  test('Multiple not type condition.', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase()
            .call('t:creature -t:enchant -t:artifact pow=4 r:c set=neo'),
        const Locale("en"));
    expect(result.length, 1);
  });

  test('Color contains red. ', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('c:red set=neo'), const Locale("en"));
    expect(result.length, 60);

    result = await repo.get(
        AnalyzeQueryUseCase().call('color:red set=neo'), const Locale("en"));
    expect(result.length, 60);
  });

  test('Search red using Color Code. ', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('c:r set=neo'), const Locale("en"));
    expect(result.length, 60);
  });

  test('Color equals red ', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('c=red set=neo'), const Locale("en"));
    expect(result.length, 43);
  });

  test('Color contains red and green using Color code. ', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('c:rg set=neo'), const Locale("en"));
    expect(result.length, 4);
  });

  test('Color contains red and green  using color code in reverse order.',
      () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('c:gr set=neo'), const Locale("en"));
    expect(result.length, 4);
  });

  test('Color contains multicolor.', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('c:m set=neo'), const Locale("en"));
    expect(result.length, 38);

    result = await repo.get(
        AnalyzeQueryUseCase().call('c:multi set=neo'), const Locale("en"));
    expect(result.length, 38);
  });

  test('Color contains colorless.', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('c:colorless set=neo'), const Locale("en"));
    expect(result.length, 29);
  });

/*  test('Search same words with operators.', () async {
    List<CardInfoHeader> result = await repo.get(
        AnalyzeQueryUseCase().call('o:"and" set=neo'), Locale("en"));
    expect(result.length, 119);

    result = await repo.get(
        AnalyzeQueryUseCase().call('o:or set=neo'), Locale("en"));
    expect(result.length, 179);

    result = await repo.get(
        AnalyzeQueryUseCase().call('o:- set=neo'), Locale("en"));
    expect(result.length, 30);

    result = await repo.get(
        AnalyzeQueryUseCase().call('o:" set=neo'), Locale("en"));
    expect(result.length, 18);
  });*/
}
