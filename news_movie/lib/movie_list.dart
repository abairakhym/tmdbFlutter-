import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detail_movie.dart';

class MovieList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  List trendingmovies = [];

  @override
  Widget build(BuildContext context) {
    _fetchMovies();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.6,
        title: Text(
          'Movies',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
            itemCount: trendingmovies == null ? 0 : trendingmovies.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detail(
                                  name: trendingmovies[index]['title'],
                                  bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                      trendingmovies[index]['backdrop_path'],
                                  posterurl: 'https://image.tmdb.org/t/p/w500' +
                                      trendingmovies[index]['poster_path'],
                                  description: trendingmovies[index]
                                      ['overview'],
                                  vote: trendingmovies[index]['vote_average']
                                      .toString(),
                                  launch_on: trendingmovies[index]
                                      ['release_date'],
                                )));
                  },
                  child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        child: Container(width: 80, height: 80),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500/' +
                                      trendingmovies[index]['poster_path']),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Column(
                        children: [
                          Text(
                            trendingmovies[index]['title'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Padding(padding: const EdgeInsets.all(2)),
                          Text(
                            trendingmovies[index]['overview'],
                            maxLines: 3,
                            style: TextStyle(color: const Color(0xff8785A4)),
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ))
                  ]));
            }),
      ),
    );
  }

  Future<Map> _getMoviesJson() async {
    const apiKey = '64dd5fbe2a0241ba5b8c174482243af2';
    const url = "http://api.themoviedb.org/3/discover/movie?api_key=$apiKey";
    http.Response response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  void _fetchMovies() async {
    var data = await _getMoviesJson();
    setState(() {
      trendingmovies = data['results'];
    });
  }
}
