import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_manga_app/providers/settings_provider.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/anime_detail_screen.dart';
import 'screens/manga_detail_screen.dart';
import 'models/anime.dart';
import 'models/manga.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  final darkMode = prefs.getBool('darkMode') ?? false;
  final fontSize = prefs.getDouble('fontSize') ?? 16.0;

  runApp(
    ProviderScope(
      overrides: [
        darkModeProvider.overrideWithProvider(StateProvider<bool>((ref) => darkMode)),
        fontSizeProvider.overrideWithProvider(StateProvider<double>((ref) => fontSize)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    final fontSize = ref.watch(fontSizeProvider);

    return MaterialApp(
      title: 'Anime/Manga App',
      theme: darkMode ? ThemeData.dark() : ThemeData.light(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/anime_detail') {
          final anime = settings.arguments as Anime?;
          if (anime != null) {
            return MaterialPageRoute(
              builder: (context) => AnimeDetailScreen(anime: anime),
            );
          } else {
            return MaterialPageRoute(
              builder: (context) => DefaultErrorScreen(message: 'Anime data not found'),
            );
          }
        } else if (settings.name == '/manga_detail') {
          final manga = settings.arguments as Manga?;
          if (manga != null) {
            return MaterialPageRoute(
              builder: (context) => MangaDetailScreen(manga: manga),
            );
          } else {
            return MaterialPageRoute(
              builder: (context) => DefaultErrorScreen(message: 'Manga data not found'),
            );
          }
        }
        return null;
      },
      routes: {
        '/': (context) => LoginScreen(),
      },
    );
  }
}

class DefaultErrorScreen extends StatelessWidget {
  final String message;

  DefaultErrorScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}