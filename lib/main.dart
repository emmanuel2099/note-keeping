import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Import provider package
import 'package:task_manager/screens/home_screen.dart';
import 'package:task_manager/widget/notes_operation.dart'; // Import NotesOperation
import 'modes/lightmode_dackmode.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false; // Default theme is light mode

  // Toggle theme mode
  void _toggleTheme(bool isDark) {
    setState(() {
      isDarkMode = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesOperation(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: isDarkMode ? darkTheme : lightTheme,
        home: HomeScreen(onThemeChanged: _toggleTheme, isDarkMode: isDarkMode),
      ),
    );
  }
}
