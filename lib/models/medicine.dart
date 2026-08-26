class Medicine {
  final String id;
  final String name;
  final String? description;
  final double? price;

  Medicine({
    required this.id,
    required this.name,
    this.description,
    this.price,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'price': price};
  }
}
