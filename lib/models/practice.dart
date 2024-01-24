class Practice {
  int id;
  String name;
  String summaryDescription;
  String location;
  String responsibleForInformation;
  String url;
  String imageUrl;
  String createdAt;
  String updatedAt;

  Practice({
    required this.id,
    required this.name,
    required this.summaryDescription,
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
      name: json['name'].toString(),
      summaryDescription: json['summary_description'].toString(),
      location: json['location'].toString(),
      responsibleForInformation: json['responsible_for_information'].toString(),
      url: json['url'].toString(),
      imageUrl: json['image_url'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
    );
  }
}
