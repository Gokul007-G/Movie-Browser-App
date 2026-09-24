import 'package:hive_flutter/hive_flutter.dart';
import 'models/favorite_movie_model.dart';



class FavoriteMovieService {
  static const String boxName = 'favorite_movies';

  Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(FavoriteMovieModelAdapter());
    }

    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<FavoriteMovieModel>(boxName);
    }
  }

  Box<FavoriteMovieModel> get _box {
    return Hive.box<FavoriteMovieModel>(boxName);
  }

  Future<void> addMovie(FavoriteMovieModel movie) async {
    await _box.put(movie.id, movie);
  }

  Future<void> removeMovie(int movieId) async {
    await _box.delete(movieId);
  }

  bool isFavorite(int movieId) {
    return _box.containsKey(movieId);
  }

  List<FavoriteMovieModel> getFavorites() {
    return _box.values.toList();
  }

  FavoriteMovieModel? getMovie(int movieId) {
    return _box.get(movieId);
  }
}