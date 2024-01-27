class GalleryItem {
  final String description;
  final String imageUrl;

  GalleryItem({
    required this.description,
    required this.imageUrl,
  });

  factory GalleryItem.fromJson(Map<String, dynamic> json) {
    return GalleryItem(
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }
}
