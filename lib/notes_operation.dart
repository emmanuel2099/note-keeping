import 'package:flutter/material.dart';
import 'note.dart';

class NotesOperation extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get getNotes => _notes;

  void addNewNote(String title, String description) {
    final currentDateTime = DateTime.now().toString();
    final note = Note(
      title: title,
      description: description,
      date: currentDateTime,
    );
    _notes.add(note);
    notifyListeners();
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  void restoreNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }
}
