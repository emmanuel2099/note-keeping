import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modes/note.dart';

class NotesOperation extends ChangeNotifier {
  List<Note> _notes = [];

  NotesOperation() {
    loadNotes(); // Load notes on startup
  }

  List<Note> get getNotes => _notes;

  void addNewNote(String title, String description) {
    Note newNote = Note(
      title: title,
      description: description,
      date: DateTime.now().toString(),
    );
    _notes.add(newNote);
    saveNotes(); // Save notes after adding
    notifyListeners();
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    saveNotes(); // Save notes after deleting
    notifyListeners();
  }

  void updateNote(Note oldNote, String newTitle, String newDescription) {
    int index = _notes.indexOf(oldNote);
    if (index != -1) {
      _notes[index] = Note(
        title: newTitle,
        description: newDescription,
        date: DateTime.now().toString(),
      );
      saveNotes(); // Save notes after updating
      notifyListeners();
    }
  }

  void saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notesList = _notes.map((note) => jsonEncode(note.toMap())).toList();
    prefs.setStringList('notes', notesList);
  }

  void loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedNotes = prefs.getStringList('notes');
    if (savedNotes != null) {
      _notes = savedNotes.map((note) => Note.fromMap(jsonDecode(note))).toList();
      notifyListeners();
    }
  }
}
