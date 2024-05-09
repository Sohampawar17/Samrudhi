
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/sales_force/route_assignment_viewmodel.dart';
import 'package:geolocation/widgets/drop_down.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../model/get_teritorry_details.dart';


class RouteAssignmentForm extends StatefulWidget {
  @override
  _RouteAssignmentFormState createState() => _RouteAssignmentFormState();
}

class _RouteAssignmentFormState extends State<RouteAssignmentForm> {
  final TextEditingController _routeNameController = TextEditingController();
  final TextEditingController _startingLocationController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  String? selectedEmployee;
  String? selectedRoute;
  CustomerTerritoryData? selectedValue;
  List<CustomerTerritoryData> _waypoints = [];
  DateTime firstDate = DateTime.now().subtract(Duration(days: 30)); // One year ago from now
  DateTime lastDate = DateTime.now().add(Duration(days: 30));
  DateTime? selectedDate ;


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RouteAssignmentViewModel>.reactive(
      viewModelBuilder: () => RouteAssignmentViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialise(context),
      builder: (context, viewModel, child) => Scaffold(
      appBar: AppBar(
        title: Text('Route Assignment'),
      ),
      body: fullScreenLoader(
        loader: viewModel.isBusy,
        context: context,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                CustomDropdownButton2(value:selectedEmployee,items: viewModel.getEmployeeNames(), hintText:"Select Employee", onChanged:(newValue) { selectedEmployee = newValue;}, labelText:"Employees" ),
                const SizedBox(height: 10),
                CustomDropdownButton2(value:selectedRoute,
                    items: viewModel.getRouteNames(), hintText:"Select Route",
                    onChanged:(newValue) {
                  selectedRoute = newValue;
                  var routeId = viewModel.getRouteId(selectedRoute!!);
                //  viewModel.getRouteDetails(routeId);
                  print(selectedRoute);}, labelText:"Routes" ),

                const SizedBox(height: 10),
                CalendarDatePicker(initialDate: DateTime.now(),  onDateChanged: (newDate){ selectedDate =newDate;}, firstDate: firstDate,lastDate: lastDate),
                const SizedBox(height: 10),


                ElevatedButton(
                  onPressed: () {
                    // Save route data
                    print(selectedEmployee);
                    Map<String, dynamic> payload = {

                      "datetime": formatDate(selectedDate!),
                      "route_name": selectedRoute!,
                      "employee_name": selectedEmployee!,
                      "employee":viewModel.getEmployeeId(selectedEmployee!),
                      "route_master": selectedRoute!,
                    };

                    viewModel.assignRoute(payload);
                  },
                  child: Text('Assign Route'),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  String formatDate(DateTime dateTime){
    DateFormat formatter = DateFormat('yyyy-MM-dd'); // Change the format as needed
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  String formatDateToServerFormat(DateTime date) {
    return "${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}";
  }

  String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }



}

