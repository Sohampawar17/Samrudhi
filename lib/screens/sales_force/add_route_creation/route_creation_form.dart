import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/screens/sales_force/add_route_creation/route_creation_view_model.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:latlong2/latlong.dart';
import 'package:stacked/stacked.dart';
import '../../../model/get_teritorry_details.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/text_button.dart';



class RouteCreationForm extends StatefulWidget {
  @override
  _RouteCreationFormState createState() => _RouteCreationFormState();
}

class _RouteCreationFormState extends State<RouteCreationForm> {
  final TextEditingController _routeNameController = TextEditingController();
  final TextEditingController _startingLocationController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final MapController mapController = MapController();
  TerritoryData? selectedValue;
  String? selectedWaypoint;
  String? selectedZone;
  String? selectedRegion;
  String? selectedArea;
 // List<CustomerTerritoryData> _waypoints = [];
  List<TerritoryData> _territoryList = [];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RouteCreationViewModel>.reactive(
        viewModelBuilder: () => RouteCreationViewModel(),
        onViewModelReady: (viewModel) => viewModel.initialise(context,""),
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
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdownButton2(
                        value: selectedZone,
                        items: viewModel.zones,
                        hintText: "Select Zone",
                        onChanged: (newValue) {
                          selectedZone = newValue ;
                          viewModel.getRegions(selectedZone!);
                        },
                        labelText: "Zones",
                      ),
                    ),
                    SizedBox(width: 16), // Add space between the dropdowns
                    Expanded(
                      child: CustomDropdownButton2(
                        value: selectedRegion,
                        items: viewModel.regions,
                        hintText: "Select Region",
                        onChanged: (newValue) {
                          selectedRegion = newValue;
                          viewModel.getAreas(selectedRegion!);
                        },
                        labelText: "Regions",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                CustomDropdownButton2(value:selectedArea,items: viewModel.areas, hintText:"Select Area",
                    onChanged:(newValue) {
                      selectedArea = newValue;
                      viewModel.getEndNodes(selectedArea!);
                  }, labelText:"Area" ),
                SizedBox(height: 5),
                const Text(
                  'Waypoints:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                CustomDropdownButton2(value:selectedWaypoint,items: viewModel.endNodes, hintText:"Select Territory", onChanged:(newValue) { selectedWaypoint = newValue;}, labelText:"Territories" ),
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
                        if (index != 0)
                          _buildTimelineLine(), // Add line between dots
                        Row(
                          children: [
                            _buildTimelineDot(),
                            SizedBox(width: 10), // Add some space between dot and title
                            _buildTimelineTitle(territory.territoryName!),
                            IconButton(
                              iconSize: 15,
                              icon: Icon(Icons.close,), // Add your delete icon here
                              onPressed: () {
                                setState(() {
                                  _territoryList.removeAt(index); //
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


                SizedBox(height: 20),
                CtextButton(onPressed: ()
                {
                  setState(() {
                    _territoryList.add(TerritoryData(territoryName:selectedWaypoint!));
                  });

                  },
                  text: 'Add Waypoint',
                  buttonColor: Colors.blue,),

                CtextButton(onPressed: ()
                {
                  String routeName = _routeNameController.text;
                  if(routeName.isEmpty || selectedZone!.isEmpty || selectedArea!.isEmpty || selectedRegion!.isEmpty || _territoryList.length==0 ) {
                    Fluttertoast.showToast(gravity: ToastGravity.BOTTOM,
                      msg: 'Please fill necessary details.',
                      textColor: const Color(0xFFFFFFFF),
                      backgroundColor: const Color(0xFFBA1A1A));
                    return;
                  }

                  Map<String, dynamic> payload = {
                    "route_name": routeName,
                    "zone":selectedZone,
                    "region":selectedRegion,
                    "area":selectedArea,
                    "waypoints": _territoryList.map((waypoint) {
                      return {
                        "territory": waypoint.territoryName
                      };
                    }).toList()
                  };

                  print(payload);
                  viewModel.saveRoute(payload);

                },
                  text: 'Save Route',
                  buttonColor: Colors.blue),
                // Container(
                //   height: 350,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(30), // Add rounded corners
                //
                //   ),// Set a specific height here
                //   child: buildMap(context),
                // ),

              ],
            ),
          ),
        ),
      ),
    ),
    );
  }

  Widget buildMap(BuildContext context) {
    // Check if _territoryList is not empty
    if (_territoryList.isEmpty) {
      return Center(child: Text('No data available'));
    }

    // Get the first waypoint
    final firstWaypoint = _territoryList[0];
    final initialLatitude = double.parse(firstWaypoint.latitude ?? '0.0');
    final initialLongitude = double.parse(firstWaypoint.longitude ?? '0.0');

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: LatLng(initialLatitude, initialLongitude),
        zoom: 9,
        //onMapReady: () => viewModel.initialise(context, widget.routeId),
        onPositionChanged: (MapPosition pos, bool isGesture) {
          // Perform actions once the map is ready
          // For example, load markers here
          _buildMarkers();
        },
      ),
      children: [


      ],
    );
  }


  List<Marker> _buildMarkers() {

    return _territoryList.map((location) {
      final lat = double.parse(location.latitude!);
      final lng = double.parse(location.longitude!);

      // Check for null values in latitude and longitude
      if (lat == null || lng == null) {
        // Provide default coordinates for markers with missing or invalid coordinates
        return Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(0.0, 0.0), // Default coordinates (0, 0)
          builder: (context) {
            return Container(); // Return an empty container for markers with default coordinates
          },
        );
      }

      return Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(lat, lng),
        builder: (context) {
          return Stack(
            children: [
              const Icon(Icons.location_on, size: 50, color: Colors.red),
              Positioned(
                left: 5,
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    location.territoryName ?? '', // Provide a default value for territory
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }).toList();
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

  List<DropdownMenuItem<TerritoryData>> _buildDropdownItems(List<TerritoryData> _waypoints) {
    return _waypoints.map((waypoint) {
      return DropdownMenuItem<TerritoryData>(
        value: waypoint,
        child: Text(waypoint.territoryName!),
      );
    }).toList();
  }
}
