import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_manga_app/models/anime.dart';
import 'package:anime_manga_app/models/manga.dart';

final favoritesProvider = StreamProvider<List<dynamic>>((ref) {
  final firestore = FirebaseFirestore.instance;
  return firestore.collection('favorites').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      if (doc['type'] == 'anime') {
        return Anime(
          id: doc['id'],
          title: doc['title'],
          imageUrl: doc['imageUrl'],
          synopsis: doc['synopsis'],
        );
      } else {
        return Manga(
          id: doc['id'],
          title: doc['title'],
          imageUrl: doc['imageUrl'],
          synopsis: doc['synopsis'],
        );
      }
    }).toList();
  });
});

final addToFavoritesProvider = Provider<void Function(dynamic item)>((ref) {
  final firestore = FirebaseFirestore.instance;

  return (item) async {
    await firestore.collection('favorites').add({
      'id': item.id,
      'title': item.title,
      'imageUrl': item.imageUrl,
      'synopsis': item.synopsis,
      'type': item is Anime ? 'anime' : 'manga',
    });
  };
});

final removeFromFavoritesProvider = Provider<void Function(dynamic item)>((ref) {
  final firestore = FirebaseFirestore.instance;

  return (item) async {
    await firestore
        .collection('favorites')
        .where('id', isEqualTo: item.id)
        .where('type', isEqualTo: item is Anime ? 'anime' : 'manga')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  };
});