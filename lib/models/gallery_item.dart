class GalleryItem {
  int id;
  int accountId;
  String description;
  String imageUrl;
  String locationId;
  String createdAt;
  String updatedAt;

  String base64Image;

  GalleryItem(
      {required this.id,
      required this.description,
      required this.imageUrl,
      required this.accountId,
      required this.createdAt,
      required this.updatedAt})
      : base64Image = '',
        locationId = '';

  factory GalleryItem.fromJson(Map<String, dynamic> json) {
    return GalleryItem(
      id: json['id'],
      description: json['description'],
      imageUrl: json['image_url'],
      accountId: json['account_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  static GalleryItem initGalleryItem() {
    return GalleryItem(
      id: 0,
      description: '',
      imageUrl: '',
      accountId: 0,
      createdAt: '',
      updatedAt: '',
    );
  }

  Map<String, dynamic> toJson() {
    var json = {
      'description': description,
      'image_url': imageUrl,
    };

    if (base64Image.isNotEmpty) {
      json['base64Image'] = base64Image;
    }

    if (locationId.isNotEmpty) {
      json['location_id'] = locationId;
    }

    return json;
  }
}
