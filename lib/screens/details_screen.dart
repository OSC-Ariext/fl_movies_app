import 'package:fl_movies_app/models/models.dart';
import 'package:fl_movies_app/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //De esta manera recivo la información desde el backstack que me envia el widget orignen
    //final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    if (kDebugMode) {
      print(movie.title);
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [

          _CustomAppBar(
            movieTitle: movie.title,
            movieBackdrop: movie.fullBackdropPath,
          ),

          SliverList(
              delegate: SliverChildListDelegate([

                _PosterAndTitle(
                    movieTitle: movie.title,
                    movieOriginalTitle: movie.originalTitle,
                    moviePoster: movie.fullPosterUrl,
                    movieRating: movie.voteAverage.toString(),
                    movie: movie,
                ),

                _Overview(movieDescription: movie.overview,),

                CastingCards(movieId: movie.id,)
              ])
          )
        ],
      ),
    );

  }
}

class _CustomAppBar extends StatelessWidget {

  final String movieTitle;
  final String movieBackdrop;

  const _CustomAppBar({
    Key? key,
    required this.movieTitle,
    required this.movieBackdrop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      elevation: 0,

      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),

        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black12,
          child: Text(
            movieTitle,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),

        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movieBackdrop),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final String movieTitle;
  final String movieOriginalTitle;
  final String moviePoster;
  final String movieRating;
  final Movie movie;


  const _PosterAndTitle({
    Key? key,
    required this.movieTitle,
    required this.movieOriginalTitle,
    required this.moviePoster,
    required this.movieRating,
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;


    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [

          //Cover images
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(moviePoster),
                height: 150,
              ),
            ),
          ),

          const SizedBox(width: 20,),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movieTitle,
                  style: textTheme.headlineSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  movieOriginalTitle,
                  style: textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                Row(
                  children: [
                    const Icon(Icons.star_outline, size: 15, color: Colors.grey,),
                    const SizedBox(width: 5,),
                    Text(
                      movieRating,
                      style: textTheme.bodySmall,
                    )
                  ],
                )
              ],
            )
            ,
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  final String movieDescription;

  const _Overview({
    Key? key,
    required this.movieDescription
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movieDescription,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}

