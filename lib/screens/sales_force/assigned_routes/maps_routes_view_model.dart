import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../../../constants.dart';
import '../../../model/get_teritorry_details.dart';
import 'package:http/http.dart' as http;

import '../../../services/route_services.dart';

class MapsRoutesViewModel extends BaseViewModel{
  List<RoutesTable> locations = []; // Add this to
  List listOfPoints = [];
  List<LatLng> points = [];

  initialise (BuildContext context,String name)async{
     setBusy(true);
     await fetchLocations(name);
     setBusy(false);
     notifyListeners();
  }

  Future<void> fetchLocations(String name) async {
    RoutesAssignment routesAssignment = await  RouteServices().getRouteTableDetails(name);
    print(routesAssignment.routesTable!.length.toString());
    locations.addAll(routesAssignment.routesTable?.toList()??[]);
    print(locations);
    await getCoordinates(locations);
  }

  getCoordinates(List<RoutesTable> location) async {
    if (location.isNotEmpty) {
      // Requesting for openrouteservice API
      var response = await http.get(getRouteUrl(
        "${location[0].longitude},${location[0].latitude}",
        "${location.last.longitude},${location.last.latitude}",
      ));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        listOfPoints = data['features'][0]['geometry']['coordinates'];
        points = listOfPoints
            .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
            .toList();
        Logger().i(listOfPoints.toString());
      }
    } else {
      // Handle the case where the location list is empty
    }
    //notifyListeners();
  }

}