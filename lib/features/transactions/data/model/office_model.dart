class OfficeModel {
  final String id;
  final String name;
  final String institutionName;
  final String departmentName;
  final String locationInsideInstitution;
  final String notes;

  OfficeModel({
    required this.id,
    required this.name,
    required this.institutionName,
    required this.departmentName,
    required this.locationInsideInstitution,
    required this.notes,
  });

  factory OfficeModel.fromJson(Map<String, dynamic> json) {
    return OfficeModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      institutionName: json['institutionName'] ?? '',
      departmentName: json['departmentName'] ?? '',
      locationInsideInstitution: json['locationInsideInstitution'] ?? '',
      notes: json['notes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'institutionName': institutionName,
      'departmentName': departmentName,
      'locationInsideInstitution': locationInsideInstitution,
      'notes': notes,
    };
  }
}
