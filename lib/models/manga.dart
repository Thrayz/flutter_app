class Manga {
  final int id;
  final String title;
  final String imageUrl;
  final String synopsis;

  Manga({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.synopsis,
  });

  factory Manga.fromJson(Map<String, dynamic> json) {
    return Manga(
      id: json['mal_id'],
      title: json['title'],
      imageUrl: json['images']['jpg']['image_url'],
      synopsis: json['synopsis'],
    );
  }
}