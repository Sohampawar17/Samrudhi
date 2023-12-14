import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../model/attendance_model.dart';

class AttendanceServices{

  Future<List<AttendanceList>> fetchattendence(int year,int month) async {
    baseurl =  await geturl();
    var data = {
      'month': month,
      'year': year
    };
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app.get_attendance_list',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
        data: data
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<AttendanceList> caneList = List.from(jsonData['data']["attendance_list"])
            .map<AttendanceList>((data) => AttendanceList.fromJson(data))
            .toList();
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch items");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        msg: "${e.response?.data['message'].toString()}",
        backgroundColor: Color(0xFFBA1A1A),
        textColor: Color(0xFFFFFFFF),
      );
      Logger().e(e.response?.data['message'].toString());
      return [];
    }
  }


  Future<AttendanceDetails?> attendencedata(int year,int month) async {
    baseurl =  await geturl();
    var data = {
      'month': month,
      'year': year
    };
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app.get_attendance_list',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
        data: data
      );

      if (response.statusCode == 200) {
        Logger().i(AttendanceDetails.fromJson(response.data["data"]));
        return AttendanceDetails.fromJson(response.data["data"]["attendance_details"]);
      } else {
        if (kDebugMode) {
          print(response.statusMessage);
        }
        return null;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        msg: "${e.response?.data['message'].toString()}",
        backgroundColor: Color(0xFFBA1A1A),
        textColor: Color(0xFFFFFFFF),
      );
      Logger().e(e.response?.data['message'].toString());
    }
    return null;
  }

}