/// * The product identifier is an important concept and can have its own type.
typedef ProductID = String;

/// Class representing a product.
class Product {
  const Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.availableQuantity,
    this.avgRating = 0,
    this.numRatings = 0,
  });

  /// Unique product id
  final ProductID id;
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final int availableQuantity;
  final double avgRating;
  final int numRatings;

  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0.0,
      availableQuantity: json['availableQuantity']?.toInt() ?? 0,
      avgRating: json['avgRating']?.toDouble() ?? 0.0,
      numRatings: json['numRatings'].toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'price': price,
      'availableQuantity': availableQuantity,
      'avgRating': avgRating,
      'numRatings': numRatings,
    };
  }

  @override
  String toString() {
    return 'Product{id: $id, imageUrl: $imageUrl, title: $title, description: $description, price: $price, availableQuantity: $availableQuantity, avgRating: $avgRating, numRatings: $numRatings}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          imageUrl == other.imageUrl &&
          title == other.title &&
          description == other.description &&
          price == other.price &&
          availableQuantity == other.availableQuantity &&
          avgRating == other.avgRating &&
          numRatings == other.numRatings;

  @override
  int get hashCode =>
      id.hashCode ^
      imageUrl.hashCode ^
      title.hashCode ^
      description.hashCode ^
      price.hashCode ^
      availableQuantity.hashCode ^
      avgRating.hashCode ^
      numRatings.hashCode;

  Product copyWith({
    ProductID? id,
    String? imageUrl,
    String? title,
    String? description,
    double? price,
    int? availableQuantity,
    double? avgRating,
    int? numRatings,
  }) {
    return Product(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      avgRating: avgRating ?? this.avgRating,
      numRatings: numRatings ?? this.numRatings,
    );
  }
}
