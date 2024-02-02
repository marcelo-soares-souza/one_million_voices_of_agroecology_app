class GalleryItem {
  String description;
  String imageUrl;
  String locationId;
  String base64Image;

  GalleryItem({
    required this.description,
    required this.imageUrl,
  })  : base64Image = '',
        locationId = '';

  factory GalleryItem.fromJson(Map<String, dynamic> json) {
    return GalleryItem(
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }

  static GalleryItem initGalleryItem() {
    return GalleryItem(
      description: '',
      imageUrl: '',
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
