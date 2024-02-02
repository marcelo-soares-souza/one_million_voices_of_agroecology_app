class Location {
  int id;
  String name;
  String country;
  String isItAFarm;
  String farmAndFarmingSystemComplement;
  String farmAndFarmingSystem;
  String farmAndFarmingSystemDetails;
  String whatIsYourDream;
  String description;
  String hideMyLocation;
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
    required this.isItAFarm,
    required this.farmAndFarmingSystemComplement,
    required this.farmAndFarmingSystem,
    required this.farmAndFarmingSystemDetails,
    required this.whatIsYourDream,
    required this.imageUrl,
    required this.description,
    required this.hideMyLocation,
    required this.latitude,
    required this.longitude,
    required this.responsibleForInformation,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
  });

  static Location initLocation() {
    return Location(
      id: 0,
      name: '',
      country: 'BR',
      isItAFarm: 'true',
      farmAndFarmingSystemComplement: '',
      farmAndFarmingSystem: '',
      farmAndFarmingSystemDetails: '',
      whatIsYourDream: '',
      imageUrl: '',
      description: '',
      hideMyLocation: 'false',
      latitude: '-15.75',
      longitude: '-47.89',
      responsibleForInformation: '',
      url: '',
      createdAt: '',
      updatedAt: '',
    );
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'].toString(),
      country: json['country'].toString(),
      isItAFarm: json['is_it_a_farm'].toString(),
      farmAndFarmingSystemComplement: json['farm_and_farming_system_complement'].toString(),
      farmAndFarmingSystem: json['farm_and_farming_system'].toString(),
      farmAndFarmingSystemDetails: json['farm_and_farming_system_details'].toString(),
      whatIsYourDream: json['what_is_your_dream'].toString(),
      description: json['description'].toString(),
      hideMyLocation: json['hide_my_location'].toString(),
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
      'is_it_a_farm': isItAFarm,
      'farm_and_farming_system_complement': farmAndFarmingSystemComplement,
      'farm_and_farming_system': farmAndFarmingSystem,
      'farm_and_farming_system_details': farmAndFarmingSystemDetails,
      'what_is_your_dream': whatIsYourDream,
      'image_url': imageUrl,
      'description': description,
      'hide_my_location': hideMyLocation,
      'latitude': latitude,
      'longitude': longitude,
      'responsible_for_information': responsibleForInformation,
      'url': url,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
