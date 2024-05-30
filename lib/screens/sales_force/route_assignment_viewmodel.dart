import 'package:flutter/cupertino.dart';
import 'package:geolocation/model/employee_list.dart';
import 'package:geolocation/model/get_teritorry_details.dart';
import 'package:stacked/stacked.dart';
import '../../services/route_services.dart';

class RouteAssignmentViewModel extends BaseViewModel{

  bool res = false;
  List<RouteMasterData> routes = [];
  List<EmployeeAssignerDetails> employees = [];
  List<Waypoints>  waypoints=[];
  String? selectedRoute;
  String? selectedEmployee;
  RoutesAssignment routesAssignment = RoutesAssignment();

  initialise (BuildContext context,String assignmentId)async{
    setBusy(true);
    employees = await RouteServices().getEmployeeList();
    routes = await RouteServices().getPlannedRoutes("Approved");
    if(assignmentId != ""){
       routesAssignment = await RouteServices().getRouteTableDetails(assignmentId);
       selectedRoute= routesAssignment.routeName;
       selectedEmployee = routesAssignment.employeeName;

    }
    setBusy(false);
    notifyListeners();
  }

  String getEmployeeId(String name){
    var employee = employees.firstWhere((details) => details.employeeName == name);
    return employee.id!;
  }

  List<Waypoints> getChildTableData(){
    return[];

  }

  void changed(RouteMasterData? route){
    selectedRoute = route?.name;
    var routeId = getRouteId(selectedRoute!);
  getRouteDetails(routeId);
   waypoints.addAll(route?.wayPoints?.toList() ?? []);
   notifyListeners();
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

  Future<void> assignRoute(BuildContext context,Map<String, dynamic> payload) async {
    setBusy(true);
    bool res=false;
    res=await RouteServices().assignRoute(payload);
    if (res) {
      if (context.mounted) {
        setBusy(false);
        Navigator.pop(context);
      }}
    setBusy(false);
  }

  Future<void> editRoute(BuildContext context,String assignmentId,Map<String, dynamic> payload) async {
    setBusy(true);
    bool res=false;
    res = await RouteServices().editAssignRoute(context,assignmentId,payload);
    if (res) {
      if (context.mounted) {
        setBusy(false);
        Navigator.pop(context);
        Navigator.pop(context);
      }}
    setBusy(false);
  }


  Future<RouteMaster> getRouteDetails(String route_Id) async {
    return await RouteServices().getRouteDetails(route_Id);

  }


  String getRouteId(String name){
    var routeId = routes.firstWhere((details) => details.routeName == name);
    return routeId.name!;
  }



}