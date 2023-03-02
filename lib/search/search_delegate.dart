import 'package:fl_movies_app/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie_model.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  //Searchfield label
  String? get searchFieldLabel => 'Buscar serie/película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    //Action buttons
    return [
      IconButton(
          onPressed: (){
            query = '';
          },
          icon: const Icon(Icons.clear)
      ),

    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //Leading action button
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  Widget _emptyContainer(){
    return const Center(
      child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130,),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty){
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.searchMovies(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot){

        if(!snapshot.hasData) return _emptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
            itemBuilder: (_, int index) => _MovieItem(movie: movies[index])
        );
      },
    );
  }

}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem({
    Key? key,
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: const AssetImage('assets/no-image.jpg'),
        image: NetworkImage(movie.fullPosterUrl),
        width: 50,
        fit: BoxFit.contain,
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: (){
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
