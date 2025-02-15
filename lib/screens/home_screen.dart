import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/screens/setting_screen.dart';
import '../modes/note.dart';
import '../modes/note_detail_screen.dart';
import '../widget/notes_operation.dart';
import 'add_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  HomeScreen({required this.onThemeChanged, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.blueGrey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddScreen(
                onThemeChanged: onThemeChanged,
                isDarkMode: isDarkMode,
              ),
            ),
          );

        },
        child: Icon(Icons.add, size: 30, color: isDarkMode ? Colors.black : Colors.blueGrey),
        backgroundColor: isDarkMode ? Colors.white : Colors.white,
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
                  builder: (context) => HistoryScreen(
                    onThemeChanged: onThemeChanged,
                    isDarkMode: isDarkMode,
                  ),
                ),
              );

            },
          ),
          // Toggle Switch for Dark and Light Mode
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

      // Adding Drawer here
      drawer: Drawer(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.blueGrey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black : Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(
                      Icons.person,
                      color: Colors.blueGrey,
                      size: 40,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Note Manager',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Organize your thoughts',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.white),
              title: Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.add, color: Colors.white),
              title: Text('Add Note', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddScreen(
                      onThemeChanged: onThemeChanged,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                );

              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: Colors.white),
              title: Text('History', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryScreen(
                      onThemeChanged: onThemeChanged,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                );

              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text('Settings', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(
                      onThemeChanged: onThemeChanged,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                );
              },
            ),

          ],
        ),
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
                  color: isDarkMode ? Colors.white : Colors.black,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),

                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteDetailScreen(note),
                      ),
                    );
                  },
                  child: NotesCard(note, isDarkMode: isDarkMode),
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
  final bool isDarkMode;

  NotesCard(this.note, {required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      height: 150,
      width: 400,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 5),
          Text(
            note.date,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: Text(
              note.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(
                fontSize: 17,
                color: isDarkMode ? Colors.white70 : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
