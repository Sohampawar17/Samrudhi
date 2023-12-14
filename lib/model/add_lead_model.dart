class AddLeadModel {
  String? name;
  String? owner;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? namingSeries;
  String? salutation;
  String? firstName;
  String? lastName;
  String? leadName;
  String? gender;
  String? source;
  String? leadOwner;
  String? status;
  String? type;
  String? requestType;
  String? emailId;
  String? mobileNo;
  String? whatsappNo;
  String? phone;
  String? companyName;
  String? noOfEmployees;
  double? annualRevenue;
  String? territory;
  String? city;
  String? state;
  String? country;
  String? industry;
  String? qualificationStatus;
  String? company;
  String? language;
  String? image;
  String? title;
  int? disabled;
  int? unsubscribed;
  int? blogSubscriber;
  String? doctype;
  List<Notes>? notes;

  AddLeadModel(
      {this.name,
      this.owner,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.namingSeries,
      this.salutation,
      this.firstName,
      this.lastName,
      this.leadName,
      this.gender,
      this.source,
      this.leadOwner,
      this.status,
      this.type,
      this.requestType,
      this.emailId,
      this.mobileNo,
      this.whatsappNo,
      this.phone,
      this.companyName,
      this.noOfEmployees,
      this.annualRevenue,
      this.territory,
      this.city,
      this.state,
      this.country,
      this.industry,
      this.qualificationStatus,
      this.company,
      this.language,
      this.image,
      this.title,
      this.disabled,
      this.unsubscribed,
      this.blogSubscriber,
      this.doctype,
      this.notes});

  AddLeadModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    namingSeries = json['naming_series'];
    salutation = json['salutation'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    leadName = json['lead_name'];
    gender = json['gender'];
    source = json['source'];
    leadOwner = json['lead_owner'];
    status = json['status'];
    type = json['type'];
    requestType = json['request_type'];
    emailId = json['email_id'];
    mobileNo = json['mobile_no'];
    whatsappNo = json['whatsapp_no'];
    phone = json['phone'];
    companyName = json['company_name'];
    noOfEmployees = json['no_of_employees'];
    annualRevenue = json['annual_revenue'];
    territory = json['territory'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    industry = json['industry'];
    qualificationStatus = json['qualification_status'];
    company = json['company'];
    language = json['language'];
    image = json['image'];
    title = json['title'];
    disabled = json['disabled'];
    unsubscribed = json['unsubscribed'];
    blogSubscriber = json['blog_subscriber'];
    doctype = json['doctype'];
    if (json['notes'] != null) {
      notes = <Notes>[];
      json['notes'].forEach((v) {
        notes!.add(new Notes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['naming_series'] = this.namingSeries;
    data['salutation'] = this.salutation;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['lead_name'] = this.leadName;
    data['gender'] = this.gender;
    data['source'] = this.source;
    data['lead_owner'] = this.leadOwner;
    data['status'] = this.status;
    data['type'] = this.type;
    data['request_type'] = this.requestType;
    data['email_id'] = this.emailId;
    data['mobile_no'] = this.mobileNo;
    data['whatsapp_no'] = this.whatsappNo;
    data['phone'] = this.phone;
    data['company_name'] = this.companyName;
    data['no_of_employees'] = this.noOfEmployees;
    data['annual_revenue'] = this.annualRevenue;
    data['territory'] = this.territory;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['industry'] = this.industry;
    data['qualification_status'] = this.qualificationStatus;
    data['company'] = this.company;
    data['language'] = this.language;
    data['image'] = this.image;
    data['title'] = this.title;
    data['disabled'] = this.disabled;
    data['unsubscribed'] = this.unsubscribed;
    data['blog_subscriber'] = this.blogSubscriber;
    data['doctype'] = this.doctype;
    if (this.notes != null) {
      data['notes'] = this.notes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notes {
  int? name;
  String? owner;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? note;
  String? addedBy;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  Notes(
      {this.name,
      this.owner,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.note,
      this.addedBy,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.doctype});

  Notes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    note = json['note'];
    addedBy = json['added_by'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['note'] = this.note;
    data['added_by'] = this.addedBy;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['doctype'] = this.doctype;
    return data;
  }
}
