class Territory {
  final String name;
  final String zone;
  final String region;
  final String state;
  final String area;
  final String district;
  final String tehsil;
  final String pincode;

  Territory({
    required this.name,
    required this.zone,
    required this.region,
    required this.state,
    required this.area,
    required this.district,
    required this.tehsil,
    required this.pincode
  });

  // Factory method to create a Territory from JSON
  factory Territory.fromJson(Map<String, dynamic> json) {
    return Territory(
      name: json['name'] ?? '',
      zone: json['custom_zone'] ?? '',
      region: json['custom_region'] ?? '',
      area: json['custom_area'] ?? '',
      district: json['custom_district'] ?? '',
      tehsil: json['custom_tahsil'] ?? '',
      pincode: json['custom_pin_code']?? '',
      state: json['custom_state']?? ''
    );
  }
}
