import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_manga_app/providers/settings_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadSettings(ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(darkModeProvider);
    final notifications = ref.watch(notificationsProvider);
    final fontSize = ref.watch(fontSizeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
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
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Dark Mode'),
            trailing: Switch(
              value: darkMode,
              onChanged: (value) {
                ref.read(darkModeProvider.notifier).state = value;
                saveSettings(ref);
              },
            ),
          ),
          ListTile(
            title: Text('Font Size'),
            trailing: Text('${fontSize.toStringAsFixed(0)}'),
            onTap: () {
              _showFontSizeDialog(context, fontSize);
            },
          ),
        ],
      ),
    );
  }

  void _showFontSizeDialog(BuildContext context, double currentFontSize) {
    showDialog(
      context: context,
      builder: (context) {
        double newFontSize = currentFontSize;
        return AlertDialog(
          title: Text('Adjust Font Size'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Slider(
                    value: newFontSize,
                    min: 12.0,
                    max: 24.0,
                    divisions: 12,
                    onChanged: (value) {
                      setState(() {
                        newFontSize = value;
                      });
                    },
                  ),
                  Text(
                    'Font Size: ${newFontSize.toStringAsFixed(0)}',
                    style: TextStyle(fontSize: newFontSize),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(fontSizeProvider.notifier).state = newFontSize;
                saveSettings(ref);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}