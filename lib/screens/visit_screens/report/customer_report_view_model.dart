import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocation/model/customer_visit_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:stacked/stacked.dart';

import '../../../constants.dart';
import '../../../model/visit_list_model.dart';
import '../../../router.router.dart';
import '../../../services/list_visit_services.dart';
import 'package:http/http.dart' as http;

class CustomerVisitViewModel extends BaseViewModel{

  CustomerVisitModel customerVisit = CustomerVisitModel([], []);
  List listOfPoints = [];
  List<LatLng> actualPoints = [];
  List<LatLng> plannedPoints = [];


  initialise() async {
    setBusy(true);

    customerVisit= await ListVisitServices().getCustomerVisitReport("2024-05-08");
    await getCoordinates(customerVisit.actualRoutes ?? []);
    await getCoordinatesForPlannedRoute(customerVisit.plannedRoutes ?? []);


    notifyListeners();
    setBusy(false);
  }

  void onRowClick(BuildContext context, VisitListModel? visitList) {
    Navigator.pushNamed(
      context,
      Routes.addVisitScreen,
      arguments: AddVisitScreenArguments(VisitId: visitList?.name ?? ""),
    );
  }

  getCoordinates(List<ActualRoute> location) async {
    if (location.isNotEmpty) {
      // Requesting for openrouteservice API
      var response = await http.get(getRouteUrl(
        "${location[0].longitude},${location[0].latitude}",
        "${location.last.longitude},${location.last.latitude}",
      ));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        listOfPoints = data['features'][0]['geometry']['coordinates'];
        actualPoints = listOfPoints
            .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
            .toList();

      }
    } else {
      // Handle the case where the location list is empty
    }
    //notifyListeners();
  }

  getCoordinatesForPlannedRoute(List<PlannedRoute> location) async {
    if (location.isNotEmpty) {
      // Requesting for openrouteservice API
      var response = await http.get(getRouteUrl(
        "${location[0].longitude},${location[0].latitude}",
        "${location.last.longitude},${location.last.latitude}",
      ));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        listOfPoints = data['features'][0]['geometry']['coordinates'];
        plannedPoints = listOfPoints
            .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
            .toList();

      }
    } else {
      // Handle the case where the location list is empty
    }
    //notifyListeners();
  }






}