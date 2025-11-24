class Tag {
  const Tag({required this.id, required this.name, required this.color, required this.createdAt});

  final String id;
  final String name;
  final String color;
  final DateTime createdAt;

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(id: map['id'], name: map['name'], color: map['color'], createdAt: DateTime.parse(map['createdAt']));
  }

  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'color': color, 'createdAt': createdAt.toIso8601String()};
}
