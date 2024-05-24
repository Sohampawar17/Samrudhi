import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocation/screens/sales_force/assigned_routes/maps_routes_view_model.dart';
import 'package:geolocation/screens/sales_force/update_route_assignment_screen.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';

import '../../../router.router.dart';


class MapsScreen extends StatefulWidget {

  final String name;

  const MapsScreen({super.key, required this.name});

  @override
  State<StatefulWidget> createState() {
    return _MapsScreenState();
  }
}

class _MapsScreenState extends State<MapsScreen> {

  final MapController mapController = MapController();


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapsRoutesViewModel>.reactive(
        viewModelBuilder: () => MapsRoutesViewModel(),
        onViewModelReady: (viewModel) => viewModel.initialise(context,widget.name),
    builder: (context, viewModel, child) => Scaffold(
      appBar: AppBar(
        title: Text('Check Your Routes'),
        actions: [
          IconButton(onPressed: ()=> {
    Navigator.push(
    context, MaterialPageRoute(builder: (_) => UpdateRouteAssignmentForm(assignmentId:widget.name))

    ) }, icon: Icon(Icons.edit))
        ],

      ),
      body: fullScreenLoader(
        loader: viewModel.isBusy,
        context: context,
        child: Container(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: viewModel.locations.asMap().entries.map((entry) {
                    final index = entry.key;
                    final routeWay = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index != 0) _buildTimelineLine(), // Add line between dots
                        Row(
                          children: [
                            _buildTimelineDot(),
                            SizedBox(width: 10), // Add some space between dot and title
                            _buildTimelineTitle(routeWay.territory!),
                          ],
                        ),
                        // Add a divider between each timeline event
                      ],
                    );
                  }).toList(),
                ),
                ),


              Expanded(child:  viewModel.locations.isNotEmpty
                  ?buildMap(viewModel): Container(
                child: const Center(
                    child: Text('Location details are not available')),
              ))
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Example: Move the map to a new center
      //     mapController.move(const LatLng(52.0, -0.1), 13.0);
      //   },
      //   child: const Icon(Icons.add_location),
      // ),
    ) );
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


  Widget buildMap(MapsRoutesViewModel viewModel) {

    return FlutterMap(

      mapController: mapController,
      options: MapOptions(

        center: LatLng(viewModel.locations[0].latitude!,viewModel.locations[0].longitude!),
        zoom: 9.5,
        onMapReady:() => viewModel.fetchLocations(widget.name),
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
        PolylineLayer(
          polylineCulling: true,
          polylines: [
            Polyline(
              isDotted: false,
              points: viewModel.locations.map((e) {
                // Access latitude and longitude from the map
                double? lat = e.latitude;
                double? lng = e.longitude;

                // Return a LatLng object
                return LatLng(lat!, lng!);
              }).toList(),
              color: Colors.blueAccent,
              strokeWidth: 5,
            )
          ],
        ),

      ],
    );
  }


  List<Marker> _buildMarkers(MapsRoutesViewModel viewModel) {
    if(viewModel.locations.isEmpty){
      return[] ;
    }
    return viewModel.locations.map((location) {
      print(location);
      var lat = location.latitude;
      var lng = location.longitude;

      return Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(lat!, lng!),
          builder:(context) {
            return Stack(
              children: [
                const Icon(Icons.location_on, size: 50,color: Colors.red),
                Positioned(left: 5, top: 0, right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   borderRadius:
                    //   BorderRadius.circular(20),
                    // ),
                    child:  Text(location.territory!, style: const TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ),
              ],
            );
          });
    }
    ).toList();
  }

}




