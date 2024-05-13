import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocation/model/customer_visit_model.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:stacked/stacked.dart';

import '../../../constants.dart';
import '../../../model/employee_list.dart';
import '../../../model/visit_list_model.dart';
import '../../../router.router.dart';
import '../../../services/list_visit_services.dart';
import 'package:http/http.dart' as http;

import '../../../services/route_services.dart';

class CustomerVisitViewModel extends BaseViewModel{

  CustomerVisitModel customerVisit = CustomerVisitModel([], []);
  List<ActualRoute> actualRoutes = [];
  List<PlannedRoute> plannedRoutes = [];

  List<LatLng> actualPoints = [];
  List<LatLng> plannedPoints = [];
  List<String> customer=[""];
  List<EmployeeAssignerDetails> employees = [];
  String? _selectedEmployee;

  String? get selectedEmployee => _selectedEmployee;

  Future<void> assignSelectedEmployee(String employee) async {
    setBusy(true);
    _selectedEmployee = employee;
    customerVisit= await ListVisitServices().getCustomerVisitReport(formatDate(_selectedDate??DateTime.now()),getEmployeeId(_selectedEmployee ??""));
    actualRoutes.addAll(customerVisit.actualRoutes.toList()??[]);
    plannedRoutes.addAll(customerVisit.plannedRoutes.toList()??[]);
    await getCoordinates(customerVisit.actualRoutes ?? []);

    await getCoordinatesForPlannedRoute(customerVisit.plannedRoutes ?? []);
    setBusy(false);
    notifyListeners();
  }


  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;

  Future<void> updateSelectedDate(DateTime newDate) async {
    setBusy(true);
    _selectedDate = newDate;
    customerVisit= await ListVisitServices().getCustomerVisitReport(formatDate(_selectedDate??DateTime.now()),getEmployeeId(_selectedEmployee ??""));
    actualRoutes.addAll(customerVisit.actualRoutes.toList()??[]);
    plannedRoutes.addAll(customerVisit.plannedRoutes.toList()??[]);
    await getCoordinates(customerVisit.actualRoutes ?? []);

    await getCoordinatesForPlannedRoute(customerVisit.plannedRoutes ?? []);
    setBusy(false);
    notifyListeners();
  }

  initialise() async {
    setBusy(true);
    employees = await RouteServices().getEmployeeList();
    _selectedEmployee= employees[0].employeeName;
    print(selectedDate.toString());
    customerVisit= await ListVisitServices().getCustomerVisitReport(formatDate(_selectedDate??DateTime.now()),getEmployeeId(_selectedEmployee ??""));
    actualRoutes.addAll(customerVisit.actualRoutes.toList()??[]);
    plannedRoutes.addAll(customerVisit.plannedRoutes.toList()??[]);
    await getCoordinates(customerVisit.actualRoutes ?? []);

    await getCoordinatesForPlannedRoute(customerVisit.plannedRoutes ?? []);
    notifyListeners();
    setBusy(false);
  }
  String getEmployeeId(String name){
    var employee = employees.firstWhere((details) => details.employeeName == name);
    return employee.id!;
  }
  String formatDate(DateTime dateTime){
    DateFormat formatter = DateFormat('yyyy-MM-dd'); // Change the format as needed
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
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

  void onRowClick(BuildContext context, VisitListModel? visitList) {
    Navigator.pushNamed(
      context,
      Routes.addVisitScreen,
      arguments: AddVisitScreenArguments(VisitId: visitList?.name ?? ""),
    );
  }

  getCoordinates(List<ActualRoute> location) async {
    List listOfPoints = [];
    if (location.isNotEmpty) {
      // Requesting for openrouteservice API
      // var response = await http.get(getRouteUrl(
      //   "${location[0].longitude},${location[0].latitude}",
      //   "${location.last.longitude},${location.last.latitude}",
      // ));
      var response = await http.get(getRouteUrlForAllActualPoints(location));

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
    List listOfPoints = [];
    if (location.isNotEmpty) {
      // Requesting for openrouteservice API
      // var response = await http.get(getRouteUrl(
      //   "${location[0].longitude},${location[0].latitude}",
      //   "${location.last.longitude},${location.last.latitude}",
      // ));
      //
      var response = await http.get(getRouteUrlForAllPoints(location));

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