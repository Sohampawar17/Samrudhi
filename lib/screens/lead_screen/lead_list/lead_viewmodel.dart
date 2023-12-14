import 'package:flutter/material.dart';
import 'package:geolocation/model/list_lead_model.dart';
import 'package:geolocation/services/list_lead_services.dart';
import 'package:stacked/stacked.dart';

import '../../../router.router.dart';

class LeadListViewModel extends BaseViewModel{
List<ListLeadModel> leadlist=[];
  initialise(BuildContext context) async {
    setBusy(true);
leadlist= await ListLeadServices().fetchleadlist();

notifyListeners();
setBusy(false);
  }

Future<void> refresh() async {
  leadlist=await ListLeadServices().fetchleadlist();
  notifyListeners();
}

 void onRowClick(BuildContext context, ListLeadModel? leadList) {
    Navigator.pushNamed(
      context,
      Routes.updateLeadScreen,
     arguments: UpdateLeadScreenArguments(updateId: leadList?.name.toString() ?? ""),
    );
  }

}