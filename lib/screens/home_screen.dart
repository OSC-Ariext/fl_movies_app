import 'package:fl_movies_app/providers/movies_provider.dart';
import 'package:fl_movies_app/search/search_delegate.dart';
import 'package:fl_movies_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        elevation: 0,
        actions: [
          //Search function
          IconButton(
              onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: const Icon(Icons.search_outlined)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //CardSwipe
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            //Movie slider
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Populares',
              onNextPage: () => moviesProvider.getPopularMovies(),
            )
          ],
        ),
      ),
    );
  }
}
