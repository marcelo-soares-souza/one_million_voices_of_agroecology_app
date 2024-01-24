class Location {
  final int id;
  final String name;
  final String country;
  final String farmAndFarmingSystem;
  final String farmAndFarmingSystemComplement;
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
    required this.farmAndFarmingSystemComplement,
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
      name: json['name'].toString(),
      country: json['country'].toString(),
      farmAndFarmingSystem: json['farm_and_farming_system'].toString(),
      farmAndFarmingSystemComplement:
          json['farm_and_farming_system_complement'].toString(),
      description: json['description'].toString(),
      latitude: json['latitude'].toString(),
      longitude: json['longitude'].toString(),
      responsibleForInformation: json['responsible_for_information'].toString(),
      url: json['url'].toString(),
      imageUrl: json['image_url'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
    );
  }
}
