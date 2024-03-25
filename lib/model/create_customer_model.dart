class CreateCustomer {
  String? name;
  String? customerName;
  String? customerType;
  String? customerGroup;
  String? territory;
  String? gstCategory;
  String? gstin;
  String? emailId;
  String? mobileNo;
  Billing? billing;
  Billing? shipping;

  CreateCustomer(
      {this.name,
        this.customerName,
        this.customerType,
        this.customerGroup,
        this.territory,
        this.gstCategory,
        this.gstin,
        this.emailId,
        this.mobileNo,
        this.billing,
        this.shipping});

  CreateCustomer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customerName = json['customer_name'];
    customerType = json['customer_type'];
    customerGroup = json['customer_group'];
    territory = json['territory'];
    gstCategory = json['gst_category'];
    gstin = json['gstin'];
    emailId = json['email_id'];
    mobileNo = json['mobile_no'];
    billing =
    json['billing'] != null ? Billing.fromJson(json['billing']) : null;
    shipping = json['shipping'] != null
        ? Billing.fromJson(json['shipping'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['customer_name'] = customerName;
    data['customer_type'] = customerType;
    data['customer_group'] = customerGroup;
    data['territory'] = territory;
    data['gst_category'] = gstCategory;
    data['gstin'] = gstin;
    data['email_id'] = emailId;
    data['mobile_no'] = mobileNo;
    if (billing != null) {
      data['billing'] = billing!.toJson();
    }
    if (shipping != null) {
      data['shipping'] = shipping!.toJson();
    }
    return data;
  }
}

class Billing {
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? pincode;
  String? country;

  Billing(
      {this.addressLine1,
        this.addressLine2,
        this.city,
        this.state,
        this.pincode,
        this.country});

  Billing.fromJson(Map<String, dynamic> json) {
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    data['city'] = city;
    data['state'] = state;
    data['pincode'] = pincode;
    data['country'] = country;
    return data;
  }
}
