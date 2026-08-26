class Pharmacy {
  final String id;
  final String name;
  final String? address;
  final double? latitude;
  final double? longitude;

  Pharmacy({
    required this.id,
    required this.name,
    this.address,
    this.latitude,
    this.longitude,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'],
      latitude:
          json['latitude'] != null
              ? (json['latitude'] as num).toDouble()
              : null,
      longitude:
          json['longitude'] != null
              ? (json['longitude'] as num).toDouble()
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
