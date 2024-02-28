class Evaluate {
  int id;
  int practiceId;
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
  String createdAt;
  String updatedAt;

  Evaluate({
    required this.id,
    required this.practiceId,
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
  })  : createdAt = '',
        updatedAt = '';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'practice_id': practiceId,
      'general_performance_of_practice': generalPerformanceOfPractice,
      'unintended_positive_side_effects_of_practice': unintendedPositiveSideEffectsOfPractice,
      'unintended_negative_side_effect_of_practice': unintendedNegativeSideEffectOfPractice,
      'knowledge_and_skills_required_for_practice': knowledgeAndSkillsRequiredForPractice,
      'labour_required_for_practice': labourRequiredForPractice,
      'cost_associated_with_practice': costAssociatedWithPractice,
      'does_it_work_in_degraded_environments': doesItWorkInDegradedEnvironments,
      'does_it_help_restore_land': doesItHelpRestoreLand,
      'climate_change_vulnerability_effects': climateChangeVulnerabilityEffects,
      'time_requirements': timeRequirements,
      'general_performance_of_practice_details': generalPerformanceOfPracticeDetails,
      'unintended_positive_side_effects_of_practice_details': unintendedPositiveSideEffectsOfPracticeDetails,
      'unintended_negative_side_effect_of_practice_details': unintendedNegativeSideEffectOfPracticeDetails,
      'knowledge_and_skills_required_for_practice_details': knowledgeAndSkillsRequiredForPracticeDetails,
      'labour_required_for_practice_details': labourRequiredForPracticeDetails,
      'cost_associated_with_practice_details': costAssociatedWithPracticeDetails,
      'does_it_work_in_degraded_environments_details': doesItWorkInDegradedEnvironmentsDetails,
      'does_it_help_restore_land_details': doesItHelpRestoreLandDetails,
      'climate_change_vulnerability_effects_details': climateChangeVulnerabilityEffectsDetails,
      'time_requirements_details': timeRequirementsDetails,
    };
  }

  static Evaluate initEvaluate() {
    return Evaluate(
      id: 0,
      practiceId: 0,
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
    );
  }
}
