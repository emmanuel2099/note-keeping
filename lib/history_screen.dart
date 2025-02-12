import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notes_operation.dart';
import 'note.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note History'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Consumer<NotesOperation>(
        builder: (context, NotesOperation data, child) {
          if (data.getNotes.isEmpty) {
            return Center(
              child: Text(
                'No notes in history',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: data.getNotes.length,
            itemBuilder: (context, index) {
              final note = data.getNotes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.date),
              );
            },
          );
        },
      ),
    );
  }
}
