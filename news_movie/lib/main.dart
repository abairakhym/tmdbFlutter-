import 'package:flutter/material.dart';
import 'package:news_movie/movie_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Movie List Demo',
      home: MovieList(),
    );
  }
}
