import 'dart:convert';

import 'package:fl_movies_app/models/now_playing_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  String _apiKey = '452078a8d5266efd51d6dbbb47528b11';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-MX';

  List<Movie> onDisplayMovies = [];

  MoviesProvider() {
    if (kDebugMode) {
      print('Initialization');
    }

    getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1'
    });
    
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingRep.fromJson(jsonDecode(response.body));

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }
}
