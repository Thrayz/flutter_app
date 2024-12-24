import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_manga_app/providers/anime_provider.dart';

class MangaList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mangaList = ref.watch(mangaListProvider);

    return mangaList.when(
      data: (mangas) {
        return ListView.builder(
          itemCount: mangas.length,
          itemBuilder: (context, index) {
            final manga = mangas[index];
            return ListTile(
              leading: Image.network(manga.imageUrl),
              title: Text(manga.title),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/manga_detail',
                  arguments: manga,
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