import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_screen.dart';
import 'edit_screen.dart';
import 'history_screen.dart';
import 'note.dart';
import 'notes_operation.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddScreen(),
            ),
          );
        },
        child: Icon(Icons.add, size: 30, color: Colors.blueGrey),
        backgroundColor: Colors.white,
      ),
      appBar: AppBar(
        title: Text(
          'Note Manager',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<NotesOperation>(
        builder: (context, NotesOperation data, child) {
          return ListView.builder(
            itemCount: data.getNotes.length,
            itemBuilder: (context, index) {
              final note = data.getNotes[index];
              return Dismissible(
                key: Key(note.title),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  final deletedNote = note;
                  data.deleteNote(note);

                  // Show SnackBar with Undo action
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Note deleted'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        // Restore the deleted note using addNewNote
                        data.addNewNote(deletedNote.title, deletedNote.description);
                      },
                    ),
                  ));
                },
                background: Container(
                  color: Colors.black,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditScreen(note), // Navigate to EditScreen
                      ),
                    );
                  },
                  child: NotesCard(note),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NotesCard extends StatelessWidget {
  final Note note;

  NotesCard(this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      height: 150,
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                note.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blueGrey),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditScreen(note), // Navigate to EditScreen
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            note.date,
            style: TextStyle(fontSize: 14, color: Colors.grey[400]),
          ),
          SizedBox(height: 5),
          Expanded(
            child: Text(
              note.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
