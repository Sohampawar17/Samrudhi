
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/sales_force/route_assignment_viewmodel.dart';
import 'package:geolocation/widgets/drop_down.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../model/get_teritorry_details.dart';
import '../../widgets/text_button.dart';


class UpdateRouteAssignmentForm extends StatefulWidget {
  final String assignmentId;
  UpdateRouteAssignmentForm({required this.assignmentId});

  @override
  _UpdateRouteAssignmentFormState createState() => _UpdateRouteAssignmentFormState();
}

class _UpdateRouteAssignmentFormState extends State<UpdateRouteAssignmentForm> {

  String? selectedEmployee;

  CustomerTerritoryData? selectedValue;
  DateTime firstDate = DateTime.now().subtract(Duration(days: 30)); // One year ago from now
  DateTime lastDate = DateTime.now().add(Duration(days: 30));
  DateTime? selectedDate ;


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RouteAssignmentViewModel>.reactive(
        viewModelBuilder: () => RouteAssignmentViewModel(),
        onViewModelReady: (viewModel) => viewModel.initialise(context,widget.assignmentId),
        builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Route Reassignment'),
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
                    CustomDropdownButton2(value:viewModel.selectedEmployee,items: viewModel.getEmployeeNames(), hintText:"Select Employee", onChanged:(newValue) { selectedEmployee = newValue;}, labelText:"Employees" ),
                    const SizedBox(height: 10),
                    CustomDropdownButton2(
                        value:viewModel.selectedRoute,
                        items: viewModel.getRouteNames(), hintText:"Select Route",
                        onChanged:(newValue) {
                          var routeId = viewModel.routes.firstWhere((details) => details.routeName == newValue);
                          viewModel.changed(routeId);}, labelText:"Routes" ),
                    const SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: viewModel.waypoints.asMap().entries.map((entry) {
                        final index = entry.key;
                        final territory = entry.value;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (index != 0)
                              _buildTimelineLine(), // Add line between dots
                            Row(
                              children: [
                                _buildTimelineDot(),
                                SizedBox(width: 10), // Add some space between dot and title
                                _buildTimelineTitle(territory.territory!),


                              ],
                            ),
                            // Add a divider between each timeline event
                          ],
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 10),
                    CalendarDatePicker(
                        initialDate: DateTime.now(),  onDateChanged: (newDate){ selectedDate =newDate;}, firstDate: firstDate,lastDate: lastDate),
                    const SizedBox(height: 10),
                    CtextButton(onPressed: ()
                    {

                      Map<String, dynamic> payload = {
                        "name":viewModel.routesAssignment.name,
                        "routes_table": viewModel.waypoints.map((waypoint) {
                          return {"territory": waypoint.territory};
                        }).toList(),
                        "datetime": formatDate(selectedDate ?? DateTime.now()),
                        "route_name": viewModel.selectedRoute ?? "",
                        "employee_name": viewModel.selectedEmployee ?? "",
                        "employee":viewModel.getEmployeeId(viewModel.selectedEmployee!),
                        "routes_master": viewModel.selectedRoute ?? "",
                      };

                      print("route assignment ${payload}");
                      viewModel.editRoute(context,viewModel.routesAssignment.name!,payload);
                    },
                      text: 'Assign Route',
                      buttonColor: Colors.purple.shade900,),

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

  Widget _buildTimelineLine() {
    return Container(
      width: 2,
      height: 20,
      color: Colors.purple.shade900,
    );
  }

  Widget _buildTimelineDot() {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
    );
  }



  Widget _buildTimelineTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }



}


