import 'package:flutter/cupertino.dart';
import 'package:geolocation/model/employee_list.dart';
import 'package:geolocation/model/get_teritorry_details.dart';
import 'package:stacked/stacked.dart';
import '../../../services/route_services.dart';

class RouteCreationViewModel extends BaseViewModel{

  bool res = false;
  List<TerritoryData> territories = [];
  List<String> employeeNames = [];
  List<EmployeeAssignerDetails> employees = [];
  RouteMaster routesAll = RouteMaster();
  List<Waypoints> waypoints =[];
  TextEditingController routeNameController=TextEditingController();

  initialise (BuildContext context, String routeId)async{
    setBusy(true);
    territories = await RouteServices().getTerritory();
    if(routeId.isNotEmpty){
      routesAll =  await RouteServices().getRouteDetails(routeId);
      routeNameController.text= routesAll.routeName!;
      waypoints = routesAll.waypoints!;
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> saveRoute(Map<String, dynamic> payload) async {
    setBusy(true);
    await RouteServices().saveRoute(payload);
    setBusy(false);
  }

  Future<void> updateRoute(String name,Map<String, dynamic> payload) async {
    setBusy(true);
    await RouteServices().editRoute(name,payload);
    setBusy(false);
  }

  void addWaypoint(String territory) {
    if (routesAll.waypoints != null) {
      // Create a new list with the updated waypoints
      List<Waypoints> updatedWaypoints = List.from(routesAll.waypoints!);
      updatedWaypoints.add(Waypoints(territory: territory));

      // Update the waypoints list in routesAll
      routesAll.waypoints = updatedWaypoints;
      notifyListeners(); // Assuming ViewModel extends ChangeNotifier
    }
  }


  List<String> getTerritoryNames(){
    if (territories.isEmpty) {
      return [];
    }
    return territories
        .where((item) => item.territoryName != null && item.territoryName!.isNotEmpty)
        .map((item) => item.territoryName.toString())
        .toList();
  }

  TerritoryData getTerritoryDetails(String name){
    var territory = territories.firstWhere((details) => details.territoryName == name);
    return territory;
  }



}