class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> colors;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.colors,
  });
}

class Category {
  final String name;
  final String icon;

  Category({required this.name, required this.icon});
}
