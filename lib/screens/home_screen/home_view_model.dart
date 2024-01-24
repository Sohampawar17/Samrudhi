import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/model/dashboard.dart';
import 'package:geolocation/services/home_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../model/gelocation_model.dart';
import '../../router.router.dart';
import '../../services/geolocation_services.dart';


class Homeviewmodel extends BaseViewModel {
  String? user;
  String? full_name;
  String? role_profile;
  List<LocationTable> location = [];
  late SharedPreferences prefs;
  DashBoard _cachedDashboard = DashBoard();
bool res=false;
bool loading=false;
    String? greeting;
DashBoard dashboard=DashBoard();
  AttendanceDetails  attendanceDashboard=AttendanceDetails();
List<LeaveBalance> leaveList=[];




  Future<void> fetchDashboard() async {
    try {
      dashboard = await HomeServices().dashboard() ?? DashBoard();
      attendanceDashboard = dashboard.attendanceDetails ?? AttendanceDetails();
      leaveList = dashboard.leaveBalance ?? [];
      await _saveDataToCache(dashboard);
      _cachedDashboard = dashboard;
      Logger().i(_cachedDashboard.toString());
    } catch (e) {
      Logger().e('Error during dashboard fetch: $e');
      // Handle the error
    }
  }

  void handleGreeting() {
    final now = DateTime.now();
    final timeOfDay = now.hour;
    if (timeOfDay < 12) {
      greeting = "Good Morning,";
    } else if (timeOfDay < 17) {
      greeting = "Good Afternoon,";
    } else {
      greeting = "Good Evening,";
    }
  }

  Future<void> handleLogout(BuildContext context) async {
    if (dashboard.company == "") {
      final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
      final SharedPreferences prefs = await prefs0;
      prefs.clear();
      if (context.mounted) {
        setBusy(false);
        Navigator.popAndPushNamed(context, Routes.loginViewScreen);
        Logger().i('logged out success');
      }
    }
  }

  // Future<void> fetchDataIfNeeded() async {
  //   if (dashboard.leaveBalance == []) {
  //     // Fetch data only if it's not already available
  //     setBusy(true);
  //     await fetchDashboard();
  //     handleGreeting();
  //     setBusy(false);
  //     Logger().i('is Called');
  //   }
  //
  // }

  Future<void> onRefresh() async {
      // Fetch data only if it's not already available
      setBusy(true);

      await fetchDashboard();
      handleGreeting();
      setBusy(false);
  }

  Future<void> initialize(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
if(_loadCachedData().company == null){
  onRefresh();
  notifyListeners();
}
    _cachedDashboard = _loadCachedData();
    Logger().i(_cachedDashboard.toJson());
    Logger().i(_loadCachedData().toJson());
   dashboard=_cachedDashboard;
   attendanceDashboard=_cachedDashboard.attendanceDetails ?? AttendanceDetails();
   leaveList=_cachedDashboard.leaveBalance ?? [];
    handleGreeting();
    notifyListeners();
  }

  DashBoard _loadCachedData() {
    final cachedDashboardString = prefs.getString('cached_dashboard');
    if (cachedDashboardString != null) {
      final Map<String, dynamic> cachedData = json.decode(cachedDashboardString);
      return DashBoard.fromJson(cachedData);
    }
    return DashBoard();
  }

  Future<void> _saveDataToCache(DashBoard newDashboard) async {
    final String jsonData = json.encode(newDashboard.toJson());
    prefs.setString('cached_dashboard', jsonData);
  }

  Future<void> fetchDataIfNeeded() async {
    // Fetch data only if it's not already available or there is a conflict
    final newDashboard = await HomeServices().dashboard() ?? DashBoard();
    if (!isDataEqual(newDashboard)) {
      // Update local cache and trigger necessary actions
      await _saveDataToCache(newDashboard);
      _cachedDashboard = newDashboard;
      handleGreeting();
      setBusy(false);
    }
  }

  bool isDataEqual(DashBoard newDashboard) {
    return _cachedDashboard.lastLogType == newDashboard.lastLogType;
  }

  void employeelog(String logtype) async {
    setBusy(true);
  GeolocationService geolocationService = GeolocationService();
  try {
    // Get the user's position using the geolocation service
    Position? position = await geolocationService.determinePosition();

    if (position != null) {
      // Update canedata object with latitude, longitude, and address
      String location = "${position.latitude},${position.longitude}";
      // Call the service to check in the employee
      res = await HomeServices().employeecheckin(logtype, location);
      if (res) {
        setBusy(false);
        // Update dashboard if the check-in was successful
        dashboard = await HomeServices().dashboard() ?? DashBoard();
      }
    } else {
      // Handle case where obtaining location fails
      Fluttertoast.showToast(msg: 'Failed to get location');
    }
  } catch (e) {
    // Handle any exceptions that might occur during the process
    print('Error during check-in: $e');
  } finally {
    // Set loading to false regardless of success or failure
    setBusy(false);
    notifyListeners();
  }
    setBusy(false);
}

  
}
