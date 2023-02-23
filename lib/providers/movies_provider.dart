import 'dart:convert';

import 'package:fl_movies_app/models/models.dart';
import 'package:fl_movies_app/models/now_playing_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '452078a8d5266efd51d6dbbb47528b11';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-MX';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _popularPage = 0;

  MoviesProvider() {
    if (kDebugMode) {
      print('MoviesProvider inicializado');
    }

    getOnDisplayMovies();
    getPopularMovies();
  }

  //Aqui colocamos los elementos de la petición para reutilizarlo cuando sea necesario
  //El parametro entre [] es opcional.
  
  Future<String> _getJsonData(String endpoint, [int page = 1]) async{
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page'
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingRep.fromJson(jsonDecode(jsonData));

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {

    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonDecode(jsonData));

    //Esta linea de abajo indica que se agregaran las peliculas al final del contenido actual de la lista
    popularMovies = [ ...popularMovies, ...popularResponse.results ];

    if (kDebugMode) {
      print(popularMovies);
    }

    notifyListeners();
  }

}
