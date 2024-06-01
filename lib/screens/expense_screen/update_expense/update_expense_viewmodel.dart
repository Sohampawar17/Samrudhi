import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../model/expense_model.dart';
import '../../../services/add_expense_services.dart';

class UpdateExpenseViewModel extends BaseViewModel{
  ExpenseData expensedata =ExpenseData();
  List<String> status=[];
  initialise(BuildContext context,String id) async {
    setBusy(true);
    expensedata=await AddExpenseServices().getExpense(id) ?? ExpenseData();
    status=expensedata.nextAction ?? [];
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
    res = await AddExpenseServices().changeWorkflow(expensedata.name,action);
    if (res) {
      initialise(context,expensedata.name.toString());
    }
    notifyListeners();
    setBusy(false);
  }
}