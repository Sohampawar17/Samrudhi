

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/model/territory_model.dart';
import 'package:geolocation/services/retailer_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../../../../model/retailer_model.dart';
import '../../../../services/add_lead_services.dart';
import '../../../../services/geolocation_services.dart';

class AddRetailerViewModel extends BaseViewModel {


  bool isEdit=false;
 RetailerModel retailerModel = RetailerModel();

  final formKey = GlobalKey<FormState>();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopOwnerNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController whatsAppNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameOfTheBuildingController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController roadController = TextEditingController();
  TextEditingController tehsilController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController typeOfShopController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController assignedDistributorController = TextEditingController();
  TextEditingController aadharNoController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController zoneController = TextEditingController();


  List<String> state=[
    "01-Jammu and Kashmir",
    "02-Himachal Pradesh",
    "03-Punjab",
    "04-Chandigarh",
    "05-Uttarakhand",
    "06-Haryana",
    "07-Delhi",
    "08-Rajasthan",
    "09-Uttar Pradesh",
    "10-Bihar",
    "11-Sikkim",
    "12-Arunachal Pradesh",
    "13-Nagaland",
    "14-Manipur",
    "15-Mizoram",
    "16-Tripura",
    "17-Meghalaya",
    "18-Assam",
    "19-West Bengal",
    "20-Jharkhand",
    "21-Odisha",
    "22-Chhattisgarh",
    "23-Madhya Pradesh",
    "24-Gujarat",
    "26-Dadra and Nagar Haveli and Daman and Diu",
    "27-Maharashtra",
    "29-Karnataka",
    "30-Goa",
    "31-Lakshadweep Islands",
    "32-Kerala",
    "33-Tamil Nadu",
    "34-Puducherry",
    "35-Andaman and Nicobar Islands",
    "36-Telangana",
    "37-Andhra Pradesh",
    "38-Ladakh",
    "96-Other Countries",
    "97-Other Territory"
  ];

