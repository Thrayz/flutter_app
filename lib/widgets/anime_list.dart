import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_manga_app/providers/anime_provider.dart';

class AnimeList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animeList = ref.watch(animeListProvider);

    return animeList.when(
      data: (animes) {
        return ListView.builder(
          itemCount: animes.length,
          itemBuilder: (context, index) {
            final anime = animes[index];
            return ListTile(
              leading: Image.network(anime.imageUrl),
              title: Text(anime.title),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/anime_detail',
                  arguments: anime,
                );
              },
            );
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}