import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_manga_app/services/api_service.dart';
import 'package:anime_manga_app/models/anime.dart';
import 'package:anime_manga_app/models/manga.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final animeListProvider = FutureProvider<List<Anime>>((ref) async {
  return fetchAnimeList();
});

final mangaListProvider = FutureProvider<List<Manga>>((ref) async {
  return fetchMangaList();
});

final searchAnimeProvider = FutureProvider.family<List<Anime>, String>((ref, query) async {
  return fetchAnimeListByQuery(query);
});

final searchMangaProvider = FutureProvider.family<List<Manga>, String>((ref, query) async {
  return fetchMangaListByQuery(query);
});