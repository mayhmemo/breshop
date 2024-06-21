class Item {
  final int? id;
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final int categoryId;
  final String size;
  final String condition;

  Item({
    this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.categoryId,
    required this.size,
    required this.condition,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imagePath: map['imagePath'],
      price: map['price'],
      categoryId: map['categoryId'],
      size: map['size'],
      condition: map['condition'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'price': price,
      'categoryId': categoryId,
      'size': size,
      'condition': condition,
    };
  }
}
