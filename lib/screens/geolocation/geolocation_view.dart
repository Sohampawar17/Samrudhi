import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/full_screen_loader.dart';
import 'geolocation_model.dart';

class Geolocation extends StatelessWidget {
  const Geolocation({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GeolocationViewModel>.reactive(
      viewModelBuilder: () => GeolocationViewModel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const AutoSizeText('Route details'),
          centerTitle: true,
        ),
        body: fullScreenLoader(
          child: Column(

            children: [
              Card(
                color: Colors.purple.shade50,
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      Text(
                        'User: ${model.geolocationdata.user ?? ""}',
                      ),
                      Text(
                        'Date:  ${model.geolocationdata.date ?? ""}',
                      ),
                      Text(
                        'Distance(Km):  ${model.geolocationdata.distance ?? ""}',
                      ),

                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: model.locations.isNotEmpty
                    ? FlutterMap(
                  options: MapOptions(
                      center: LatLng(
                          double.parse(
                              model.locations[0].latitude ?? "0.0"),
                          double.parse(
                              model.locations[0].longitude ?? "0.0")),

                      onMapReady: () => model.onMapReady),
                  children: [
                    TileLayer(
                      urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName:
                      'dev.fleaflet.flutter_map.example',
                      // Plenty of other options available!
                    ),
                    MarkerLayer(
                      markers: model.locations.asMap().entries.map((entry) {
                        final int index = entry.key;
                        final LatLng latLng = LatLng(
                          double.parse(entry.value.latitude ?? ""),
                          double.parse(entry.value.longitude ?? ""),
                        );

                        return Marker(

                          point: latLng,
                          builder: (ctx) {
                            return const Stack(
                              children: [
                                Icon(Icons.location_on, size: 50,color: Colors.red),

                              ],
                            );
                          },
                        );
                      }).toList(),
                    ),
                    PolylineLayer(
                      polylineCulling: true,
                      polylines: [
                        // Polyline(
                        //
                        //     points:
                        //     // model.points,
                        //     model.locations.map((e) {
                        //       return LatLng(double.parse(e.latitude ?? ""), double.parse(e.longitude ?? ""));
                        //     }).toList(),
                        //     color: Colors.blueAccent,
                        //     strokeWidth: 8),
                        if(model.points.isNotEmpty)
                        Polyline(
                            points:
                            // model.points,
                            model.points.map((e) {
                              return LatLng(e.latitude, e.longitude);
                            }).toList(),
                            color: Colors.blue,
                            strokeWidth: 5),
                      ],
                    ),
                  ],
                )
                    : Container(
                  child: const Center(
                      child: Text('To see your location please check in')),
                ),
              ),

            ],
          ),
          loader: model.isBusy,
          context: context,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              model.initialise(context),
          child: const Icon(Icons.refresh_outlined),
        ),
      ),
    );
  }

// Define your background task logic here
}
