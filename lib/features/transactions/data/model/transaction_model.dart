import 'package:dalili_app/features/institutions/data/model/institution_model.dart';
import 'package:dalili_app/features/transactions/data/model/stage_model.dart';

class TransactionModel {
  final String id;
  final String name;
  final String description;
  final String institutionName;
  final String governorate;
  final String? icon;
  final List<StageModel> stages;
  final Institution? institution;

  TransactionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.institutionName,
    required this.governorate,
    this.icon,
    this.stages = const [],
    this.institution,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      institutionName: json['institutionName'] ?? '',
      governorate: json['governorate'] ?? '',
      icon: json['icon'],
      stages:
          (json['stages'] as List<dynamic>?)
              ?.map((e) => StageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      institution: json['institution'] != null
          ? Institution.fromJson(json['institution'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'institutionName': institutionName,
      'governorate': governorate,
      'icon': icon,
      'stages': stages.map((stage) => stage.toJson()).toList(),
      'institution': institution?.toJson(),
    };
  }
}
