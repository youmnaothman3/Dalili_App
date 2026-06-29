class FeedbackModel {
  final String id;
  final String stageId;
  final String institutionId;
  final String officeId;
  final String stageName;
  final String institutionName;
  final String officeName;
  final int rating;
  final String? complaintText;
  final DateTime submittedAt;

  FeedbackModel({
    required this.id,
    required this.stageId,
    required this.institutionId,
    required this.officeId,
    required this.stageName,
    required this.institutionName,
    required this.officeName,
    required this.rating,
    required this.complaintText,
    required this.submittedAt,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'] ?? '',
      stageId: json['stageId'] ?? '',
      institutionId: json['institutionId'] ?? '',
      officeId: json['officeId'] ?? '',
      stageName: json['stageName'] ?? '',
      institutionName: json['institutionName'] ?? '',
      officeName: json['officeName'] ?? '',
      rating: json['rating'] is int
          ? json['rating']
          : int.tryParse('${json['rating']}') ?? 0,
      complaintText: json['complaintText'],
      submittedAt: json['submittedAt'] != null
          ? DateTime.parse(json['submittedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stageId': stageId,
      'institutionId': institutionId,
      'officeId': officeId,
      'stageName': stageName,
      'institutionName': institutionName,
      'officeName': officeName,
      'rating': rating,
      'complaintText': complaintText,
      'submittedAt': submittedAt.toIso8601String(),
    };
  }
}
