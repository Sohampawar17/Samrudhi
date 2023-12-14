import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class GeolocationService {
  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Fluttertoast.showToast(msg: 'Location Serices are disabled');
        Future.error('Location services are disabled.');
        return null;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Fluttertoast.showToast(msg: 'Location permissions are denied');
          Future.error('Location permissions are denied');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(
            msg:
                'Location permissions are permanently denied, we cannot request permissions.');
        Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      return null;
    }
  }

  Future<Placemark?> getPlacemarks(Position? position) async {
    try {
      List<Placemark> list = await placemarkFromCoordinates(
          position!.latitude, position.longitude);
      if (list.isNotEmpty) {
        Placemark placemark = list[0];
        return placemark;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Location data not available');
    }
    return null;
  }

  Future<double?> calculateDistance(double originLat, double originLng,
      double destinationLat, double destinationLng) async {
    const apiKey = '1cfcdeaf26352898f9975a577da9fd30';
    final url =
        'https://apis.mappls.com/advancedmaps/v1/$apiKey/distance_matrix/driving/$originLng,$originLat;$destinationLng,$destinationLat?rtype=0&region=IND';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsondata = json.decode(response.body);
        final distance = jsondata['results']['distances'][0][1];
        return distance;
      } else {
        throw Exception('Failed to fetch data: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle network-related exceptions here, e.g., for connectivity issues
      throw Exception('Error calculating distance: $e');
    }
  }
}
