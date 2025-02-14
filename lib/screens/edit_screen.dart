// edit_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modes/note.dart';
import '../widget/notes_operation.dart';

class EditScreen extends StatefulWidget {
  final Note note;

  EditScreen(this.note);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
 late TextEditingController _titleController;
 late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _descriptionController = TextEditingController(text: widget.note.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Update the note and go back
                Provider.of<NotesOperation>(context, listen: false)
                    .updateNote(widget.note, _titleController.text, _descriptionController.text);
                Navigator.pop(context);
              },
              child: Text('Save Changes',
                style: TextStyle(
                  color: Colors.white,
                ),

              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
