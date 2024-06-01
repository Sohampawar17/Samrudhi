class ListLeadModel {
  String? name;
  String? leadName;
  String? status;
  String? companyName;
  String? territory;
  String? location;

  ListLeadModel(
      {this.name,
      this.leadName,
      this.status,
      this.companyName,
      this.location});

  ListLeadModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    leadName = json['lead_name'];
    status = json['status'];
    companyName = json['company_name'];
    territory = json['territory'];
    location = json["custom_address"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['lead_name'] = leadName;
    data['status'] = status;
    data['company_name'] = companyName;
    data['territory'] = territory;
    return data;
  }
}
