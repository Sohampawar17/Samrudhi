import 'package:flutter/cupertino.dart';
import 'package:geolocation/model/employee_details.dart';
import 'package:stacked/stacked.dart';
import '../../services/profle_services.dart';

class ProfileViewModel extends BaseViewModel{
  EmployeeDetails employeedetail=EmployeeDetails();
  initialise (BuildContext context)async{
    setBusy(true);
employeedetail= await ProfileServices().profile() ?? EmployeeDetails();
setBusy(false);
notifyListeners();
  }
}