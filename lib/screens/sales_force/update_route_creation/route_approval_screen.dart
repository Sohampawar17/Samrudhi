import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocation/screens/sales_force/update_route_creation/route_approval_view_model.dart';
import 'package:geolocation/screens/sales_force/update_route_creation/update_route_screen.dart';

import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:latlong2/latlong.dart';

import 'package:stacked/stacked.dart';

import '../../../model/get_teritorry_details.dart';
import '../../../router.router.dart';


class RouteApprovalScreen extends StatefulWidget {

  final String routeId;
   const RouteApprovalScreen({super.key, required this.routeId});

  @override
  _RouteApprovalScreenState createState() => _RouteApprovalScreenState();
}

class _RouteApprovalScreenState extends State<RouteApprovalScreen> {
  List<TerritoryData> territoryList = [];
  TextEditingController routeNameController = TextEditingController();
  String? _workflowStatus;
  String? selectedWaypoint;
  List<LatLng> points = [];
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<RouteApprovalViewModel>.reactive(
      viewModelBuilder: () => RouteApprovalViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialise(context,widget.routeId),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text("Route Approval"),
          actions: viewModel.routesAll.workflowState == "Pending"
          ? [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => RouteUpdateScreen(routeId: widget.routeId)));
              },
            ),
          ]
              : [],
        ),
        body: fullScreenLoader(
          loader: viewModel.isBusy,
          context: context,
          child: viewModel.routesAll.routeName != null ? SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
          
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(flex: 4,
                      child: AutoSizeText(
                        viewModel.routesAll.name ?? "",

                        style: const TextStyle(
                          fontSize: 17,
                            fontWeight:
                            FontWeight.w500,
                            color: Colors.blueAccent
                        ),),
                    ),
                    Expanded(
                        flex: 3,
                        child: Container(

                          decoration: BoxDecoration(
                            border: Border.all(color:Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Card(
                            color:  viewModel.getColorForStatus(viewModel.routesAll.workflowState.toString()),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      viewModel.routesAll.workflowState ?? "",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                PopupMenuButton(
                                  color: Colors.white,
                                  icon:  Icon(Icons.arrow_drop_down),
                                  itemBuilder: (BuildContext context) =>
                                      viewModel.status.map<PopupMenuItem<String>>((String item) {
                                        // Populate menu items from fetched data
                                        return PopupMenuItem<String>(
                                          value: item,
                                          child: Text(item,
                                          style: TextStyle(color: Colors.black),),
                                        );
                                      }).toList(),
                                  onSelected: (value) {
                                    viewModel.changeState(context,value);
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                  ],
                ),
                Divider(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Zone',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            viewModel.routesAll.zone ?? "--",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Region",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            viewModel.routesAll.region??"--",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Area",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      viewModel.routesAll.area??"--",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                const Text(
                  'Waypoints',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,

                  children:  viewModel.routesAll.waypoints != null
                      ?viewModel.routesAll.waypoints!.asMap().entries.map((entry) {
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
                            const SizedBox(width: 10), // Add some space between dot and title
                            _buildTimelineTitle(territory.territory!),
                          ],
                        ),
                        // Add a divider between each timeline event
                      ],
                    );
                  }).toList():[],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), // Add rounded corners

                  ),// Set a specific height here
                  child: buildMap(context, viewModel),
                ),


              ]
            ),
          ):const Padding(
              padding: EdgeInsets.all(16),
              child: Text(textAlign: TextAlign.center,"Sorry, Data is not available or You don't have permission to access for it.")),
        ),

      ),
    );
  }

  Widget buildMap(BuildContext context, RouteApprovalViewModel viewModel) {
    final waypoints = viewModel.routesAll.waypoints;
    if (waypoints == null || waypoints.isEmpty) {
      return const SizedBox(); // Return an empty widget if no waypoints available
    }

    final firstWaypoint = waypoints[0];
    final initialLatitude = firstWaypoint.latitude ?? 0.0; // Set default latitude
    final initialLongitude = firstWaypoint.longitude ?? 0.0; // Set default longitude

    print("Initial Latitude: $initialLatitude, Longitude: $initialLongitude");

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: LatLng(initialLatitude, initialLongitude), // Center map on the first waypoint
        zoom: 9,
        //onMapReady: () => viewModel.initialise(context, widget.routeId),
        onPositionChanged: (MapPosition pos, bool isGesture) {
          // Perform actions once the map is ready
          // For example, load markers here
          _buildMarkers(viewModel);
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(markers: _buildMarkers(viewModel)),

        if(viewModel.routesAll.waypoints!.isNotEmpty)
        PolylineLayer(
          polylineCulling: true,
          polylines: [
            Polyline(
              isDotted: false,
              points: viewModel.routesAll.waypoints!.map((e) {
                // Access latitude and longitude from the map
                final lat = e.latitude ?? 0.0; // Set default latitude
                final lng = e.longitude ?? 0.0; // Set default longitude

                return LatLng(lat, lng);
              }).toList(),
              color: Colors.blueAccent,
              strokeWidth: 5,
            )
          ],
        ),
      ],
    );
  }


  List<Marker> _buildMarkers(RouteApprovalViewModel viewModel) {
    final waypoints = viewModel.routesAll.waypoints;
    if (waypoints == null || waypoints.isEmpty) {
      return []; // Return an empty list if waypoints are null or empty
    }

    return waypoints.map((location) {
      final lat = location.latitude;
      final lng = location.longitude;

      // Check for null values in latitude and longitude
      if (lat == null || lng == null || lat.isNaN || lng.isNaN) {
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
                    location.territory ?? '', // Provide a default value for territory
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


  Widget buildItemColumn(
      {required String additionalText, required String labelText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          labelText, style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),minFontSize: 18,),
        AutoSizeText(
            additionalText, style: const TextStyle(fontWeight: FontWeight.w500),minFontSize: 17),
      ],
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
      decoration: const BoxDecoration(
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
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
  }

}
