class Movie {
  int id;
  String title;
  String posterPath;
  // 以下詳細ページ用
  String overview;
  String releaseDate;
  num voteAverage;


  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
  });

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$posterPath';

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'],
    );
  }
}