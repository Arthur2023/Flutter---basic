class Todo {
  final String title;
  final DateTime dateTime;

  const Todo({
    required this.title,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}
