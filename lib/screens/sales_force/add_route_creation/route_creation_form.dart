import 'package:flutter/material.dart';
import 'package:geolocation/screens/sales_force/add_route_creation/route_creation_view_model.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import '../../../model/get_teritorry_details.dart';
import '../../../widgets/drop_down.dart';



class RouteCreationForm extends StatefulWidget {
  @override
  _RouteCreationFormState createState() => _RouteCreationFormState();
}

class _RouteCreationFormState extends State<RouteCreationForm> {
  final TextEditingController _routeNameController = TextEditingController();
  final TextEditingController _startingLocationController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  TerritoryData? selectedValue;
  String? selectedWaypoint;
 // List<CustomerTerritoryData> _waypoints = [];
  List<TerritoryData> _territoryList = [];
  //
  // @override
  // void initState() {
  //   super.initState();
  //   // Assuming getCustomerRoute() is a method to retrieve customer routes
  //   getCustomerRoute().then((customerList) {
  //     setState(() {
  //       _waypoints = customerList;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RouteCreationViewModel>.reactive(
        viewModelBuilder: () => RouteCreationViewModel(),
        onViewModelReady: (viewModel) => viewModel.initialise(context),
    builder: (context, viewModel, child) => Scaffold(
      appBar: AppBar(
        title: Text('Route Creation'),
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
                  controller: _routeNameController,
                  decoration: InputDecoration(labelText: 'Route Name'),
                ),
                SizedBox(height: 20),
                // TextFormField(
                //   controller: _startingLocationController,
                //   decoration: InputDecoration(labelText: 'Starting Location'),
                // ),
                // SizedBox(height: 20),
                // TextFormField(
                //   controller: _destinationController,
                //   decoration: InputDecoration(labelText: 'Destination'),
                // ),
                // SizedBox(height: 20),
          
                const Text(
                  'Waypoints:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                CustomDropdownButton2(value:selectedWaypoint,items: viewModel.getTerritoryNames(), hintText:"Select Territory", onChanged:(newValue) { selectedWaypoint = newValue;}, labelText:"Territories" ),
                SizedBox(height: 20),
          
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _territoryList.asMap().entries.map((entry) {
                    final index = entry.key;
                    final territory = entry.value;
          
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index != 0) _buildTimelineLine(), // Add line between dots
                        Row(
                          children: [
                            _buildTimelineDot(),
                            SizedBox(width: 10), // Add some space between dot and title
                            _buildTimelineTitle(territory.territoryName!),
                          ],
                        ),
                        // Add a divider between each timeline event
                      ],
                    );
                  }).toList(),
                ),
                // ListView.builder(
                //   itemCount: _territoryList.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     return Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //       child: Column(
                //         children: [
                //           _buildTimelineDot(),
                //           _buildTimelineTitle(_territoryList[index].territoryName!),
                //           SizedBox(height: 10),
                //           Divider(), // Add a divider between each timeline event
                //         ],
                //       ),
                //     );
                //   },
                // ),


                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _territoryList.add(TerritoryData(territoryName:selectedWaypoint!));
                    });
                  },
                  child: Text('Add Waypoint'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Save route data
                    String routeName = _routeNameController.text;
                    String startingLocation = _startingLocationController.text;
                    String destination = _destinationController.text;
                    // Do something with route data
          
                    Map<String, dynamic> payload = {
                      "route_name": routeName,
                      "waypoints": _territoryList.map((waypoint) {
                        return {
                          "territory": waypoint.territoryName
                        };
                      }).toList()
                    };
                  viewModel.saveRoute(payload);
          
                  },
                  child: Text('Save Route'),
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
      color: Colors.blue, // Customize the color as needed
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

  List<DropdownMenuItem<TerritoryData>> _buildDropdownItems(List<TerritoryData> _waypoints) {
    return _waypoints.map((waypoint) {
      return DropdownMenuItem<TerritoryData>(
        value: waypoint,
        child: Text(waypoint.territoryName!),
      );
    }).toList();
  }
}
