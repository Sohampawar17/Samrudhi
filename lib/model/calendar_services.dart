
import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import 'get_teritorry_details.dart';

class CalendarServices{

  Future<List<RouteAssignmentData>> getRouteAssignmentDetailsForMonth(String startDate, String endDate) async {
    List<RouteAssignmentData> routes = [];
    var url = await geturl();
    var token = await getTocken();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$url/api/resource/Routes Assignment?fields=["employee_name","route_name","datetime","name"]&filters=[["datetime", ">=", "$startDate"], ["datetime", "<=", "$endDate"]]',
        options: Options(
          method: 'GET',
          headers: {'Authorization': token},
        ),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        routes = List.from(jsonData["data"].map<RouteAssignmentData>((data) => RouteAssignmentData.fromJson(data)).toList());
        return routes;
      } else {
        return routes;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response?.data["message"].toString()} ',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),
      );
      Logger().e(e);
    }
    return routes;
  }



 String formatDate(DateTime dateTime){
    DateFormat formatter = DateFormat('yyyy-MM-dd'); // Change the format as needed
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

}