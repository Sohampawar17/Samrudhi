import 'package:flutter/material.dart';
import 'package:geolocation/model/list_lead_model.dart';
import 'package:geolocation/services/list_lead_services.dart';
import 'package:stacked/stacked.dart';

import '../../../router.router.dart';

class LeadListViewModel extends BaseViewModel{
List<ListLeadModel> leadlist=[];
List<String> customerlist=[];
List<String> territorylist=[];
List<ListLeadModel> filterleadlist=[];
  initialise(BuildContext context) async {
    setBusy(true);
leadlist= await ListLeadServices().fetchleadlist();
    customerlist=await ListLeadServices().getcustomer();
    territorylist=await ListLeadServices().fetchterritory();
    filterleadlist=leadlist;
notifyListeners();
setBusy(false);
  }

Future<void> refresh() async {
  leadlist=await ListLeadServices().fetchleadlist();

  notifyListeners();
}

Color getColorForStatus(String status) {
  switch (status) {
    case 'Lead':
      return Colors.blueGrey[300] ?? Colors.grey; // Light Blue Grey for Lead
    case 'Open':
      return Colors.amber; // Amber for Open
    case 'Replied':
      return Colors.deepOrangeAccent; // Deep Orange Accent for Replied
    case 'Opportunity':
      return Colors.indigo; // Indigo for Opportunity
    case 'Quotation':
      return Colors.green; // Teal for Quotation
    case 'Lost Quotation':
      return Colors.redAccent; // Green for Lost Quotation
    case 'Interested':
      return Colors.lightGreen.shade200; // Light Green for Interested
    case 'Converted':
      return Colors.lightGreen[800] ?? Colors.lightGreen; // Dark Grey for Converted
    case 'Do Not Contact':
      return Colors.red; // Red for Do Not Contact
    default:
      return Colors.grey; // Default Grey for unknown status
  }
}


 void onRowClick(BuildContext context, ListLeadModel? leadList) {
    Navigator.pushNamed(
      context,
      Routes.updateLeadScreen,
     arguments: UpdateLeadScreenArguments(updateId: leadList?.name.toString() ?? ""),
    );
  }

String? custm;
String? territory;

void setcustomer(String? customer) {
  custm = customer ?? "";
  notifyListeners();
}

void setqterritory(String? quotation) {
  territory = quotation ?? "";
  notifyListeners();
}

void setfilter(String territory,String customer) async {
  filterleadlist= await ListLeadServices().fetchfilterquotation(territory, customer);
  notifyListeners();
}

void clearfilter() async {
  territory="";
  custm="";
  filterleadlist= await ListLeadServices().fetchleadlist();
  notifyListeners();
}
}