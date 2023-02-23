import 'package:fl_movies_app/providers/movies_provider.dart';
import 'package:fl_movies_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);
    
    print(moviesProvider.onDisplayMovies);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (){},
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
              movieList: moviesProvider.popularMovies,
              title: 'Populares',
            )
          ],
        ),
      ),
    );
  }
}