  List<String> days=[
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  List<String> industrytype=[""];
   List<Territory> territoryList=[];
  List<String> territories=[];

  String? validateString(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the value';
    }
    return null;
  }
  String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter mobile number';
    }
    if (value.replaceAll(" ", "").length != 10) {
      return 'Mobile number should be exactly 10 digits';
    }
    // Additional validation rules can be added if needed.
    return null;
  }

  String? validateEmail(String? value) {

    // Regular expression for email validation
    final RegExp emailRegExp = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    );
    if (!emailRegExp.hasMatch(value!)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validateWhatsappNumber(String? value) {

    if (value?.replaceAll(" ", "").length != 10) {
      return 'whatsapp number should be exactly 10 digits';
    }
    // Additional validation rules can be added if needed.
    return null;
  }

initialise(BuildContext context, String id) async {
setBusy(true);
industrytype = await AddLeadServices().fetchindustrytype();
territoryList = await AddLeadServices().fetchTerritoryDetails();
getTerritoryNames();
if(id!=""){
  isEdit=true;
retailerModel=await RetailerServices().getId(id) ?? RetailerModel();
shopNameController.text = retailerModel.nameOfTheShop ?? '';
shopOwnerNameController.text = retailerModel.nameOfTheShopOwner ?? '';
mobileNoController.text = retailerModel.mobileNo ?? '';
whatsAppNoController.text = retailerModel.whatsappNo ?? '';
emailController.text = retailerModel.email ?? '';
nameOfTheBuildingController.text = retailerModel.nameOfTheBuilding ?? '';
areaController.text = retailerModel.area ?? '';
roadController.text = retailerModel.road ?? '';
tehsilController.text = retailerModel.tehsil ?? '';
landmarkController.text = retailerModel.landmark ?? '';
stateController.text = retailerModel.state ?? '';
cityController.text = retailerModel.citytown ?? '';
districtController.text = retailerModel.district ?? '';
pincodeController.text = retailerModel.pinCode ?? '';
panController.text = retailerModel.pan ?? '';
typeOfShopController.text = retailerModel.typeOfShop ?? '';
gstController.text = retailerModel.gst ?? '';
assignedDistributorController.text = retailerModel.assignedDistributor ?? '';
aadharNoController.text = retailerModel.aadharNo ?? '';
regionController.text = retailerModel.region ?? '';
zoneController.text = retailerModel.zone ?? '';
}
setBusy(false);

  }
  void setShopName(String shopName){
    shopNameController.text=shopName;
    retailerModel.nameOfTheShop = shopName;
    notifyListeners();
  }

  void setShopOwnerName(String shopOwnerName){
    shopOwnerNameController.text=shopOwnerName;
    retailerModel.nameOfTheShopOwner = shopOwnerName;
    notifyListeners();
  }

  void setMobileNo(String mobileNo){
    mobileNoController.text=mobileNo;
    retailerModel.mobileNo = mobileNo;
    notifyListeners();
  }
  void setWhatsappNo(String whatsAppNo){
    whatsAppNoController.text=whatsAppNo;
    retailerModel.whatsappNo = whatsAppNo;
    notifyListeners();
  }

  void setEmail(String email){
    emailController.text=email;
    retailerModel.email = email;
    notifyListeners();
  }
  void setBuildingNameOfTheController(String nameofBuilding){
    nameOfTheBuildingController.text=nameofBuilding;
    retailerModel.nameOfTheBuilding = nameofBuilding;
    notifyListeners();
  }

  void setAreaController(String area){
    areaController.text=area;
    retailerModel.area = area;
    notifyListeners();
  }
  void setRoadController(String road){
    roadController.text=road;
    retailerModel.road = road;
    notifyListeners();
  }

  void setTehsil(String tehsil) {
    tehsilController.text = tehsil;
    retailerModel.tehsil = tehsil;
    notifyListeners();
  }

  void setLandmark(String landmark) {
    landmarkController.text = landmark;
    retailerModel.landmark = landmark;
    notifyListeners();
  }

  void setState(String? state) {

    retailerModel.state = state;
    notifyListeners();
  }

  void setCity(String city) {
    cityController.text = city;
    retailerModel.citytown = city;
    notifyListeners();
  }

  void setDistrict(String district) {
    districtController.text = district;
    retailerModel.district = district;
    notifyListeners();
  }

  void setRegion(String region) {
    regionController.text = region;
    retailerModel.region = region;
    notifyListeners();
  }

  void setZone(String zone) {
    zoneController.text = zone;
    retailerModel.zone = zone;
    notifyListeners();
  }


  void setPincode(String pincode) {
    pincodeController.text = pincode;
    retailerModel.pinCode = pincode;
    notifyListeners();
  }

  void setPan(String pan) {
    panController.text = pan;
    retailerModel.pan = pan;
    notifyListeners();
  }

  void setTypeOfShop(String? typeOfShop) {
    retailerModel.typeOfShop = typeOfShop;
    notifyListeners();
  }
  void setweeklyoff(String? weeklyOff) {
    retailerModel.weeklyOff = weeklyOff;
    notifyListeners();
  }

  void setGst(String gst) {
    gstController.text = gst;
    retailerModel.gst = gst;
    notifyListeners();
  }

  void setindustry(String? industry){
    retailerModel.typeOfShop =industry;
    notifyListeners();
  }
  void setTerritory(String? territory){
    retailerModel.territorry =territory;
    notifyListeners();
  }

  void setAssignedDistributor(String assignedDistributor) {
    assignedDistributorController.text = assignedDistributor;
    retailerModel.assignedDistributor = assignedDistributor;
    notifyListeners();
  }

  void setAadharNo(String aadharNo) {
    aadharNoController.text = aadharNo;
    retailerModel.aadharNo = aadharNo;
    notifyListeners();
  }

  void onSavePressed(BuildContext context) async {

    setBusy(true);

    if (formKey.currentState!.validate()) {
      GeolocationService geolocationService = GeolocationService();
      try {

        Position? position = await geolocationService.determinePosition();

        if (position == null) {
          return setBusy(false);
        }

        String formattedAddress = await geolocationService
            .getAddressFromCoordinates(position.latitude, position.longitude) ??
            "";

        retailerModel.latitude = position.latitude.toString();
        retailerModel.longitude = position.longitude.toString();
        retailerModel.address = formattedAddress;
        bool res = false;
        print(json.encode(retailerModel.toJson()));
        Logger().i(retailerModel.toJson());
        if (isEdit == true) {
          res = await RetailerServices().addRetailer(retailerModel);
          if (res) {
            if (context.mounted) {
              setBusy(false);
              Navigator.pop(context);
            }
          }
        } else {
          res = await RetailerServices().addRetailer(retailerModel);
          if (res) {
            if (context.mounted) {
              setBusy(false);
              Navigator.pop(context);
            }
          }
        }
      } catch (e) {
        Fluttertoast.showToast(msg: '$e');
      } finally {
        // setBusy(false);
      }
      setBusy(false);
    }else{
      setBusy(false);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill the mandatory fields')));
    }
  }

  void getTerritoryNames(){
    if (territoryList.isEmpty) {
      return ;
    }
    territories = territoryList
        .where((item) => item.name.isNotEmpty)
        .map((item) => item.name.toString())
        .toList();
    notifyListeners();
  }

  void getTerritoryDetails(String name) {
    var territory = territoryList.firstWhere((details) => details.name == name);
    setAreaController(territory.area);
    setTehsil(territory.tehsil);
    setDistrict(territory.district);
    setPincode(territory.pincode);
    setState(territory.state);
    setCity(territory.name);
    setRegion(territory.region);
    setZone(territory.zone);

  }



  @override
  void dispose() {
    shopNameController.dispose();
    shopOwnerNameController.dispose();
    mobileNoController.dispose();
    whatsAppNoController.dispose();
    emailController.dispose();
    nameOfTheBuildingController.dispose();
    areaController.dispose();
    roadController.dispose();
    tehsilController.dispose();
    landmarkController.dispose();
    stateController.dispose();
    cityController.dispose();
    districtController.dispose();
    pincodeController.dispose();
    panController.dispose();
    typeOfShopController.dispose();
    gstController.dispose();
    assignedDistributorController.dispose();
    aadharNoController.dispose();
    super.dispose();
  }



}