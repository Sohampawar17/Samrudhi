
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:latlong2/latlong.dart';
import 'package:stacked/stacked.dart';

import 'customer_report_view_model.dart';


class CustomerReportScreen extends StatefulWidget {

  // final String name;
  //
  // const CustomerReportScreen({super.key, required this.name});

  @override
  State<StatefulWidget> createState() {
    return _CustomerReportScreenState();
  }
}

class _CustomerReportScreenState extends State<CustomerReportScreen> {

  final MapController mapController = MapController();


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerVisitViewModel>.reactive(
        viewModelBuilder: () => CustomerVisitViewModel(),
        onViewModelReady: (viewModel) => viewModel.initialise(),
        builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(
            title: Text('Check Your Routes'),
          ),
          body: fullScreenLoader(
            loader: viewModel.isBusy,
            context: context,
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // children: viewModel.locations.asMap().entries.map((entry) {
                      //   final index = entry.key;
                      //   final routeWay = entry.value;
                      //
                      //   return Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       if (index != 0) _buildTimelineLine(), // Add line between dots
                      //       Row(
                      //         children: [
                      //           _buildTimelineDot(),
                      //           SizedBox(width: 10), // Add some space between dot and title
                      //           _buildTimelineTitle(routeWay.territory!),
                      //         ],
                      //       ),
                      //       // Add a divider between each timeline event
                      //     ],
                      //   );
                      // }).toList(),
                    ),
                  ),


                  Expanded(child: buildMap(viewModel)
                  )],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Example: Move the map to a new center
              mapController.move(const LatLng(52.0, -0.1), 13.0);
            },
            child: const Icon(Icons.add_location),
          ),
        ) );
  }



  Widget buildMap(CustomerVisitViewModel viewModel) {
    double? latitude = viewModel.customerVisit.plannedRoutes![0].latitude;
    double? longitude =  viewModel.customerVisit.plannedRoutes![0].longitude;
    print(latitude);
    print(longitude);

    return FlutterMap(

      mapController: mapController,
      options: MapOptions(
        center: LatLng(latitude!,longitude!),
        zoom: 12,
        onMapReady:() => viewModel.initialise(),
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
        MarkerLayer(markers: _buildMarkers(viewModel)!),
        PolylineLayer(
          polylineCulling: true,
          polylines: [
            if(viewModel.actualPoints.isNotEmpty)
            Polyline(
              isDotted: false,
              points: viewModel.actualPoints.map((e) {
                // Access latitude and longitude from the map
                double? lat = e.latitude;
                double? lng = e.longitude;

                // Return a LatLng object
                return LatLng(lat!, lng!);
              }).toList(),
              color: Colors.blueAccent,
              strokeWidth: 5,
            ),
            if(viewModel.plannedPoints.isNotEmpty)
            Polyline(
              isDotted: false,
              points: viewModel.plannedPoints.map((e) {
                // Access latitude and longitude from the map
                double? lat = e.latitude;
                double? lng = e.longitude;

                // Return a LatLng object
                return LatLng(lat, lng);
              }).toList(),
              color: Colors.green,
              strokeWidth: 5,
            )
          ],
        ),

      ],
    );
  }

  List<Marker> _buildMarkers(CustomerVisitViewModel viewModel) {
    List<Marker> markers = [];

    if (viewModel.customerVisit.actualRoutes != null) {
      markers.addAll(viewModel.customerVisit.actualRoutes!.map((location) {
        var lat = double.tryParse(location.latitude ?? '');
        var lng = double.tryParse(location.longitude ?? '');

        return Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(lat ?? 0.0, lng ?? 0.0),
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
                      location.territory ?? '',
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }));
    }

    if (viewModel.customerVisit.plannedRoutes != null) {
      markers.addAll(viewModel.customerVisit.plannedRoutes!.map((location) {
        var lat = location.latitude;
        var lng = location.longitude;

        return Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(lat ?? 0.0, lng ?? 0.0),
          builder: (context) {
            return Stack(
              children: [
                const Icon(Icons.location_on, size: 50, color: Colors.green),
                Positioned(
                  left: 5,
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      location.territory ?? '',
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }));
    }

    return markers;
  }


}




