class ProductModel {
  final int id;
  String title;
  String description;
  String category;
  double price;
  double rating;
  int stock;
  String thumbnail;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.stock,
    required this.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      stock: json['stock'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "price": price, "description": description};
  }
}
