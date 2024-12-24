import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:anime_manga_app/models/anime.dart';
import 'package:anime_manga_app/models/manga.dart';

Future<List<Anime>> fetchAnimeList() async {
  final response = await http.get(Uri.parse('https://api.jikan.moe/v4/top/anime'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body)['data'];
    return data.map<Anime>((json) => Anime.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load anime list');
  }
}

Future<List<Manga>> fetchMangaList() async {
  final response = await http.get(Uri.parse('https://api.jikan.moe/v4/top/manga'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body)['data'];
    return data.map<Manga>((json) => Manga.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load manga list');
  }
}

Future<List<Anime>> fetchAnimeListByQuery(String query) async {
  final response = await http.get(Uri.parse('https://api.jikan.moe/v4/anime?q=$query'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body)['data'];
    return data.map<Anime>((json) => Anime.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load search results');
  }
}

Future<List<Manga>> fetchMangaListByQuery(String query) async {
  final response = await http.get(Uri.parse('https://api.jikan.moe/v4/manga?q=$query'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body)['data'];
    return data.map<Manga>((json) => Manga.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load search results');
  }
}