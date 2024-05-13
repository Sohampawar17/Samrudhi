import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../model/visit_list_model.dart';
import '../../../router.router.dart';
import '../../../services/list_visit_services.dart';

class VisitViewModel extends BaseViewModel{

  List<VisitListModel> visitList=[];
  String time ="";


  initialise(BuildContext context) async {
    setBusy(true);

    visitList=await ListVisitServices().fetchVisit();

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


}