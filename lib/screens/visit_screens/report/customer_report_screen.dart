
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

                  ListTile(leading: Text(viewModel.formatDate(viewModel.selectedDate??DateTime.now()),style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      trailing: Text("Select Date",   style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                  onTap: ()=>{
                    _selectDate(context,viewModel)
                  }
                  ),
                  Padding(padding:EdgeInsets.all(8.0),child: CustomDropdownButton2(value:viewModel.selectedEmployee,items: viewModel.getEmployeeNames(), hintText:"Select Employee", onChanged:(newValue) {
                    selectedEmployee = newValue;
                    viewModel.assignSelectedEmployee(selectedEmployee!);

                    }, labelText:"Employees" )),
                  const SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12.0,
                              height: 12.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            const Text("Planned Routes"),
                          ],
                        ),
                    
                        Row(
                          children: [
                            Container(
                              width: 12.0,
                              height: 12.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            const Text("Actual Routes"),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    
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
             // mapController.move(const LatLng(52.0, -0.1), 13.0);
              _showBottomSheet(viewModel);
            },
            child: const Icon(Icons.add_location),
          ),
        ) );
  }

  void _showBottomSheet(CustomerVisitViewModel customerVisitViewModel) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Planned Routes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              if (customerVisitViewModel.plannedRoutes.isNotEmpty)
                Container(
                height: 150,
                child: ListView.builder(
                  itemCount: customerVisitViewModel.plannedRoutes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(customerVisitViewModel.plannedRoutes[index].territory!),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              const Text(
                'Actual Routes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              if (customerVisitViewModel.actualRoutes.isNotEmpty)
                Container(
                height: 150,
                child: ListView.builder(
                  itemCount: customerVisitViewModel.actualRoutes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(customerVisitViewModel.actualRoutes[index].territory),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
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
       // onMapReady:() => viewModel.initialise(),
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
            if(viewModel.plannedRoutes.isNotEmpty)
            Polyline(
              isDotted: false,
              points: viewModel.plannedRoutes.map((e) {
                // Access latitude and longitude from the map
                double? lat = e.latitude;
                double? lng = e.longitude;

                // Return a LatLng object
                return LatLng(lat!, lng!);
              }).toList(),
              color: Colors.red,
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
              const Icon(Icons.location_on, size: 50, color: Colors.blue),
              Positioned(
                left: 5,
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    location.territory ?? '',
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
    }).whereType<Marker>() .toList(); // Filter out null markers
  }






}









