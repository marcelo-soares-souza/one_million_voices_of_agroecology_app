class Acknowledge {
  int id;
  int practiceId;
  String knowledgeSource;
  String knowledgeTiming;
  String knowledgeProducts;
  String uptakeMotivation;
  String knowledgeSourceDetails;
  String knowledgeTimingDetails;
  String createdAt;
  String updatedAt;

  Acknowledge({
    required this.id,
    required this.practiceId,
    required this.knowledgeSource,
    required this.knowledgeTiming,
    required this.knowledgeProducts,
    required this.uptakeMotivation,
    required this.knowledgeSourceDetails,
    required this.knowledgeTimingDetails,
  })  : createdAt = '',
        updatedAt = '';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'practice_id': practiceId,
      'knowledge_source': knowledgeSource,
      'knowledge_timing': knowledgeTiming,
      'knowledge_products': knowledgeProducts,
      'uptake_motivation': uptakeMotivation,
      'knowledge_source_details': knowledgeSourceDetails,
      'knowledge_timing_details': knowledgeTimingDetails,
    };
  }

  static Acknowledge initAcknowledge() {
    return Acknowledge(
      id: 0,
      practiceId: 0,
      knowledgeSource: '',
      knowledgeTiming: '',
      knowledgeProducts: '',
      uptakeMotivation: '',
      knowledgeSourceDetails: '',
      knowledgeTimingDetails: '',
    );
  }
}
