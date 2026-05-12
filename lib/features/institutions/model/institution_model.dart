class Institution {
  final String id;
  final String name;
  final String ministry;
  final String location;
  final String description;
  final String? icon;

  Institution({
    required this.id,
    required this.name,
    required this.ministry,
    required this.location,
    required this.description,
    this.icon,
  });

  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      ministry: json['ministry'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ministry': ministry,
      'location': location,
      'description': description,
      'icon': icon,
    };
  }
}
