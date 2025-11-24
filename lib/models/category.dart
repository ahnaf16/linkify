class Category {
  const Category({required this.id, required this.name, required this.createdAt});

  final String id;
  final String name;
  final DateTime createdAt;

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(id: map['id'], name: map['name'], createdAt: DateTime.parse(map['createdAt']));
  }

  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'createdAt': createdAt.toIso8601String()};

  Category copyWith({String? id, String? name, DateTime? createdAt}) {
    return Category(id: id ?? this.id, name: name ?? this.name, createdAt: createdAt ?? this.createdAt);
  }
}
