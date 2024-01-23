class Practice {
  int id;
  String name;
  String location;
  String responsibleForInformation;
  String url;
  String imageUrl;
  String createdAt;
  String updatedAt;

  Practice({
    required this.id,
    required this.name,
    required this.location,
    required this.responsibleForInformation,
    required this.url,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Practice.fromJson(Map<String, dynamic> json) {
    return Practice(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      responsibleForInformation: json['responsible_for_information'],
      url: json['url'],
      imageUrl: json['image_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
