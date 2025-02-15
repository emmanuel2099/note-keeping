class Note {
  late final String title;
  late final String description;
  final String date;

  Note({
    required this.title,
    required this.description,
    required this.date,
  });

  // Convert a Note into a Map (for saving)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
    };
  }

  // Convert a Map into a Note (for loading)
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'],
      description: map['description'],
      date: map['date'],
    );
  }
}
