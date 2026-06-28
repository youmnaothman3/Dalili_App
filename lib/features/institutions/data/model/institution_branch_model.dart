class InstitutionBranch {
  final String id;
  final String name;
  final String location;
  final String address;
  final bool isOpen;
  final int transactionsCount;

  InstitutionBranch({
    required this.id,
    required this.name,
    required this.location,
    required this.address,
    required this.isOpen,
    this.transactionsCount = 0,
  });

  factory InstitutionBranch.fromJson(Map<String, dynamic> json) {
    return InstitutionBranch(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      address: json['address'] ?? '',
      isOpen: json['isOpen'] ?? false,
      transactionsCount: json['transactionsCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'address': address,
      'isOpen': isOpen,
      'transactionsCount': transactionsCount,
    };
  }
}
