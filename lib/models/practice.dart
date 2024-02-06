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

  String generalPerformanceOfPractice;
  String unintendedPositiveSideEffectsOfPractice;
  String unintendedNegativeSideEffectOfPractice;
  String knowledgeAndSkillsRequiredForPractice;
  String labourRequiredForPractice;
  String costAssociatedWithPractice;
  String doesItWorkInDegradedEnvironments;
  String doesItHelpRestoreLand;
  String climateChangeVulnerabilityEffects;
  String timeRequirements;
  String generalPerformanceOfPracticeDetails;
  String unintendedPositiveSideEffectsOfPracticeDetails;
  String unintendedNegativeSideEffectOfPracticeDetails;
  String knowledgeAndSkillsRequiredForPracticeDetails;
  String labourRequiredForPracticeDetails;
  String costAssociatedWithPracticeDetails;
  String doesItWorkInDegradedEnvironmentsDetails;
  String doesItHelpRestoreLandDetails;
  String climateChangeVulnerabilityEffectsDetails;
  String timeRequirementsDetails;

  String knowledgeSource;
  String knowledgeTiming;
  String knowledgeProducts;
  String uptakeMotivation;
  String knowledgeSourceDetails;
  String knowledgeTimingDetails;

  String accountId;
  String locationId;
  String base64Image;
  bool hasPermission;

  String createdAt;
  String updatedAt;

  final main = {
    'Summary Description': 'summaryDescription',
    'Location': 'location',
    'Responsible for Information': 'responsibleForInformation',
  };

  final whatYouDo = {
    'Where it is realized?': 'whereItIsRealized',
    'Practical implementation of the practice': 'practicalImplementationOfThePractice',
    'Type of agroecological practice': 'typeOfAgroecologicalPractice',
    'Why you use and what you expect from this practice': 'whyYouUseAndWhatYouExpectFromThisPractice',
    'Land Size': 'landSize',
    'Substitution of less ecological alternative': 'substitutionOfLessEcologicalAlternative',
  };

  final characterises = {
    'Agroecology principles addressed': 'agroecologyPrinciplesAddressed',
    'Food system components addressed': 'foodSystemComponentsAddressed'
  };

  final evaluates = {
    'General performance of practice': 'generalPerformanceOfPractice',
    'Unintended positive side effects of practice': 'unintendedPositiveSideEffectsOfPractice',
    'Unintended negative side effect of practice': 'unintendedNegativeSideEffectOfPractice',
    'Knowledge and skills required for practice': 'knowledgeAndSkillsRequiredForPractice',
    'Labour required for practice': 'labourRequiredForPractice',
    'Cost associated with practice': 'costAssociatedWithPractice',
    'Does it work in degraded environments?': 'doesItWorkInDegradedEnvironments',
    'Does it help restore land?': 'doesItHelpRestoreLand',
    'Climate change vulnerability effects': 'climateChangeVulnerabilityEffects',
    'Time requirements': 'timeRequirements',
  };

  final acknowledges = {
    'Knowledge source': 'knowledgeSource',
    'Knowledge timing': 'knowledgeTiming',
    'Knowledge products': 'knowledgeProducts',
    'Uptake motivation': 'uptakeMotivation',
    'Knowledge source details': 'knowledgeSourceDetails',
    'Knowledge timing details': 'knowledgeTimingDetails',
  };

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
    required this.generalPerformanceOfPractice,
    required this.unintendedPositiveSideEffectsOfPractice,
    required this.unintendedNegativeSideEffectOfPractice,
    required this.knowledgeAndSkillsRequiredForPractice,
    required this.labourRequiredForPractice,
    required this.costAssociatedWithPractice,
    required this.doesItWorkInDegradedEnvironments,
    required this.doesItHelpRestoreLand,
    required this.climateChangeVulnerabilityEffects,
    required this.timeRequirements,
    required this.generalPerformanceOfPracticeDetails,
    required this.unintendedPositiveSideEffectsOfPracticeDetails,
    required this.unintendedNegativeSideEffectOfPracticeDetails,
    required this.knowledgeAndSkillsRequiredForPracticeDetails,
    required this.labourRequiredForPracticeDetails,
    required this.costAssociatedWithPracticeDetails,
    required this.doesItWorkInDegradedEnvironmentsDetails,
    required this.doesItHelpRestoreLandDetails,
    required this.climateChangeVulnerabilityEffectsDetails,
    required this.timeRequirementsDetails,
    required this.knowledgeSource,
    required this.knowledgeTiming,
    required this.knowledgeProducts,
    required this.uptakeMotivation,
    required this.knowledgeSourceDetails,
    required this.knowledgeTimingDetails,
    required this.accountId,
    required this.locationId,
    required this.createdAt,
    required this.updatedAt,
  })  : base64Image = '',
        hasPermission = false;

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
      practicalImplementationOfThePractice: json['practical_implementation_of_the_practice'].toString(),
      typeOfAgroecologicalPractice: json['type_of_agroecological_practice'].toString(),
      whyYouUseAndWhatYouExpectFromThisPractice: json['why_you_use_and_what_you_expect_from_this_practice'].toString(),
      landSize: json['land_size'].toString(),
      substitutionOfLessEcologicalAlternative: json['substitution_of_less_ecological_alternative'].toString(),
      agroecologyPrinciplesAddressed: json['agroecology_principles_addressed'].toString(),
      foodSystemComponentsAddressed: json['food_system_components_addressed'].toString(),
      generalPerformanceOfPractice: json['general_performance_of_practice'].toString(),
      unintendedPositiveSideEffectsOfPractice: json['unintended_positive_side_effects_of_practice'].toString(),
      unintendedNegativeSideEffectOfPractice: json['unintended_negative_side_effect_of_practice'].toString(),
      knowledgeAndSkillsRequiredForPractice: json['knowledge_and_skills_required_for_practice'].toString(),
      labourRequiredForPractice: json['labour_required_for_practice'].toString(),
      costAssociatedWithPractice: json['cost_associated_with_practice'].toString(),
      doesItWorkInDegradedEnvironments: json['does_it_work_in_degraded_environments'].toString(),
      doesItHelpRestoreLand: json['does_it_help_restore_land'].toString(),
      climateChangeVulnerabilityEffects: json['climate_change_vulnerability_effects'].toString(),
      timeRequirements: json['time_requirements'].toString(),
      generalPerformanceOfPracticeDetails: json['general_performance_of_practice_details'].toString(),
      unintendedPositiveSideEffectsOfPracticeDetails:
          json['unintended_positive_side_effects_of_practice_details'].toString(),
      unintendedNegativeSideEffectOfPracticeDetails:
          json['unintended_negative_side_effect_of_practice_details'].toString(),
      knowledgeAndSkillsRequiredForPracticeDetails:
          json['knowledge_and_skills_required_for_practice_details'].toString(),
      labourRequiredForPracticeDetails: json['labour_required_for_practice_details'].toString(),
      costAssociatedWithPracticeDetails: json['cost_associated_with_practice_details'].toString(),
      doesItWorkInDegradedEnvironmentsDetails: json['does_it_work_in_degraded_environments_details'].toString(),
      doesItHelpRestoreLandDetails: json['does_it_help_restore_land_details'].toString(),
      climateChangeVulnerabilityEffectsDetails: json['climate_change_vulnerability_effects_details'].toString(),
      timeRequirementsDetails: json['time_requirements_details'].toString(),
      knowledgeSource: json['knowledge_source'].toString(),
      knowledgeTiming: json['knowledge_timing'].toString(),
      knowledgeProducts: json['knowledge_products'].toString(),
      uptakeMotivation: json['uptake_motivation'].toString(),
      knowledgeSourceDetails: json['knowledge_source_details'].toString(),
      knowledgeTimingDetails: json['knowledge_timing_details'].toString(),
      locationId: json['location_id'].toString(),
      accountId: json['account_id'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    var json = {
      'id': id,
      'name': name,
      'location': location,
      'responsibleForInformation': responsibleForInformation,
      'url': url,
      'imageUrl': imageUrl,
      'whereItIsRealized': whereItIsRealized,
      'summaryDescription': summaryDescription,
      'practicalImplementationOfThePractice': practicalImplementationOfThePractice,
      'typeOfAgroecologicalPractice': typeOfAgroecologicalPractice,
      'whyYouUseAndWhatYouExpectFromThisPractice': whyYouUseAndWhatYouExpectFromThisPractice,
      'doesItHelpRestoreLand': doesItHelpRestoreLand,
      'climateChangeVulnerabilityEffects': climateChangeVulnerabilityEffects,
      'timeRequirements': timeRequirements,
      'generalPerformanceOfPracticeDetails': generalPerformanceOfPracticeDetails,
      'unintendedPositiveSideEffectsOfPracticeDetails': unintendedPositiveSideEffectsOfPracticeDetails,
      'unintendedNegativeSideEffectOfPracticeDetails': unintendedNegativeSideEffectOfPracticeDetails,
      'knowledgeAndSkillsRequiredForPracticeDetails': knowledgeAndSkillsRequiredForPracticeDetails,
      'labourRequiredForPracticeDetails': labourRequiredForPracticeDetails,
      'costAssociatedWithPracticeDetails': costAssociatedWithPracticeDetails,
      'doesItWorkInDegradedEnvironmentsDetails': doesItWorkInDegradedEnvironmentsDetails,
      'doesItHelpRestoreLandDetails': doesItHelpRestoreLandDetails,
      'climateChangeVulnerabilityEffectsDetails': climateChangeVulnerabilityEffectsDetails,
      'timeRequirementsDetails': timeRequirementsDetails,
      'knowledgeSource': knowledgeSource,
      'knowledgeTiming': knowledgeTiming,
      'knowledgeProducts': knowledgeProducts,
      'uptakeMotivation': uptakeMotivation,
      'knowledgeSourceDetails': knowledgeSourceDetails,
      'knowledgeTimingDetails': knowledgeTimingDetails,
      'account_id': int.parse(accountId),
      'location_id': int.parse(locationId),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };

    if (base64Image.isNotEmpty) {
      json['base64Image'] = base64Image;
    }

    return json;
  }

  dynamic getFieldByName(String fieldName) {
    switch (fieldName) {
      case 'id':
        return id;
      case 'name':
        return name;
      case 'location':
        return location;
      case 'responsibleForInformation':
        return responsibleForInformation;
      case 'url':
        return url;
      case 'imageUrl':
        return imageUrl;
      case 'whereItIsRealized':
        return whereItIsRealized;
      case 'summaryDescription':
        return summaryDescription;
      case 'practicalImplementationOfThePractice':
        return practicalImplementationOfThePractice;
      case 'typeOfAgroecologicalPractice':
        return typeOfAgroecologicalPractice;
      case 'whyYouUseAndWhatYouExpectFromThisPractice':
        return whyYouUseAndWhatYouExpectFromThisPractice;
      case 'landSize':
        return landSize;
      case 'substitutionOfLessEcologicalAlternative':
        return substitutionOfLessEcologicalAlternative;
      case 'agroecologyPrinciplesAddressed':
        return agroecologyPrinciplesAddressed;
      case 'foodSystemComponentsAddressed':
        return foodSystemComponentsAddressed;
      case 'generalPerformanceOfPractice':
        return generalPerformanceOfPractice;
      case 'unintendedPositiveSideEffectsOfPractice':
        return unintendedPositiveSideEffectsOfPractice;
      case 'unintendedNegativeSideEffectOfPractice':
        return unintendedNegativeSideEffectOfPractice;
      case 'knowledgeAndSkillsRequiredForPractice':
        return knowledgeAndSkillsRequiredForPractice;
      case 'labourRequiredForPractice':
        return labourRequiredForPractice;
      case 'costAssociatedWithPractice':
        return costAssociatedWithPractice;
      case 'doesItWorkInDegradedEnvironments':
        return doesItWorkInDegradedEnvironments;
      case 'doesItHelpRestoreLand':
        return doesItHelpRestoreLand;
      case 'climateChangeVulnerabilityEffects':
        return climateChangeVulnerabilityEffects;
      case 'timeRequirements':
        return timeRequirements;
      case 'generalPerformanceOfPracticeDetails':
        return generalPerformanceOfPracticeDetails;
      case 'unintendedPositiveSideEffectsOfPracticeDetails':
        return unintendedPositiveSideEffectsOfPracticeDetails;
      case 'unintendedNegativeSideEffectOfPracticeDetails':
        return unintendedNegativeSideEffectOfPracticeDetails;
      case 'knowledgeAndSkillsRequiredForPracticeDetails':
        return knowledgeAndSkillsRequiredForPracticeDetails;
      case 'labourRequiredForPracticeDetails':
        return labourRequiredForPracticeDetails;
      case 'costAssociatedWithPracticeDetails':
        return costAssociatedWithPracticeDetails;
      case 'doesItWorkInDegradedEnvironmentsDetails':
        return doesItWorkInDegradedEnvironmentsDetails;
      case 'doesItHelpRestoreLandDetails':
        return doesItHelpRestoreLandDetails;
      case 'climateChangeVulnerabilityEffectsDetails':
        return climateChangeVulnerabilityEffectsDetails;
      case 'timeRequirementsDetails':
        return timeRequirementsDetails;
      case 'knowledgeSource':
        return knowledgeSource;
      case 'knowledgeTiming':
        return knowledgeTiming;
      case 'knowledgeProducts':
        return knowledgeProducts;
      case 'uptakeMotivation':
        return uptakeMotivation;
      case 'knowledgeSourceDetails':
        return knowledgeSourceDetails;
      case 'knowledgeTimingDetails':
        return knowledgeTimingDetails;
      case 'createdAt':
        return createdAt;
      case 'updatedAt':
        return updatedAt;
      default:
        throw Exception('Invalid field name: $fieldName');
    }
  }

  static Practice initPractice() {
    return Practice(
      id: 0,
      name: '',
      location: '',
      responsibleForInformation: '',
      url: '',
      imageUrl: '',
      whereItIsRealized: '',
      summaryDescription: '',
      practicalImplementationOfThePractice: '',
      typeOfAgroecologicalPractice: '',
      whyYouUseAndWhatYouExpectFromThisPractice: '',
      landSize: '',
      substitutionOfLessEcologicalAlternative: '',
      agroecologyPrinciplesAddressed: '',
      foodSystemComponentsAddressed: '',
      generalPerformanceOfPractice: '',
      unintendedPositiveSideEffectsOfPractice: '',
      unintendedNegativeSideEffectOfPractice: '',
      knowledgeAndSkillsRequiredForPractice: '',
      labourRequiredForPractice: '',
      costAssociatedWithPractice: '',
      doesItWorkInDegradedEnvironments: '',
      doesItHelpRestoreLand: '',
      climateChangeVulnerabilityEffects: '',
      timeRequirements: '',
      generalPerformanceOfPracticeDetails: '',
      unintendedPositiveSideEffectsOfPracticeDetails: '',
      unintendedNegativeSideEffectOfPracticeDetails: '',
      knowledgeAndSkillsRequiredForPracticeDetails: '',
      labourRequiredForPracticeDetails: '',
      costAssociatedWithPracticeDetails: '',
      doesItWorkInDegradedEnvironmentsDetails: '',
      doesItHelpRestoreLandDetails: '',
      climateChangeVulnerabilityEffectsDetails: '',
      timeRequirementsDetails: '',
      knowledgeSource: '',
      knowledgeTiming: '',
      knowledgeProducts: '',
      uptakeMotivation: '',
      knowledgeSourceDetails: '',
      knowledgeTimingDetails: '',
      locationId: '',
      accountId: '',
      createdAt: '',
      updatedAt: '',
    );
  }
}
