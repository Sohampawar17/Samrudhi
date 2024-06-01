class AddLeadModel {
  String? name;
  String? owner;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? namingSeries;
  String? requestType;
  String? customCustomRequestType;
  String? customComplaintCustomer;
  String? customComplaintStatus;
  String? salutation;
  String? firstName;
  String? middleName;
  String? customCallStatus;
  String? lastName;
  String? leadName;
  String? source;
  String? customComplaintType;
  String? customSubComplaintType;
  String? customDepartment;
  String? customIssueStatus;
  String? leadOwner;
  String? status;
  String? type;
  String? emailId;
  String? website;
  String? mobileNo;
  String? whatsappNo;
  String? phone;
  String? companyName;
  String? noOfEmployees;
  double? annualRevenue;
  String? industry;
  String? territory;
  String? city;
  String? state;
  String? country;
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
  String? latitude;
  String? longitude;
  String? location;

  AddLeadModel(
      {this.name,
        this.owner,
        this.modifiedBy,
        this.docstatus,
        this.idx,
        this.namingSeries,
        this.requestType,
        this.customCustomRequestType,
        this.customComplaintCustomer,
        this.customComplaintStatus,
        this.salutation,
        this.firstName,
        this.middleName,
        this.customCallStatus,
        this.lastName,
        this.leadName,
        this.source,
        this.customComplaintType,
        this.customSubComplaintType,
        this.customDepartment,
        this.customIssueStatus,
        this.leadOwner,
        this.status,
        this.type,
        this.emailId,
        this.website,
        this.mobileNo,
        this.whatsappNo,
        this.phone,
        this.companyName,
        this.noOfEmployees,
        this.annualRevenue,
        this.industry,
        this.territory,
        this.city,
        this.state,
        this.country,
        this.qualificationStatus,
        this.company,
        this.language,
        this.image,
        this.title,
        this.disabled,
        this.unsubscribed,
        this.blogSubscriber,
        this.doctype,
        this.notes,
        this.latitude,
        this.longitude,
        this.location

      });

  AddLeadModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    namingSeries = json['naming_series'];
    requestType = json['request_type'];
    customCustomRequestType=json['custom_custom_request_type'];
    customComplaintCustomer = json['custom_complaint_customer'];
    customComplaintStatus = json['custom_complaint_status'];
    salutation = json['salutation'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    customCallStatus = json['custom_call_status'];
    lastName = json['last_name'];
    leadName = json['lead_name'];
    source = json['source'];
    customComplaintType = json['custom_complaint_type'];
    customSubComplaintType = json['custom_sub_complaint_type'];
    customDepartment = json['custom_department'];
    customIssueStatus = json['custom_issue_status'];
    leadOwner = json['lead_owner'];
    status = json['status'];
    type = json['type'];
    emailId = json['email_id'];
    website = json['website'];
    mobileNo = json['mobile_no'];
    whatsappNo = json['whatsapp_no'];
    phone = json['phone'];
    companyName = json['company_name'];
    noOfEmployees = json['no_of_employees'];
    annualRevenue = json['annual_revenue'];
    industry = json['industry'];
    territory = json['territory'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
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
    latitude = json['custom_latitude'].toString();
    longitude = json ['custom_longitude'].toString();
    location = json['custom_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['owner'] = owner;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['naming_series'] = namingSeries;
    data['request_type'] = requestType;
    data['custom_complaint_customer'] = customComplaintCustomer;
    data['custom_custom_request_type']=customCustomRequestType;
    data['custom_complaint_status'] = customComplaintStatus;
    data['salutation'] = salutation;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['custom_call_status'] = customCallStatus;
    data['last_name'] = lastName;
    data['lead_name'] = leadName;
    data['source'] = source;
    data['custom_complaint_type'] = customComplaintType;
    data['custom_sub_complaint_type'] = customSubComplaintType;
    data['custom_department'] = customDepartment;
    data['custom_issue_status'] = customIssueStatus;
    data['lead_owner'] = leadOwner;
    data['status'] = status;
    data['type'] = type;
    data['email_id'] = emailId;
    data['website'] = website;
    data['mobile_no'] = mobileNo;
    data['whatsapp_no'] = whatsappNo;
    data['phone'] = phone;
    data['company_name'] = companyName;
    data['no_of_employees'] = noOfEmployees;
    data['annual_revenue'] = annualRevenue;
    data['industry'] = industry;
    data['territory'] = territory;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['qualification_status'] = qualificationStatus;
    data['company'] = company;
    data['language'] = language;
    data['image'] = image;
    data['title'] = title;
    data['disabled'] = disabled;
    data['unsubscribed'] = unsubscribed;
    data['blog_subscriber'] = blogSubscriber;
    data['doctype'] = doctype;
    if (notes != null) {
      data['notes'] = notes!.map((v) => v.toJson()).toList();
    }
    data['custom_address']= location;
    data['custom_latitude']= latitude;
    data['custom_longitude']=longitude;
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
  String? addedOn;
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
        this.addedOn,
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
    addedOn = json['added_on'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['owner'] = owner;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['note'] = note;
    data['added_by'] = addedBy;
    data['added_on'] = addedOn;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    data['doctype'] = doctype;
    return data;
  }
}
