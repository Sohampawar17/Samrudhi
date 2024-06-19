
class RetailerModel {
   String? name;
   String? nameOfTheShop;
   String? nameOfTheShopOwner;
   String? mobileNo;
   String? whatsappNo;
   String? email;
   String? nameOfTheBuilding;
   String? road;
   String? landmark;
   String? cityTown;
   String? pinCode;
   String? area;
   String? tehsil;
   String? district;
   String? state;
   String? pan;
   String? gst;
   String? typeOfShop;
   String? weeklyOff;
   String? latitude;
   String? longitude;
   String? address;

  RetailerModel({
    this.name,
    this.nameOfTheShop,
    this.nameOfTheShopOwner,
    this.mobileNo,
    this.whatsappNo,
    this.email,
    this.nameOfTheBuilding,
    this.road,
    this.landmark,
    this.cityTown,
    this.pinCode,
    this.area,
    this.tehsil,
    this.district,
    this.state,
    this.pan,
    this.gst,
    this.typeOfShop,
    this.weeklyOff,
    this.latitude,
    this.longitude,
    this.address
  });

  factory RetailerModel.fromJson(Map<String, dynamic> json) {
    return RetailerModel(
      name: json['name'],
      nameOfTheShop: json['name_of_the_shop'],
      nameOfTheShopOwner: json['name_of_the_shop_owner'],
      mobileNo: json['mobile_no'],
      whatsappNo: json['whatsapp_no'],
      email: json['email'],
      nameOfTheBuilding: json['name_of_the_building'],
      road: json['road'],
      landmark: json['landmark'],
      cityTown: json['citytown'],
      pinCode: json['pin_code'],
      area: json['area'],
      tehsil: json['tehsil'],
      district: json['district'],
      state: json['state'],
      pan: json['pan'],
      gst: json['gst'],
      typeOfShop: json['type_of_shop'],
      weeklyOff: json['weekly_off'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'name_of_the_shop': nameOfTheShop,
      'name_of_the_shop_owner': nameOfTheShopOwner,
      'mobile_no': mobileNo,
      'whatsapp_no': whatsappNo,
      'email': email,
      'name_of_the_building': nameOfTheBuilding,
      'road': road,
      'landmark': landmark,
      'citytown': cityTown,
      'pin_code': pinCode,
      'area': area,
      'tehsil': tehsil,
      'district': district,
      'state': state,
      'pan': pan,
      'gst': gst,
      'type_of_shop': typeOfShop,
      'weekly_off': weeklyOff,
      'latitude': latitude,
      'longitude': longitude,
      'address': address
    };
  }
}
