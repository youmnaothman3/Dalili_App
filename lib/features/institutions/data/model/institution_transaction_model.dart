class InstitutionTransaction {
  final String id;
  final String name;
  final String description;
  final int estimatedTimeInDays;
  final String fees;

  InstitutionTransaction({
    required this.id,
    required this.name,
    required this.description,
    required this.estimatedTimeInDays,
    required this.fees,
  });

  factory InstitutionTransaction.fromJson(Map<String, dynamic> json) {
    return InstitutionTransaction(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      estimatedTimeInDays: json['estimatedTimeInDays'] ?? 0,
      fees: json['fees'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'estimatedTimeInDays': estimatedTimeInDays,
      'fees': fees,
    };
  }
}
