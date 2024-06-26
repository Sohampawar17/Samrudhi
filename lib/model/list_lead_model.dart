class ListLeadModel {
  String? name;
  String? leadName;
  String? customEnquiryStatus;
  String? companyName;
  String? territory;
  String? location;
  String? creation;

  ListLeadModel(
      {this.name,
      this.leadName,
      this.customEnquiryStatus,
      this.companyName,
        this.creation,
      this.location});

  ListLeadModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    leadName = json['lead_name'];
    customEnquiryStatus = json ["custom_enquiry_status"];
    companyName = json['company_name'];
    creation=json["creation"];
    territory = json['territory'];
    location = json["custom_address"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['lead_name'] = leadName;
    data["custom_enquiry_status"] = customEnquiryStatus;
    data['company_name'] = companyName;
    data["creation"]=creation;
    data['territory'] = territory;
    return data;
  }
}
