import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../model/get_teritorry_details.dart';
import '../../services/route_services.dart';

class RouteApprovalViewModel extends BaseViewModel{

  bool res = false;
   List<RouteMasterData> routes = [];
  RouteMaster routesAll = RouteMaster();
   String selectedRoute ="";
   String routeId = "";

  initialise (BuildContext context, String routeId)async{
    setBusy(true);
     routeId = routeId;
    if(routeId != ""){
      routesAll =  await RouteServices().getRouteDetails(routeId);
    }else{
      routes = await RouteServices().getPlannedRoutes("Pending");
    }
    setBusy(false);
    notifyListeners();
  }
  Future<void> refresh() async {
    routes= await RouteServices().getPlannedRoutes("Pending");
    notifyListeners();
  }

  Future<void> ediStatus(String route_Id,Map<String, dynamic> payload) async {
    setBusy(true);
    await RouteServices().editWorkflowState(route_Id,payload);
    setBusy(false);
  }

  void setSelectedString(String value) {
    selectedRoute = value;
    notifyListeners();
  }


}