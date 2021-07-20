import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:td_movie/domain/model/genres.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/extension/string_ext.dart';
import 'package:td_movie/platform/services/api/response/movie_list.dart';
import 'package:td_movie/platform/services/api/urls.dart';

class Api {
  Api({
    Dio dio,
  }) : this.dio = dio ?? Dio() {
    this.dio
      ..interceptors.add(LogInterceptor())
      ..options.queryParameters.addAll(
        {'api_key': dotenv.env['API_KEY']},
      );
  }

  final Dio dio;

  Future<List<Movie>> getMovies(String type, [int page = 1]) async {
    var response;
    if (type == 'Trending') {
      response = await dio
          .get('${Urls.moviesTrendingPath}', queryParameters: {'page': page});
    } else {
      response = await dio.get(
        '${Urls.movieUrl}/${type.toLowerCaseUnderScore()}',
        queryParameters: {'page': page},
      );
    }
    final movies = MovieList.fromJson(response.data).movies;
    return movies;
  }

  Future<Movie> getMovieDetail(int id) async {
    final response = await dio.get(
      '${Urls.movieUrl}/$id',
      queryParameters: {'append_to_response': 'videos,credits'},
    );
    final movie = Movie.fromJson(response.data);
    return movie;
  }

  Future<Credits> getMovieCredits(int id) async {
    final response = await dio.get('${Urls.movieUrl}/$id/credits');
    final credits = Credits.fromJson(response.data);
    return credits;
  }

  Future<List<Genre>> getGenres() async {
    final response = await dio.get('${Urls.genresListPath}');
    final genres = Genres.fromJson(response.data).genres;
    return genres;
  }

  Future<MovieList> getMovieListByGenre(int genreId, {int page = 1}) async {
    final response = await dio.get(
      Urls.moviesByGenresPath,
      queryParameters: {'with_genres': genreId, 'page': page},
    );
    final movieList = MovieList.fromJson(response.data);
    movieList.genreId = genreId;
    return movieList;
  }

  Future<MovieList> getMovieListByType(String type, {int page = 1}) async {
    var response;
    if (type == 'Trending') {
      response = await dio
          .get('${Urls.moviesTrendingPath}', queryParameters: {'page': page});
    } else {
      response = await dio.get(
        '${Urls.movieUrl}/${type.toLowerCaseUnderScore()}',
        queryParameters: {'page': page},
      );
    }
    return MovieList.fromJson(response.data);
  }

  Future<MovieList> searchMovies(String query, [int page = 1]) async {
    final response = await dio.get('${Urls.searchMovieUrl}',
        queryParameters: {'query': query, 'page': page});
    final movieList = MovieList.fromJson(response.data);
    return movieList;
  }

  Future<Cast> getCastDetail(int id) async {
    final response = await dio.get('${Urls.castDetailPath}/$id');
    final cast = Cast.fromJson(response.data);
    return cast;
  }
}
