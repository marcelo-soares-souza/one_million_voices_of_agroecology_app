class WhatYouDo {
  int id;
  int practiceId;
  String summaryDescriptionOfAgroecologicalPractice;
  String typeOfAgroecologicalPractice;
  String practicalImplementationOfThePractice;
  String whyYouUseAndWhatYouExpectFromThisPractice;
  String createdAt;
  String updatedAt;
  String whereItIsRealized;
  double landSize;
  String substitutionOfLessEcologicalAlternative;
  String substitutionOfLessEcologicalAlternativeDetails;
  String unitOfMeasure;

  WhatYouDo({
    required this.id,
    required this.practiceId,
    required this.summaryDescriptionOfAgroecologicalPractice,
    required this.typeOfAgroecologicalPractice,
    required this.practicalImplementationOfThePractice,
    required this.whyYouUseAndWhatYouExpectFromThisPractice,
    required this.whereItIsRealized,
    required this.landSize,
    required this.substitutionOfLessEcologicalAlternative,
    required this.substitutionOfLessEcologicalAlternativeDetails,
    required this.unitOfMeasure,
  })  : createdAt = '',
        updatedAt = '';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'practice_id': practiceId,
      'summary_description_of_agroecological_practice': summaryDescriptionOfAgroecologicalPractice,
      'type_of_agroecological_practice': typeOfAgroecologicalPractice,
      'practical_implementation_of_the_practice': practicalImplementationOfThePractice,
      'why_you_use_and_what_you_expect_from_this_practice': whyYouUseAndWhatYouExpectFromThisPractice,
      'where_it_is_realized': whereItIsRealized,
      'land_size': landSize,
      'substitution_of_less_ecological_alternative': substitutionOfLessEcologicalAlternative,
      'substitution_of_less_ecological_alternative_details': substitutionOfLessEcologicalAlternativeDetails,
      'unit_of_measure': unitOfMeasure,
    };
  }

  static WhatYouDo initWhatYouDo() {
    return WhatYouDo(
      id: 0,
      practiceId: 0,
      summaryDescriptionOfAgroecologicalPractice: '',
      typeOfAgroecologicalPractice: '',
      practicalImplementationOfThePractice: '',
      whyYouUseAndWhatYouExpectFromThisPractice: '',
      whereItIsRealized: 'On-farm',
      landSize: 0.0,
      substitutionOfLessEcologicalAlternative: 'Yes',
      substitutionOfLessEcologicalAlternativeDetails: '',
      unitOfMeasure: '',
    );
  }
}
