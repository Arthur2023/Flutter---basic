class Todo {
  final String title;
  bool checked = false;

  Todo({
    required this.title,
    this.checked = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'checked': checked,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      checked: json['checked'],
    );
  }
}
