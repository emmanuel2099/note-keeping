class Note {
  late final String title;
  late final String description;
  final String date;

  Note({
    required this.title,
    required this.description,
    required this.date,
  });

  // Convert a Note into a Map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
    };
  }

  // Convert a Map into a Note
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'],
      description: json['description'],
      date: json['date'],
    );
  }
}
