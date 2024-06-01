import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../model/add_leave_model.dart';
import '../../../services/add_leave_services.dart';

class UpdateLeaveViewModel extends BaseViewModel{

  AddLeaveModel leavedata =AddLeaveModel();
  List<String> status=[];
  initialise(BuildContext context,String id) async {
    setBusy(true);
      leavedata=await AddLeaveServices().getLeave(id) ?? AddLeaveModel();
    status=leavedata.nextAction ?? [];
    status=status.toSet().toList();
    setBusy(false);
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
        return Colors.grey; // Default Grey for unknown status
    }
  }

  Future<void> changeState(BuildContext context,String? action) async {
    setBusy(true);
    bool res = false;
    res = await AddLeaveServices().changeWorkflow(leavedata.name,action);
    if (res) {
      initialise(context,leavedata.name.toString());
    }
    notifyListeners();
    setBusy(false);
  }
}