
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocation/widgets/drop_down.dart';
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
  String? selectedEmployee;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerVisitViewModel>.reactive(
        viewModelBuilder: () => CustomerVisitViewModel(),
        onViewModelReady: (viewModel) => viewModel.initialise(),
        builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(
            title: Text('Report'),
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


                  ),

                  ListTile(leading: Text(viewModel.formatDate(viewModel.selectedDate??DateTime.now()),style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      trailing: Text("Select Date",   style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                  onTap: ()=>{
                    _selectDate(context,viewModel)
                  }
                  ),
                  Padding(padding:EdgeInsets.all(8.0),child: CustomDropdownButton2(value:viewModel.selectedEmployee,items: viewModel.getEmployeeNames(), hintText:"Select Employee", onChanged:(newValue) {
                    selectedEmployee = newValue;
                    viewModel.assignSelectedEmployee(selectedEmployee!);

                    }, labelText:"Employees" )),

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

  Future<void> _selectDate(BuildContext context,CustomerVisitViewModel customerViewModel) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: customerViewModel.selectedDate ?? DateTime.now(), // Use viewModel.selectedDate as initialDate
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != customerViewModel.selectedDate) {
      setState(() {
        customerViewModel.updateSelectedDate(picked); // Update selected date in the view model
      });
    }else{
      customerViewModel.updateSelectedDate(DateTime.now());
    }
  }


 List<Marker> markers = [];
  Widget buildMap(CustomerVisitViewModel viewModel) {
    double? latitude;
    double? longitude;

    if (viewModel.customerVisit.plannedRoutes.isNotEmpty) {
      latitude = viewModel.customerVisit.plannedRoutes[0].latitude;
      longitude = viewModel.customerVisit.plannedRoutes[0].longitude;
    }
    print(latitude);
    print(longitude);

    return viewModel.customerVisit.plannedRoutes.isNotEmpty?
      FlutterMap(

      mapController: mapController,
      options: MapOptions(
        center: LatLng(latitude ?? 0.0,longitude ?? 0.0),
        zoom: 12,
        onMapReady:() => viewModel.initialise(),
        onPositionChanged: (MapPosition pos, bool isGesture) {

          // Perform actions once the map is ready
          // For example, load markers here
          // _buildMarkers(viewModel);
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(markers:
        allMarkers(viewModel)),
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
                return LatLng(lat, lng);
              }).toList(),
              color: Colors.blueAccent,
              strokeWidth: 8,
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
    ):Center(child: Text('Please assign the route first'),);
  }

  List<Marker> allMarkers(CustomerVisitViewModel customerVisitViewModel){
    markers.addAll(_buildPlannedMarkers(customerVisitViewModel));
    markers.addAll(_buildActualMarkers(customerVisitViewModel));
    return markers;
  }


  List<Marker> _buildPlannedMarkers(CustomerVisitViewModel viewModel) {
    return viewModel.plannedRoutes.map((location) {
      var lat = location.latitude;
      var lng = location.longitude;

      if (lat == null || lng == null) {
        return null;
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
    }).whereType<Marker>() .toList(); // Filter out null markers
  }

  List<Marker> _buildActualMarkers(CustomerVisitViewModel viewModel) {
    return viewModel.actualRoutes.map((location) {
      var lat = location.latitude;
      var lng = location.longitude;

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
    }).whereType<Marker>() .toList(); // Filter out null markers
  }



}









