import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../constants.dart';
import '../../model/gelocation_model.dart';
import '../../services/checkin_services.dart';
import 'package:http/http.dart' as http;

class GeolocationViewModel extends BaseViewModel {
  List<LocationTable> locations = [];
  List<String> leadlist = [""];
  GeolocationModel geolocationdata = GeolocationModel();
  String locationid = "";
  List<LocationTable> parsedLocationTables=[];
  void initialise(BuildContext context) async {
    setBusy(true);
    List<Map<String, dynamic>> routeLocation =[

    {
    "name": "e8d87ff1e0",
    "owner": "soham.pawar@erpdata.in",
    "creation": "2024-03-06 17:26:36.921211",
    "modified": "2024-03-06 17:26:36.921211",
    "modified_by": "soham.pawar@erpdata.in",
    "docstatus": 0,
    "idx": 2,
    "longitude": "74.55513000488281",
    "latitude": "16.77973175048828",
    "parent": "soham.pawar@erpdata.in-2024-03-06",
    "parentfield": "location_table",
    "parenttype": "Employee Location",
    "doctype": "employee location table"
    },
    {
    "name": "d435963408",
    "owner": "soham.pawar@erpdata.in",
    "creation": "2024-03-06 17:26:36.921211",
    "modified": "2024-03-06 17:26:36.921211",
    "modified_by": "soham.pawar@erpdata.in",
    "docstatus": 0,
    "idx": 3,
    "longitude": "74.4211932",
    "latitude": "16.7477491",
    "parent": "soham.pawar@erpdata.in-2024-03-06",
    "parentfield": "location_table",
    "parenttype": "Employee Location",
    "doctype": "employee location table"
    },
    {
    "name": "8cbcd60ab9",
    "owner": "soham.pawar@erpdata.in",
    "creation": "2024-03-06 17:26:36.921211",
    "modified": "2024-03-06 17:26:36.921211",
    "modified_by": "soham.pawar@erpdata.in",
    "docstatus": 0,
    "idx": 4,
    "longitude": "74.3152571",
    "latitude": "16.5750891",
    "parent": "soham.pawar@erpdata.in-2024-03-06",
    "parentfield": "location_table",
    "parenttype": "Employee Location",
    "doctype": "employee location table"
    },
    {
    "name": "e5fecc12c4",
    "owner": "soham.pawar@erpdata.in",
    "creation": "2024-03-06 17:26:36.921211",
    "modified": "2024-03-06 17:26:36.921211",
    "modified_by": "soham.pawar@erpdata.in",
    "docstatus": 0,
    "idx": 5,
    "longitude": "74.2405329",
    "latitude": "16.7028412",
    "parent": "soham.pawar@erpdata.in-2024-03-06",
    "parentfield": "location_table",
    "parenttype": "Employee Location",
    "doctype": "employee location table"
    },
    {
    "name": "223eeaf43e",
    "owner": "soham.pawar@erpdata.in",
    "creation": "2024-03-06 17:26:36.921211",
    "modified": "2024-03-06 17:26:36.921211",
    "modified_by": "soham.pawar@erpdata.in",
    "docstatus": 0,
    "idx": 6,
    "longitude": "74.6046248",
    "latitude": "16.8501169",
    "parent": "soham.pawar@erpdata.in-2024-03-06",
    "parentfield": "location_table",
    "parenttype": "Employee Location",
    "doctype": "employee location table"
    }
    ];

    parsedLocationTables = routeLocation.map<LocationTable>((json) {
      return LocationTable.fromJson(json);
    }).toList();


    geolocationdata =
        await CheckinServices().getmember(locationid) ?? GeolocationModel();

    locations.addAll(geolocationdata.locationTable?.toList() ?? []);
    getCoordinates(geolocationdata.locationTable ?? []);
    Logger().i(geolocationdata.locationTable.toString());
    notifyListeners();
    setBusy(false);
  }

  List listOfPoints = [];

// Conversion of listOfPoints into LatLng(Latitude, Longitude) list of points
  List<LatLng> points = [];

// Method to consume the OpenRouteService API
  getCoordinates(List<LocationTable> location) async {
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
    notifyListeners();
  }

// Handle directionsResponse
  void onMapReady() async {

    geolocationdata =
        await CheckinServices().getmember(locationid) ?? GeolocationModel();
    // leadlist = await homeservices().fetchLead();
    locations.addAll(geolocationdata.locationTable?.toList() ?? []);
  }
}
