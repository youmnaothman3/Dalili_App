import 'package:dalili_app/features/institutions/data/model/institution_model.dart';
import 'package:dalili_app/features/transactions/data/model/office_model.dart';

class StageModel {
  final String id;
  final String name;
  final String description;
  final String responsibleInstitution;
  final String shortDescription;
  final List<String> requiredDocuments;
  final List<String> requiredFees;
  final List<String> requiredStamps;
  final List<String> notes;
  final Institution? institution;
  final OfficeModel? office;

  StageModel({
    required this.id,
    required this.name,
    required this.description,
    required this.responsibleInstitution,
    required this.shortDescription,
    this.requiredDocuments = const [],
    this.requiredFees = const [],
    this.requiredStamps = const [],
    this.notes = const [],
    this.institution,
    this.office,
  });

  factory StageModel.fromJson(Map<String, dynamic> json) {
    return StageModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      responsibleInstitution: json['responsibleInstitution'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      requiredDocuments: List<String>.from(json['requiredDocuments'] ?? []),
      requiredFees: List<String>.from(json['requiredFees'] ?? []),
      requiredStamps: List<String>.from(json['requiredStamps'] ?? []),
      notes: List<String>.from(json['notes'] ?? []),
      institution: json['institution'] != null
          ? Institution.fromJson(json['institution'])
          : null,
      office: json['office'] != null
          ? OfficeModel.fromJson(json['office'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'responsibleInstitution': responsibleInstitution,
      'shortDescription': shortDescription,
      'requiredDocuments': requiredDocuments,
      'requiredFees': requiredFees,
      'requiredStamps': requiredStamps,
      'notes': notes,
      'institution': institution?.toJson(),
      'office': office?.toJson(),
    };
  }
}
