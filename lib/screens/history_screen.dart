import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/notes_operation.dart';
import '../modes/note.dart';

class HistoryScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  HistoryScreen({required this.onThemeChanged, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          'Note History',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.blueGrey,
        actions: [
          // Toggle for Dark and Light Mode
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              onThemeChanged(value);
            },
            activeColor: Colors.white,
            inactiveThumbColor: Colors.black,
          ),
        ],
      ),
      body: Consumer<NotesOperation>(
        builder: (context, NotesOperation data, child) {
          if (data.getNotes.isEmpty) {
            return Center(
              child: Text(
                'No notes in history',
                style: TextStyle(
                  fontSize: 18,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: data.getNotes.length,
            itemBuilder: (context, index) {
              final note = data.getNotes[index];
              return ListTile(
                title: Text(
                  note.title,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                subtitle: Text(
                  note.date,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
