import 'package:flutter/material.dart';

class MoviesProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _favoriteMovies = [];
  final List<Map<String, dynamic>> _watchlistMovies = [];

  List<Map<String, dynamic>> get favoriteMovies => _favoriteMovies;
  List<Map<String, dynamic>> get watchlistMovies => _watchlistMovies;

  bool isFavorite(int id) {
    return _favoriteMovies.any((m) => m['id'] == id);
  }

  bool isInWatchlist(int id) {
    return _watchlistMovies.any((m) => m['id'] == id);
  }

  void toggleFavorite(Map<String, dynamic> movie) {
    final int id = movie['id'];
    if (isFavorite(id)) {
      _favoriteMovies.removeWhere((m) => m['id'] == id);
    } else {
      _favoriteMovies.add(movie);
    }
    notifyListeners();
  }

  void toggleWatchlist(Map<String, dynamic> movie) {
    final int id = movie['id'];
    if (isInWatchlist(id)) {
      _watchlistMovies.removeWhere((m) => m['id'] == id);
    } else {
      _watchlistMovies.add(movie);
    }
    notifyListeners();
  }
}