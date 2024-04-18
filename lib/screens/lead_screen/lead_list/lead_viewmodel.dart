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
    customerlist=await ListLeadServices().getCustomer();
    filterleadlist=leadlist;
notifyListeners();
setBusy(false);
  }

List<String> requestType=[
  "Enquiry for retailer",
  "Enquiry as a distributor",
  "Product Enquiry",
  "Enquiry as supplier",
  "Enquiry as bulk product",
  "Customer Complaint",
  "Non Relevant"
];

Future<void> refresh() async {
  leadlist=await ListLeadServices().fetchleadlist();

  notifyListeners();
}

Color getColorForStatus(String status) {
  switch (status) {
    case 'Lead':
      return Colors.blueGrey; // Light Blue Grey for Lead
    case 'Open':
      return Colors.deepOrangeAccent; // Amber for Open
    case 'Replied':
      return Colors.amberAccent; // Deep Orange Accent for Replied
    case 'Opportunity':
      return Colors.indigo; // Indigo for Opportunity
    case 'Quotation':
      return Colors.lightGreen; // Teal for Quotation
    case 'Lost Quotation':
      return Colors.redAccent; // Green for Lost Quotation
    case 'Interested':
      return Colors.lightGreen.shade200; // Light Green for Interested
    case 'Converted':
      return Colors.green; // Dark Grey for Converted
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

String? request;

void setcustomer(String? customer) {
  custm = customer ?? "";
  notifyListeners();
}


void setRequest(String? customer) {
  request = customer ?? "";
  notifyListeners();
}

void setfilter(String customer,String request) async {
  filterleadlist= await ListLeadServices().fetchfilterquotation(customer,request);
  notifyListeners();
}

void clearfilter() async {
request="";
  custm="";
  filterleadlist= await ListLeadServices().fetchleadlist();
  notifyListeners();
}
}