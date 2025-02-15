import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/notes_operation.dart';

class AddScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  AddScreen({required this.onThemeChanged, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.blueGrey,
      appBar: AppBar(
        title: Text(
          'Add Note',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
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
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white54 : Colors.white,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.white : Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.white : Colors.white,
                  ),
                ),
              ),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.white,
              ),
            ),
            Expanded(
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Enter Description',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: isDarkMode ? Colors.white54 : Colors.white,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.white : Colors.white,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.white : Colors.white,
                    ),
                  ),
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: TextStyle(
                  fontSize: 18,
                  color: isDarkMode ? Colors.white : Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  Provider.of<NotesOperation>(context, listen: false)
                      .addNewNote(
                    titleController.text,
                    descriptionController.text,
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter both fields')),
                  );
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                backgroundColor: isDarkMode ? Colors.white : Colors.white,
              ),
              child: Text(
                'Add Note',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.black : Colors.blueGrey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
