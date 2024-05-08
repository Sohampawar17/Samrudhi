
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../model/add_lead_model.dart';
import '../../../services/add_lead_services.dart';

class UpdateVisitModel extends BaseViewModel{


AddLeadModel leaddata =AddLeadModel();

initialise(BuildContext context,String leadId) async {
  setBusy(true);
  if(leadId !=""){
    leaddata= await AddLeadServices().getlead(leadId) ?? AddLeadModel();

    notifyListeners();
  }
  setBusy(false);
}

}