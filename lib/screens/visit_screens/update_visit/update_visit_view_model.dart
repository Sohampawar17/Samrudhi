
import 'package:flutter/cupertino.dart';
import 'package:geolocation/model/add_visit_model.dart';
import 'package:geolocation/services/add_visit_services.dart';
import 'package:stacked/stacked.dart';


class UpdateVisitViewModel extends BaseViewModel{

AddVisitModel visitModel = AddVisitModel();
initialise(BuildContext context,String visitId) async {
  setBusy(true);
  if(visitId !=""){
    visitModel=(await AddVisitServices().getVisit(visitId))!;
    notifyListeners();
  }
  setBusy(false);
 }
}
