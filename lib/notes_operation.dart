import 'package:flutter/material.dart';
import 'note.dart';

class NotesOperation extends ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get getNotes => _notes;

  void addNewNote(String title, String description) {
    Note newNote = Note(title: title, description: description, date: DateTime.now().toString());
    _notes.add(newNote);
    notifyListeners();
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  // Add this updateNote() method
  void updateNote(Note oldNote, String newTitle, String newDescription) {
    int index = _notes.indexOf(oldNote);
    if (index != -1) {
      _notes[index] = Note(
        title: newTitle,
        description: newDescription,
        date: DateTime.now().toString(),
      );
      notifyListeners(); // Notify listeners to refresh UI
    }
  }
}
