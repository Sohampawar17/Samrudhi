import 'package:flutter/cupertino.dart';
import 'package:geolocation/model/employee_list.dart';
import 'package:geolocation/model/get_teritorry_details.dart';
import 'package:stacked/stacked.dart';
import '../../services/route_services.dart';

class RouteAssignmentViewModel extends BaseViewModel{

  bool res = false;
  List<RouteMasterData> routes = [];
  List<EmployeeAssignerDetails> employees = [];

  initialise (BuildContext context)async{
    setBusy(true);
    employees = await RouteServices().getEmployeeList();
    routes = await RouteServices().getPlannedRoutes("Approved");
    setBusy(false);
    notifyListeners();
  }

  String getEmployeeId(String name){
    var employee = employees.firstWhere((details) => details.employeeName == name);
    return employee.id!;
  }

  List<Waypoint> getChildTableData(){
    return[];

  }

  List<String> getEmployeeNames(){
    if (employees.isEmpty) {
      return [];
    }
    return employees
        .where((item) => item.employeeName != null && item.employeeName!.isNotEmpty)
        .map((item) => item.employeeName.toString())
        .toList();
  }
  List<String> getRouteNames(){
    if (routes.isEmpty) {
      return [];
    }
    return routes
        .where((item) => item.routeName != null && item.routeName!.isNotEmpty)
        .map((item) => item.routeName.toString())
        .toList();
  }

  Future<void> assignRoute(Map<String, dynamic> payload) async {
    setBusy(true);
    await RouteServices().assignRoute(payload);
    setBusy(false);
  }

  Future<RouteMaster> getRouteDetails(String route_Id) async {
    setBusy(true);
    return await RouteServices().getRouteDetails(route_Id);
    setBusy(false);
  }



  String getRouteId(String name){
    var routeId = routes.firstWhere((details) => details.routeName == name);
    return routeId.name!;
  }



}