import 'package:card_swiper/card_swiper.dart';
import 'package:fl_movies_app/models/now_playing_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/movie_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwiper({
    Key? key,
    required this.movies
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if(movies.isEmpty){
      return SizedBox(
        width: double.infinity,
        height: size.height *0.5,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      //color: Colors.red,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.width * 0.9,
        itemBuilder: (_, int index) {
          
          final movie = movies[index];

          movie.heroId = 'swiper-${movie.id}';
          //Movie poster
          return GestureDetector(
            //Navigate to the detail screen
            onTap: () => Navigator.pushNamed(
                context, 'details',
                arguments: movie
            ),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
