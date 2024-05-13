import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:stacked/stacked.dart';

import '../../../constants.dart';
import '../../../model/get_teritorry_details.dart';
import '../../../services/route_services.dart';
import 'package:http/http.dart' as http;

class RouteApprovalViewModel extends BaseViewModel{

  bool res = false;
   List<RouteMasterData> routes = [];
  RouteMaster routesAll = RouteMaster();
   String selectedRoute ="";
  String routeId = "";
  List<String> status=[];
  List<LatLng> points = [];
  List<TerritoryData> territories = [];

  initialise (BuildContext context, String routeId)async{
    setBusy(true);
     routeId = routeId;
    if(routeId != ""){
      routesAll =  await RouteServices().getRouteDetails(routeId);
      if (routesAll.waypoints != null) {
        getCoordinates(routesAll.waypoints!);
      }
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



  getCoordinates(List<Waypoints> location) async {
    List listOfPoints = [];
    if (location.isNotEmpty) {
      var response = await http.get(getRouteWaypoints(location));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        listOfPoints = data['features'][0]['geometry']['coordinates'];
        points = listOfPoints
            .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
            .toList();
      }
    } else {
      // Handle the case where the location list is empty
    }
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