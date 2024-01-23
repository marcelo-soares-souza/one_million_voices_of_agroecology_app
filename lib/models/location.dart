class Location {
  final int id;
  final String name;
  final String country;
  final String farmAndFarmingSystem;
  final String description;
  final String latitude;
  final String longitude;
  final String responsibleForInformation;
  final String url;
  final String imageUrl;
  final String createdAt;
  final String updatedAt;

  Location({
    required this.id,
    required this.name,
    required this.country,
    required this.farmAndFarmingSystem,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.responsibleForInformation,
    required this.url,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      farmAndFarmingSystem: json['farm_and_farming_system'],
      description: json['description'],
      latitude: json['latitude'].toString(),
      longitude: json['longitude'].toString(),
      responsibleForInformation: json['responsible_for_information'],
      url: json['url'],
      imageUrl: json['image_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
