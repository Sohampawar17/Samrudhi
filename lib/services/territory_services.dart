

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:geolocation/constants.dart';

import '../model/get_teritorry_details.dart';

class TerritoryServices {
  // Fetch zones
  Future<List<String>> getZones() async {
    var url = await geturl();
    var token = await getTocken();
    try {
      final response = await Dio().get(
        '$url/api/method/mobile.mobile_env.route.get_zones',
        options: Options(
          method: 'GET',
          headers: {'Authorization': token},

        ),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        List<dynamic> message = jsonData['message'];
        final List<String> zones = List<String>.from(message);
        return zones;
      } else {
        throw Exception('Failed to load zones');
      }
    } catch (e) {
      throw Exception('Failed to load zones: $e');
    }
  }

  // Fetch regions
  Future<List<String>> getRegions({String? zone}) async {
    var url = await geturl();
    var token = await getTocken();
    try {
      final response = await Dio().get(
        '$url/api/method/mobile.mobile_env.route.get_regions',
        queryParameters: zone != null ? {'zone': zone} : null,
        options: Options(
          method: 'GET',
          headers: {'Authorization': token},

        ),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        // Extract names from the "message" field
        List<dynamic> message = jsonData['message'];
        // List names = message.map((item) => item['name']).toList();
        List<String> names = message.map((item) => item['name'] as String)
            .toList();
        return names;
      } else {
        return [];
      }
    } catch (e) {
      return [];
      throw Exception('Failed to load regions: $e');
    }
  }

  // Fetch areas
  Future<List<String>> getAreas({String? region}) async {
    var url = await geturl();
    var token = await getTocken();
    try {
      final response = await Dio().get(
        '$url/api/method/mobile.mobile_env.route.get_areas',
        queryParameters: region != null ? {'region': region} : null,
        options: Options(
          method: 'GET',
          headers: {'Authorization': token},

        ),

      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        // Extract names from the "message" field
        List<dynamic> message = jsonData['message'];
        // List names = message.map((item) => item['name']).toList();
        List<String> names = message.map((item) => item['name'] as String)
            .toList();
        return names;
      } else {
        throw Exception('Failed to load areas');
      }
    } catch (e) {
      throw Exception('Failed to load areas: $e');
    }
  }


  Future<List<TerritoryData>> getEndNodes(String? area) async {
    var url = await geturl();
    var token = await getTocken();
    List<TerritoryData> endList =[];
    try {
      final response = await Dio().get(
        '$url/api/method/mobile.mobile_env.route.get_nodes',
        queryParameters: area != null ? {'area': area} : null,
        options: Options(
          method: 'GET',
          headers: {'Authorization': token},
        ),
      );
      if (response.statusCode == 200) {
        print(response.data);

        Map<String, dynamic> jsonData = response.data;
         endList = List.from(jsonData["message"]
            .map<TerritoryData>((data) => TerritoryData.fromJson(data))
            .toList());


        return endList;

      } else {
        return[];
        throw Exception('Failed to load areas');
      }
    } catch (e) {
      return[];
      throw Exception('Failed to load areas: $e');
    }
  }


}