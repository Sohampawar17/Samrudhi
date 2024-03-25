import 'package:flutter/material.dart';
import 'package:geolocation/model/create_customer_model.dart';
import 'package:stacked/stacked.dart';

import '../../../services/add_customer_services.dart';
import '../../../services/call_services.dart';

class UpdateCustomerViewModel extends BaseViewModel{
CreateCustomer customerData=CreateCustomer();
final CallsAndMessagesService service = CallsAndMessagesService();
List<String> comments=[];

List<Order> orders = [
  Order(title: 'Order 1', description: 'Description 1', amount: 50),
  Order(title: 'Order 2', description: 'Description 2', amount: 100),
  Order(title: 'Order 3', description: 'Description 3', amount: 75),
  // Add more orders as needed
];
  initialise(BuildContext context,String id) async {
    setBusy(true);

if(id!=""){
  customerData = await AddCustomerServices().getCustomer(id) ??
      CreateCustomer();
}
setBusy(false);
  }
}

class Order {
  final String title;
  final String description;
  final double amount;

  Order({
    required this.title,
    required this.description,
    required this.amount,
  });
}
