import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_manga_app/models/anime.dart';
import 'package:anime_manga_app/providers/favorites_provider.dart';

class AnimeDetailScreen extends ConsumerWidget {
  final Anime anime;

  AnimeDetailScreen({required this.anime});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider).value ?? [];
    final isFavorite = favorites.any((item) => item.id == anime.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          anime.title,
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
                ref.read(addToFavoritesProvider)(anime);
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
              tag: 'anime_${anime.id}',
              child: Image.network(
                anime.imageUrl,
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                anime.synopsis,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}