class Urls {
  static const _baseUrl = 'https://api.themoviedb.org/3';
  static const movieUrl = '$_baseUrl/movie';
  static const searchMovieUrl = '$_baseUrl/search/movie';

  // Image
  static const _baseImageUrl = 'https://image.tmdb.org/t/p';
  static const originalImagePath = '$_baseImageUrl/original';
  static const w780ImagePath = '$_baseImageUrl/w780';
  static const w500ImagePath = '$_baseImageUrl/w500';
  static const w342ImagePath = '$_baseImageUrl/w342';

  // genres
  static const genresListPath = '$_baseUrl/genre/movie/list';

  // movies by genre
  static const moviesByGenresPath = '$_baseUrl/discover/movie';

  // trending movie of week
  static const moviesTrendingPath = '$_baseUrl/trending/movie/week';

  // cast detail
  static const castDetailPath = '$_baseUrl/person';
}
