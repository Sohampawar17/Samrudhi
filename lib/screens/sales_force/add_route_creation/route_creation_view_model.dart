import 'package:flutter/cupertino.dart';
import 'package:geolocation/model/employee_list.dart';
import 'package:geolocation/model/get_teritorry_details.dart';
import 'package:stacked/stacked.dart';
import '../../../services/route_services.dart';
import '../../../services/territory_services.dart';

class RouteCreationViewModel extends BaseViewModel{

  bool res = false;
  List<TerritoryData> territories = [];
  List<String> employeeNames = [];
  List<EmployeeAssignerDetails> employees = [];
  RouteMaster routesAll = RouteMaster();
  List<Waypoints> waypoints =[];
  TextEditingController routeNameController=TextEditingController();
  List<String> zones = [];
  List<String> regions = [];
  List<String> areas = [];
  List<String> endNodes = [];
  String? selectedZone;
  String? selectedRegion;
  String? selectedArea;

  initialise (BuildContext context, String routeId)async{
    setBusy(true);
    //territories = await RouteServices().getTerritory();
    zones = await TerritoryServices().getZones();
    if(routeId.isNotEmpty){
      routesAll =  await RouteServices().getRouteDetails(routeId);
      selectedZone = routesAll.zone;
      selectedRegion = routesAll.region;
      selectedArea = routesAll.area;
      if(selectedArea!.isNotEmpty){
        getEndNodes(selectedArea!);
      }
      routeNameController.text= routesAll.routeName!;
      waypoints = routesAll.waypoints!;
    }
    setBusy(false);
    notifyListeners();
  }

  void setSelectedZone(String zone){
    selectedZone = zone;
    notifyListeners();
  }

  void setSelectedRegion(String region){
    selectedRegion = region;
    notifyListeners();
  }
  void setSelectedArea(String area){
    selectedArea = area;
    notifyListeners();
  }

  Future<void> saveRoute(Map<String, dynamic> payload) async {
    setBusy(true);
    await RouteServices().saveRoute(payload);
    setBusy(false);
  }

  Future<void> updateRoute(BuildContext context,String name,Map<String, dynamic> payload) async {
    setBusy(true);
    await RouteServices().editRoute(context,name,payload);
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

  Future<void> getZones() async{
   zones = await TerritoryServices().getZones();

  }

   Future<void> getRegions(String zone) async{
    regions = await TerritoryServices().getRegions(zone: zone);
    notifyListeners();
  }

  Future<void> getAreas(String region) async{
    areas= await TerritoryServices().getAreas(region: region);
    notifyListeners();
  }

  Future<void> getEndNodes(String area) async{
    territories= await TerritoryServices().getEndNodes(area);
    endNodes = territories
        .where((item) => item.territoryName != null && item.territoryName!.isNotEmpty)
        .map((item) => item.territoryName.toString())
        .toList();
    notifyListeners();
  }

 void getTerritoryNames(){
    if (territories.isEmpty) {
      return ;
    }
     endNodes = territories
        .where((item) => item.territoryName != null && item.territoryName!.isNotEmpty)
        .map((item) => item.territoryName.toString())
        .toList();
    notifyListeners();
  }

  TerritoryData getTerritoryDetails(String name){
    var territory = territories.firstWhere((details) => details.territoryName == name);
    return territory;
  }

}