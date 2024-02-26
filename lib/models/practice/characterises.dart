class Characterises {
  int id;
  int practiceId;
  String agroecologyPrinciplesAddressed;
  String foodSystemComponentsAddressed;
  String createdAt;
  String updatedAt;

  Characterises({
    required this.id,
    required this.practiceId,
    required this.agroecologyPrinciplesAddressed,
    required this.foodSystemComponentsAddressed,
  })  : createdAt = '',
        updatedAt = '';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'practice_id': practiceId,
      'agroecology_principles_addressed': agroecologyPrinciplesAddressed,
      'food_system_components_addressed': foodSystemComponentsAddressed,
    };
  }

  static Characterises initCharacterises() {
    return Characterises(
      id: 0,
      practiceId: 0,
      agroecologyPrinciplesAddressed: '',
      foodSystemComponentsAddressed: '',
    );
  }
}
