import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocation/screens/sales_force/add_route_creation/route_creation_view_model.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import '../../../model/get_teritorry_details.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/text_button.dart';

class RouteUpdateScreen extends StatefulWidget {
  final String routeId;

  RouteUpdateScreen({required this.routeId});

  @override
  _RouteUpdateScreenState createState() => _RouteUpdateScreenState();
}

class _RouteUpdateScreenState extends State<RouteUpdateScreen> {
  final TextEditingController _routeNameController = TextEditingController();

  List<TerritoryData> _territoryList = [];
  String? selectedWaypoint;


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RouteCreationViewModel>.reactive(
      viewModelBuilder: () => RouteCreationViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialise(context, widget.routeId),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('Update Route'),
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
                  TextFormField(
                    controller: viewModel.routeNameController,
                    decoration: InputDecoration(labelText: 'Route Name'),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    'Waypoints:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 10),
                  CustomDropdownButton2(value:selectedWaypoint,items: viewModel.getTerritoryNames(), hintText:"Select Territory", onChanged:(newValue) { selectedWaypoint = newValue;}, labelText:"Territories" ),
                  SizedBox(height: 20),

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
                              IconButton(
                                iconSize: 15,
                                icon: Icon(Icons.close,), // Add your delete icon here
                                onPressed: () {
                                  setState(() {
                                    viewModel.waypoints.removeAt(index); //
                                    // _territoryList.remove(TerritoryData(territoryName:selectedWaypoint!));
                                  });
                                  // Add your delete logic here
                                },
                              ),

                            ],
                          ),
                          // Add a divider between each timeline event
                        ],
                      );
                    }).toList(),
                  ),
                  //
                  SizedBox(height: 20),
                  CtextButton(
                    onPressed: () {
                        viewModel.waypoints.add(Waypoints(territory: selectedWaypoint));
                        viewModel.addWaypoint(selectedWaypoint!);

                    },
                    text: 'Add Waypoint',
                    buttonColor: Colors.purple.shade900,
                  ),
                  CtextButton(
                    onPressed: () {
                      // Save route logic
                      _saveRoute(viewModel);
                    },
                    text: 'Update Route',
                    buttonColor: Colors.purple.shade900,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineLine() {
    return Container(
      width: 2,
      height: 20,
      color: Colors.purple.shade900, // Customize the color as needed
    );
  }

  Widget _buildTimelineDot() {
    return Container(
      width: 10,







      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey, // Customize the color as needed
      ),
    );
  }

  Widget _buildTimelineTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  void _editWaypoint(int index) {
    // Implement the edit logic here
    // For example, you can open a dialog to edit the waypoint details
  }

  void _addWaypoint() {
  }

  void _saveRoute(RouteCreationViewModel viewModel) {
    String routeName = viewModel.routeNameController.text;
    // Save route logic here
    // For example, you can create a payload and call the saveRoute method
    Map<String, dynamic> payload = {
      "name": viewModel.routesAll.name,
      "route_name": routeName,
      "waypoints": viewModel.waypoints.map((waypoint) {
        return {"territory": waypoint.territory};
      }).toList()
    };

    print(payload);
   viewModel.updateRoute(viewModel.routesAll.name!,payload);
  }
}
