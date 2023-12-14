import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:geolocation/model/dashboard.dart';
import 'package:geolocation/services/home_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../model/gelocation_model.dart';


class Homeviewmodel extends BaseViewModel {
  String? user;
  String? full_name;
  String? role_profile;
  List<LocationTable> location = [];
bool res=false;
bool loading=false;
    String? greeting;
Dashboard dashboard=Dashboard();

  initialise(BuildContext context) async {
    setBusy(true);
    final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    user = prefs.getString("user") ?? "";
    full_name = prefs.getString("full_name") ?? "";
    role_profile = prefs.getString("role_profile") ?? "";
dashboard=await HomeServices().dashboard() ?? Dashboard();
final now = DateTime.now();
    final timeOfDay = now.hour;
    if (timeOfDay < 12) {
      greeting = "Good Morning,";
    } else if (timeOfDay < 17) {
      greeting = "Good Afternoon,";
    } else {
      greeting = "Good Evening,";
    }
    setBusy(false);
  }

void employeelog(String logtype) async {
 loading=true;
res=await HomeServices().employeecheckin(logtype);
if(res){
   loading=false;
  dashboard=await HomeServices().dashboard() ?? Dashboard();
}
  notifyListeners();
   loading=false;
}


}
