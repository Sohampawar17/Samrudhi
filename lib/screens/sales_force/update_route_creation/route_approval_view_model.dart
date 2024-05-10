import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../model/get_teritorry_details.dart';
import '../../../services/route_services.dart';

class RouteApprovalViewModel extends BaseViewModel{

  bool res = false;
   List<RouteMasterData> routes = [];
  RouteMaster routesAll = RouteMaster();
   String selectedRoute ="";
   String routeId = "";
  List<String> status=[];

  initialise (BuildContext context, String routeId)async{
    setBusy(true);
     routeId = routeId;
    if(routeId != ""){
      routesAll =  await RouteServices().getRouteDetails(routeId);
      status=routesAll.nextAction ?? [];
      // status=await AddPaymentServices().getStatus();
      status=status.toSet().toList();
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

  Color getColorForStatus(String status) {
    switch (status) {
      case 'Draft':
        return Colors.blueGrey; // Light Blue Grey for Lead
    // Light Green for Interested
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;  // Dark Grey for Converted
      case 'Cancelled':
        return Colors.red; // Red for Do Not Contact
      default:
        return Colors.blue; // Default Grey for unknown status
    }
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
  Future<void> changeState(BuildContext context,String? action) async {
    setBusy(true);
    bool res = false;
    res = await RouteServices().changeWorkflow(routesAll.name,action);
    if (res) {
      initialise(context,routesAll.name.toString());
    }
    notifyListeners();
    setBusy(false);
  }


}