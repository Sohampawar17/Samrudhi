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

  initialise (BuildContext context)async{
    setBusy(true);
    territories = await RouteServices().getTerritory();
    setBusy(false);
    notifyListeners();
  }

  Future<void> saveRoute(Map<String, dynamic> payload) async {
    setBusy(true);
    await RouteServices().saveRoute(payload);
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