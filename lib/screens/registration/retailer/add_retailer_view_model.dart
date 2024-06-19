

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/services/retailer_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../../../model/retailer_model.dart';
import '../../../services/geolocation_services.dart';

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

  List<String> days=["",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  String? validateString(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the value';
    }
    return null;
  }

  initialise(BuildContext context, String s) {


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

  void setState(String state) {
    stateController.text = state;
    retailerModel.state = state;
    notifyListeners();
  }

  void setCity(String city) {
    cityController.text = city;
    retailerModel.cityTown = city;
    notifyListeners();
  }

  void setDistrict(String district) {
    districtController.text = district;
    retailerModel.district = district;
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

  void setTypeOfShop(String typeOfShop) {
    typeOfShopController.text = typeOfShop;
    retailerModel.typeOfShop = typeOfShop;
    notifyListeners();
  }

  void setGst(String gst) {
    gstController.text = gst;
    retailerModel.gst = gst;
    notifyListeners();
  }

  void setAssignedDistributor(String assignedDistributor) {
    assignedDistributorController.text = assignedDistributor;
    retailerModel.nameOfTheShopOwner = assignedDistributor;
    notifyListeners();
  }

  void setAadharNo(String aadharNo) {
    aadharNoController.text = aadharNo;
    retailerModel.mobileNo = aadharNo;
    notifyListeners();
  }

  void onSavePressed(BuildContext context) async {
    Logger().i(retailerModel.toJson());
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
    }
  }




}