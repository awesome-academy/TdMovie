import 'package:flutter/cupertino.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/platform/services/api/api.dart';
import 'package:td_movie/ui/screen/home/home_view_model.dart';

class MovieRepository {
  MovieRepository({@required this.api});

  final Api api;

  Future<List<HomeViewModel>> getHomeMovies() async {
    return await Future.wait([
      _buildHomeViewModel('Trending'),
      _buildHomeViewModel('Now Playing'),
      _buildHomeViewModel('Popular'),
      _buildHomeViewModel('Top Rated'),
      _buildHomeViewModel('Upcoming'),
    ]);
  }

  Future<HomeViewModel> _buildHomeViewModel(String headerTitle) async {
    final movies = await api.getMovies(headerTitle);
    return HomeViewModel(headerTitle: headerTitle, items: movies.sublist(0, 10));
  }

  Future<MovieList> getMoviesByType(String type, {int page = 1}) =>
      api.getMovieListByType(type, page: page);

  Future<Movie> getMovieDetail(int id) async => await api.getMovieDetail(id);

  Future<Credits> getMovieCredits(int id) async =>
      await api.getMovieCredits(id);

  Future<MovieList> getMovieListByGenre(int genreId, {int page = 1}) =>
      api.getMovieListByGenre(genreId, page: page);
      
  Future<MovieList> searchMovies(String query, [int page = 1]) async =>
      await api.searchMovies(query, page);
}
