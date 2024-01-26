class Practice {
  int id;
  String name;
  String location;
  String responsibleForInformation;
  String url;
  String imageUrl;

  String whereItIsRealized;
  String summaryDescription;
  String practicalImplementationOfThePractice;
  String typeOfAgroecologicalPractice;
  String whyYouUseAndWhatYouExpectFromThisPractice;
  String landSize;
  String substitutionOfLessEcologicalAlternative;

  String agroecologyPrinciplesAddressed;
  String foodSystemComponentsAddressed;

  String createdAt;
  String updatedAt;

  Practice({
    required this.id,
    required this.name,
    required this.location,
    required this.responsibleForInformation,
    required this.url,
    required this.imageUrl,
    required this.whereItIsRealized,
    required this.summaryDescription,
    required this.practicalImplementationOfThePractice,
    required this.typeOfAgroecologicalPractice,
    required this.whyYouUseAndWhatYouExpectFromThisPractice,
    required this.landSize,
    required this.substitutionOfLessEcologicalAlternative,
    required this.agroecologyPrinciplesAddressed,
    required this.foodSystemComponentsAddressed,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Practice.fromJson(Map<String, dynamic> json) {
    return Practice(
      id: json['id'],
      name: json['name'].toString(),
      location: json['location'].toString(),
      responsibleForInformation: json['responsible_for_information'].toString(),
      url: json['url'].toString(),
      imageUrl: json['image_url'].toString(),
      whereItIsRealized: json['where_it_is_realized'].toString(),
      summaryDescription: json['summary_description'].toString(),
      practicalImplementationOfThePractice:
          json['practical_implementation_of_the_practice'].toString(),
      typeOfAgroecologicalPractice:
          json['type_of_agroecological_practice'].toString(),
      whyYouUseAndWhatYouExpectFromThisPractice:
          json['why_you_use_and_what_you_expect_from_this_practice'].toString(),
      landSize: json['land_size'].toString(),
      substitutionOfLessEcologicalAlternative:
          json['substitution_of_less_ecological_alternative'].toString(),
      agroecologyPrinciplesAddressed:
          json['agroecology_principles_addressed'].toString(),
      foodSystemComponentsAddressed:
          json['food_system_components_addressed'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
    );
  }
}
