import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../model/leave_list.dart';

class ListLeaveServices{
  Future<List<LeaveList>> fetchLeaves() async {
    baseurl =  await geturl();

    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app.get_leave_application_list',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),

      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<LeaveList> caneList = List.from(jsonData["data"]["upcoming"])
            .map<LeaveList>((data) => LeaveList.fromJson(data))
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

  Future<List<LeaveList>> fetchtakenLeaves() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app.get_leave_application_list',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<LeaveList> caneList = List.from(jsonData["data"]["taken"])
            .map<LeaveList>((data) => LeaveList.fromJson(data))
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
}