import 'package:fl_movies_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cartelera'),
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
          children: const [
            //CardSwipe
            CardSwiper(),
            //Movie slider
            MovieSlider()
          ],
        ),
      ),
    );
  }
}
