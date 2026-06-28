class Institution {
  final String id;
  final String name;
  final String ministry;
  final String location;
  final String description;
  final String? icon;
  final String address;
  final String workingHours;
  final String phone;
  final String email;
  final String shortDescription;
  final double latitude;
  final double longitude;
  final bool isOpen;

  Institution({
    required this.id,
    required this.name,
    required this.ministry,
    required this.location,
    required this.description,
    this.icon,
    this.address = '',
    this.workingHours = '',
    this.phone = '',
    this.email = '',
    this.shortDescription = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.isOpen = false,
  });

  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      ministry: json['ministry'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'],
      address: json['address'] ?? '',
      workingHours: json['workingHours'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      isOpen: json['isOpen'] ?? false,
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
      'address': address,
      'workingHours': workingHours,
      'phone': phone,
      'email': email,
      'shortDescription': shortDescription,
      'latitude': latitude,
      'longitude': longitude,
      'isOpen': isOpen,
    };
  }
}
