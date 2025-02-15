import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const SettingsScreen({
    Key? key,
    required this.onThemeChanged,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListTile(
        title: Text('Dark Mode'),
        trailing: Switch(
          value: _isDarkMode,
          onChanged: (value) {
            setState(() {
              _isDarkMode = value;
              widget.onThemeChanged(value);
            });
          },
        ),
      ),
    );
  }
}
