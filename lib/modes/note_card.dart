import 'package:flutter/material.dart';
import '../modes/note.dart'; // Import the Note class

class NotesCard extends StatelessWidget {
  final Note note;

  const NotesCard(this.note, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Text(
          note.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          note.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
