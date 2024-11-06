import 'package:dio/dio.dart';
import 'package:pokemon_card_collector/models/set.dart';

import '../api/web_utils.dart';
import '../utils/utils.dart';

class SetsServices{
  late Dio _dio;
  final String _baseUrl = Utils.baseUrl;

  SetsServices() {
    init();
  }

  void init() {
    _dio = WebUtil.createDio();
  }

  Stream<List<PokemonCardSet>> searchSet(String setName) async* {
    List<PokemonCardSet> sets = [];
    int page = 1;

    while (page < 6) {
      try {
        final response = await _dio.get(
          '$_baseUrl/sets',
          queryParameters: {
            'q': 'name:$setName*',
            'pageSize': 5,
            'page': page,
          },
        );
        if (response.statusCode == 200) {
          for (var set in response.data['data']) {
            sets.add(PokemonCardSet.fromJson(set as Map<String, dynamic>));
          }

          yield sets;
        } else {
          throw Exception('Error: Failed to load cards (Status Code: ${response.statusCode})');
        }
      } catch (e) {
        yield* Stream.error('Failed to load sets: $e');
        return;
      }
      page += 1;
    }
  }

  Stream<List<PokemonCardSet>> newestSets() async* {
    List<PokemonCardSet> sets = [];
    int page = 1;

    while (page < 10) {
      try {
        final response = await _dio.get(
          '$_baseUrl/sets',
          queryParameters: {
            'q': 'releaseDate:2023*',
            'pageSize': 5,
            'page': page,
          },
        );
        if (response.statusCode == 200) {
          for (var set in response.data['data']) {
            sets.add(PokemonCardSet.fromJson(set as Map<String, dynamic>));
          }

          yield sets;
        } else {
          throw Exception('Error: Failed to load cards (Status Code: ${response.statusCode})');
        }
      } catch (e) {
        yield* Stream.error('Failed to load sets: $e');
        return;
      }
      page += 1;
    }
  }
}