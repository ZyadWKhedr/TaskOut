class Task {
  final String id;
  final String title;
  final String description;
  final String priority;
  final String category;
  final String? imagePath;
  final bool isDone; // << Add this field

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.category,
    this.imagePath,
    this.isDone = false, // default false
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'category': category,
      'imagePath': imagePath,
      'isDone': isDone ? 1 : 0, // store as int (SQLite doesn't have bool)
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      priority: map['priority'],
      category: map['category'],
      imagePath: map['imagePath'],
      isDone: map['isDone'] == 1, // read int as bool
    );
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? priority,
    String? category,
    String? imagePath,
    bool? isDone,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      imagePath: imagePath ?? this.imagePath,
      isDone: isDone ?? this.isDone,
    );
  }
}
