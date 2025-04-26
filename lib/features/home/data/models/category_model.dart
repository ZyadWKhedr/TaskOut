// category_model.dart
class Category {
  final String id;
  final String title;
  final String description;

  Category({
    required this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}
