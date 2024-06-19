import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../constants.dart';

class GeolocationService {
  Future<Position?> determinePosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to determine position: $e');
      return null;
    }
  }

  Future<Placemark?> getPlacemarks(Position? position) async {
    if (position == null) {
      Fluttertoast.showToast(msg: 'Position is null');
      return null;
    }

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        return placemarks[0];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to get placemarks: $e');
    }
    return null;
  }

  Future<double?> calculateDistance(double originLat, double originLng, double destinationLat, double destinationLng) async {
    const apiKey = '1cfcdeaf26352898f9975a577da9fd30';
    final url = 'https://apis.mappls.com/advancedmaps/v1/$apiKey/distance_matrix/driving/$originLng,$originLat;$destinationLng,$destinationLat?rtype=0&region=IND';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final distance = jsonData['results']['distances'][0][1];
        return distance;
      } else {
        throw Exception('Failed to fetch data: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error calculating distance: $e');
    }
  }

  Future<bool> employeeLocation(String longitude, String latitude, String deviceId) async {
    String baseurl = await geturl();
    var data = {'longitude': longitude, 'latitude': latitude, 'device_id': deviceId};
    try {
      var dio = Dio();
      var response = await dio.post(
        '$baseurl/api/method/mobile.mobile_env.location.user_location',
        options: Options(
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Logger().i(response.data["message"].toString());
        return true;
      } else {
        Fluttertoast.showToast(msg: "Unable to add employee log");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(msg: 'Error: ${e.response?.data["message"] ?? e.toString()}');
      Logger().e(e);
      return false;
    }
  }

  Future<String?> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String address = '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}, ${placemark.postalCode}';
        return address;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to get address from coordinates: $e');
    }
    return null;
  }
}
