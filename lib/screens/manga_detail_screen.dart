import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_manga_app/models/manga.dart';
import 'package:anime_manga_app/providers/favorites_provider.dart';

class MangaDetailScreen extends ConsumerWidget {
  final Manga manga;

  MangaDetailScreen({required this.manga});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider).value ?? [];
    final isFavorite = favorites.any((item) => item.id == manga.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          manga.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.deepPurple],
            ),
          ),
        ),
        actions: [
          if (!isFavorite)
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {
                ref.read(addToFavoritesProvider)(manga);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added to favorites')),
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: 'manga_${manga.id}',
              child: Image.network(
                manga.imageUrl,
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                manga.synopsis,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}