class GalleryItem {
  int id;
  int accountId;
  String description;
  String imageUrl;
  String locationId;
  String practiceId;
  String createdAt;
  String updatedAt;

  String base64Image;

  GalleryItem({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.accountId,
  })  : base64Image = '',
        locationId = '',
        practiceId = '',
        createdAt = '',
        updatedAt = '';

  factory GalleryItem.fromJson(Map<String, dynamic> json) {
    return GalleryItem(
      id: json['id'],
      description: json['description'],
      imageUrl: json['image_url'],
      accountId: json['account_id'],
    );
  }

  static GalleryItem initGalleryItem() {
    return GalleryItem(
      id: 0,
      description: '',
      imageUrl: '',
      accountId: 0,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, String> json = {
      'description': description,
      'image_url': imageUrl,
    };

    if (base64Image.isNotEmpty) {
      json['base64Image'] = base64Image;
    }

    if (locationId.isNotEmpty) {
      json['location_id'] = locationId;
    }

    if (practiceId.isNotEmpty) {
      json['practice_id'] = practiceId;
    }

    return json;
  }
}
