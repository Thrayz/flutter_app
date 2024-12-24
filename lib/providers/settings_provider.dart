import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final darkModeProvider = StateProvider<bool>((ref) {
  return false; 
});

final notificationsProvider = StateProvider<bool>((ref) {
  return true; 
});


final fontSizeProvider = StateProvider<double>((ref) {
  return 16.0; 
});

Future<void> saveSettings(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('darkMode', ref.read(darkModeProvider));
  await prefs.setBool('notifications', ref.read(notificationsProvider));
  await prefs.setDouble('fontSize', ref.read(fontSizeProvider));
}

Future<void> loadSettings(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  final darkMode = prefs.getBool('darkMode') ?? false;
  final notifications = prefs.getBool('notifications') ?? true;
  final fontSize = prefs.getDouble('fontSize') ?? 16.0;

  ref.read(darkModeProvider.notifier).state = darkMode;
  ref.read(notificationsProvider.notifier).state = notifications;
  ref.read(fontSizeProvider.notifier).state = fontSize;
}