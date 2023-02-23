import 'package:fl_movies_app/models/models.dart';
import 'package:flutter/material.dart';

class MovieSlider extends StatelessWidget {

  final String? title;
  final List<Movie> movieList;

  const MovieSlider({
    Key? key,
    this.title,
    required this.movieList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title!,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

          const SizedBox(height: 5,),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: movieList.length,
                itemBuilder: (_, int index) => _MoviePoster(movieInfo: movieList[index],)
            ),
          )
        ],
      ),
    );
  }
}

//Elementos de la lista de posters
class _MoviePoster extends StatelessWidget {

  final Movie movieInfo;

  const _MoviePoster({
    Key? key,
    required this.movieInfo
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      //color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movieInfo.fullPosterUrl),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 5,),

          Text(
            movieInfo.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
