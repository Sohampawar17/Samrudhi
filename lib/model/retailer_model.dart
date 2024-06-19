class RetailerModel {
  String? name;
  String? owner;
  String? nameOfTheShop;
  String? nameOfTheShopOwner;
  String? mobileNo;
  String? whatsappNo;
  String? email;
  String? nameOfTheBuilding;
  String? road;
  String? landmark;
  String? citytown;
  String? pinCode;
  String? territorry;
  String? area;
  String? tehsil;
  String? district;
  String? state;
  String? pan;
  String? gst;
  String? aadharNo;
  String? typeOfShop;
  String? assignedDistributor;
  String? weeklyOff;
  String? enquiryReference;
  String? latitude;
  String? longitude;
  String? address;

  RetailerModel(
      {this.name,
        this.owner,
        this.nameOfTheShop,
        this.nameOfTheShopOwner,
        this.mobileNo,
        this.whatsappNo,
        this.email,
        this.nameOfTheBuilding,
        this.road,
        this.landmark,
        this.citytown,
        this.pinCode,
        this.territorry,
        this.area,
        this.tehsil,
        this.district,
        this.state,
        this.pan,
        this.gst,
        this.aadharNo,
        this.typeOfShop,
        this.assignedDistributor,
        this.weeklyOff,
        this.enquiryReference,
        this.latitude,
        this.longitude,
        this.address});

  RetailerModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    nameOfTheShop = json['name_of_the_shop'];
    nameOfTheShopOwner = json['name_of_the_shop_owner'];
    mobileNo = json['mobile_no'];
    whatsappNo = json['whatsapp_no'];
    email = json['email'];
    nameOfTheBuilding = json['name_of_the_building'];
    road = json['road'];
    landmark = json['landmark'];
    citytown = json['citytown'];
    pinCode = json['pin_code'];
    territorry = json['territorry'];
    area = json['area'];
    tehsil = json['tehsil'];
    district = json['district'];
    state = json['state'];
    pan = json['pan'];
    gst = json['gst'];
    aadharNo = json['aadhar_no'];
    typeOfShop = json['type_of_shop'];
    assignedDistributor = json['assigned_distributor'];
    weeklyOff = json['weekly_off'];
    enquiryReference = json['enquiry_reference'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['name_of_the_shop'] = this.nameOfTheShop;
    data['name_of_the_shop_owner'] = this.nameOfTheShopOwner;
    data['mobile_no'] = this.mobileNo;
    data['whatsapp_no'] = this.whatsappNo;
    data['email'] = this.email;
    data['name_of_the_building'] = this.nameOfTheBuilding;
    data['road'] = this.road;
    data['landmark'] = this.landmark;
    data['citytown'] = this.citytown;
    data['pin_code'] = this.pinCode;
    data['territorry'] = this.territorry;
    data['area'] = this.area;
    data['tehsil'] = this.tehsil;
    data['district'] = this.district;
    data['state'] = this.state;
    data['pan'] = this.pan;
    data['gst'] = this.gst;
    data['aadhar_no'] = this.aadharNo;
    data['type_of_shop'] = this.typeOfShop;
    data['assigned_distributor'] = this.assignedDistributor;
    data['weekly_off'] = this.weeklyOff;
    data['enquiry_reference'] = this.enquiryReference;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    return data;
  }
}
