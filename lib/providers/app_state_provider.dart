import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/anime.dart';
import '../data/dummy_data.dart';

class AppStateProvider extends ChangeNotifier {
  // Data favorit
  List<Anime> _favorites = [];
  static const String _storageKey = 'favorite_anime_list';

  // State untuk filter & pencarian
  String _selectedGenre = "All";
  String _homeSearchQuery = "";
  String _favoriteSearchQuery = "";

  AppStateProvider() {
    _loadFavorites();
  }

  // ─── Getters ────────────────────────────────────────────────
  List<Anime> get favorites => _favorites;
  String get selectedGenre => _selectedGenre;
  String get homeSearchQuery => _homeSearchQuery;
  String get favoriteSearchQuery => _favoriteSearchQuery;

  // ─── Favorite helpers ────────────────────────────────────────
  bool isFavorite(String id) {
    return _favorites.any((anime) => anime.id == id);
  }

  void toggleFavorite(Anime anime) {
    if (isFavorite(anime.id)) {
      removeFavorite(anime);
    } else {
      addFavorite(anime);
    }
  }

  void removeFavorite(Anime anime) {
    _favorites.removeWhere((item) => item.id == anime.id);
    _saveFavorites();
    notifyListeners();
  }

  void addFavorite(Anime anime) {
    if (!isFavorite(anime.id)) {
      _favorites.add(anime);
      _saveFavorites();
      notifyListeners();
    }
  }

  // ─── Filter genre ─────────────────────────────────────────────
  List<Anime> getFilteredAnimeForHome() {
    List<Anime> result = DummyData.animeList;

    // 1. Terapkan filter genre
    if (_selectedGenre != "All") {
      result = result.where((anime) {
        final genres = anime.genre.split(',').map((g) => g.trim()).toList();
        return genres.contains(_selectedGenre);
      }).toList();
    }

    // 2. Terapkan filter search
    if (_homeSearchQuery.isNotEmpty) {
      result = result.where((anime) {
        return anime.title
            .toLowerCase()
            .contains(_homeSearchQuery.toLowerCase());
      }).toList();
    }

    return result;
  }

  // ─── Filter favorit ───────────────────────────────────────────
  List<Anime> getFilteredFavorites() {
    List<Anime> result = _favorites;

    if (_favoriteSearchQuery.isNotEmpty) {
      result = result.where((anime) {
        return anime.title
            .toLowerCase()
            .contains(_favoriteSearchQuery.toLowerCase());
      }).toList();
    }

    return result;
  }

  // ─── Setters ──────────────────────────────────────────────────
  void setSelectedGenre(String genre) {
    _selectedGenre = genre;
    notifyListeners();
  }

  void setHomeSearchQuery(String query) {
    _homeSearchQuery = query;
    notifyListeners();
  }

  void setFavoriteSearchQuery(String query) {
    _favoriteSearchQuery = query;
    notifyListeners();
  }

  // ─── Persistence ──────────────────────────────────────────────
  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> favoritesJson =
          _favorites.map((anime) => anime.toJson()).toList();
      await prefs.setString(_storageKey, jsonEncode(favoritesJson));
    } catch (e) {
      debugPrint('Error saving favorites: $e');
    }
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? favoritesJson = prefs.getString(_storageKey);

      if (favoritesJson != null) {
        final List<dynamic> decoded = jsonDecode(favoritesJson);
        _favorites = decoded
            .map((item) => Anime.fromJson(item as Map<String, dynamic>))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    }
  }
}