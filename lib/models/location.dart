class Location {
  int id;
  String name;
  String country;
  String farmAndFarmingSystem;
  String farmAndFarmingSystemComplement;
  String description;
  String latitude;
  String longitude;
  String responsibleForInformation;
  String url;
  String imageUrl;
  String createdAt;
  String updatedAt;

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'farm_and_farming_system': farmAndFarmingSystem,
      'farm_and_farming_system_complement': farmAndFarmingSystemComplement,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'responsible_for_information': responsibleForInformation,
      'url': url,
      'image_url': imageUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
