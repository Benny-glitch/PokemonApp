import 'package:dio/dio.dart';
import '../api/web_utils.dart';
import '../models/card.dart';
import '../utils/utils.dart';

class CardService {
  final Dio _dio = WebUtil.createDio();
  final String _baseUrl = Utils.baseUrl;

  Stream<List<PokemonCard>> searchCards(String name) async* {
    List<PokemonCard> cards = [];
    int page = 1;
    while(page < 6){
      try {
        final response = await _dio.get(
          '$_baseUrl/cards',
          queryParameters: {
            'q': 'name:$name*',
            'pageSize': 5,
            'page': page,
          },
        );
        for(var card in response.data['data']){
          cards.add(PokemonCard.fromJson(card as Map<String, dynamic>));
          yield cards;
        }
      }catch(e){
      }
      page += 1;
    }
  }
}
