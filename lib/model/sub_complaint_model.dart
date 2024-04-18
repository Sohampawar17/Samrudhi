class SubComplaint {
  String? name;
  String? department;

  SubComplaint({this.name, this.department});

  SubComplaint.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    department = json['department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['department'] = this.department;
    return data;
  }
}
