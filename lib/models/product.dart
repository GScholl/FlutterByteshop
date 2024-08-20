class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String imagePath;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
      imagePath: map['imagePath'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'imagePath': imagePath,
    };
  }
}
