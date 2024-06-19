
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
  filterleadlist=await ListLeadServices().fetchleadlist();
  notifyListeners();
}

Color getColorForStatus(String status) {
  switch (status) {
    case 'Enquiry':
      return Colors.blueGrey;
    case 'Interested':
      return Colors.green;
    case 'Not Interested':
      return Colors.red;
    default:
      return Colors.grey;
  }
}


 void onRowClick(BuildContext context, ListLeadModel? leadList) {
     Navigator.pushNamed(
       context,
       Routes.updateLeadScreen,
       arguments: UpdateLeadScreenArguments(updateId: leadList?.name.toString() ?? ""),
     );
   }

void navigateToVisitScreen(BuildContext context, ListLeadModel? leadModel) {
  Navigator.pushNamed(
    context,
    Routes.addVisitScreen,
    arguments: AddVisitScreenArguments( leadModel: leadModel!),
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