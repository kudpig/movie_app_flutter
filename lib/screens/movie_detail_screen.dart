import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieDetailScreen extends StatelessWidget {
  static const routeName = 'movie_detail_screen';

  var _id;
  var _title;
  var _imageUrl;
  var _overview;
  var _releaseDate;
  var _status;
  var _voteAverage;


  Future _fetchDetail(String id) async {

    String apiKey = 'APIKEY';
    String language = 'ja-JP';

    final response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/movie/$id?api_key=$apiKey&language=$language'));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      _id = result['id'];
      _title = result['title'];
      final posterPath = result['poster_path'];
      _imageUrl = 'https://image.tmdb.org/t/p/w200$posterPath';
      _overview = result['overview'];
      _releaseDate = result['release_date'];
      _status = result['status'];
      _voteAverage = result['vote_average'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final _movieId = ModalRoute.of(context)!.settings.arguments.toString();

    return FutureBuilder(
      future: _fetchDetail(_movieId),
      builder: (context, data) {
        while (_id == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(_title),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      width: 200,
                      child: Image.network(
                        _imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.white,
                            child: LayoutBuilder(builder: (context, constraints) {
                              return Icon(
                                Icons.error,
                                color: Colors.red,
                                size: constraints.biggest.width,
                              );
                            }),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        CircleAvatar(
                          backgroundColor: const Color(0xFFFFC400),
                          child: Text(double.parse(_voteAverage.toString())
                              .toStringAsFixed(1),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          '公開日 :',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(_releaseDate.toString()),
                        const SizedBox(height: 10),
                        Text(_status.toString()),
                        const SizedBox(height: 20),
                      ],
                    ),

                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    _overview,
                    style: const TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      wordSpacing: 1.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
