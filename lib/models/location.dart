class Location {
  int id;
  String name;
  String country;
  String countryCode;
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
  String base64Image;
  int accountId;
  bool hasPermission;

  Location({
    required this.id,
    required this.name,
    required this.country,
    required this.countryCode,
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
    required this.accountId,
  })  : base64Image = '',
        hasPermission = false,
        createdAt = '',
        updatedAt = '';

  static Location initLocation() {
    return Location(
      id: 0,
      name: '',
      country: 'BR',
      countryCode: 'BR',
      isItAFarm: 'true',
      farmAndFarmingSystemComplement: '',
      farmAndFarmingSystem: 'Mainly Home Consumption',
      farmAndFarmingSystemDetails: '',
      whatIsYourDream: '',
      imageUrl: '',
      description: '',
      hideMyLocation: 'false',
      latitude: '-15.75',
      longitude: '-47.89',
      responsibleForInformation: '',
      url: '',
      accountId: 0,
    );
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'].toString(),
      country: json['country'].toString(),
      countryCode: json['country_code'].toString(),
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
      accountId: json['account_id'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'id': id,
      'name': name,
      'country': country,
      'country_code': countryCode,
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
    };

    if (base64Image.isNotEmpty) {
      json['base64Image'] = base64Image;
    }

    return json;
  }
}
