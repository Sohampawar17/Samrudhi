import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:geolocation/model/attendance_dashboard_model.dart';
import 'package:geolocation/model/dashboard.dart';
import 'package:geolocation/model/leave_model.dart';
import 'package:geolocation/services/home_services.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../model/gelocation_model.dart';
import '../../router.router.dart';


class Homeviewmodel extends BaseViewModel {
  String? user;
  String? full_name;
  String? role_profile;
  List<LocationTable> location = [];
  final List<AttendanceData> attendanceData = [
    AttendanceData(type: "Total Days", data: [5, 30]),
    AttendanceData(type: "Presents", data: [0, 5]),
    AttendanceData(type: "Absents", data: [0, 5]),
    AttendanceData(type: "Days Off", data: [0, 5]),
  ];
bool res=false;
bool loading=false;
    String? greeting;
Dashboard dashboard=Dashboard();
AttendanceDashboard  attendancedashboard=AttendanceDashboard();
List<LeaveData> leavelist=[];
  initialise(BuildContext context) async {
    setBusy(true);
    final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    user = prefs.getString("user") ?? "";
    full_name = prefs.getString("full_name") ?? "";
    role_profile = prefs.getString("role_profile") ?? "";
dashboard=await HomeServices().dashboard() ?? Dashboard();
attendancedashboard=await HomeServices().attendanceDashboard() ?? AttendanceDashboard();
leavelist=await HomeServices().fetchleavedata();
final now = DateTime.now();
    final timeOfDay = now.hour;
    if (timeOfDay < 12) {
      greeting = "Good Morning,";
    } else if (timeOfDay < 17) {
      greeting = "Good Afternoon,";
    } else {
      greeting = "Good Evening,";
    }

    if (dashboard.company == null) {
      final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
      final SharedPreferences prefs = await prefs0;
      prefs.clear();
      if (context.mounted) {
        setBusy(false);
        Navigator.popAndPushNamed(context, Routes.loginViewScreen);
        Logger().i('logged out success');
      }
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

class AttendanceData {
  final String type;
  final List<int> data;

  AttendanceData({required this.type, required this.data});
}