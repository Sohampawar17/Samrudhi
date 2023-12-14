import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/model/add_leave_model.dart';
import 'package:logger/logger.dart';

import '../constants.dart';

class AddLeaveServices{

  Future<List<String>> getleavetype() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app.get_leave_type',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap["data"];
        Logger().i(dataList);
        List<String> namesList =
        dataList.map((item) => item["name"].toString()).toList();
        return namesList;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO get leave!");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return [];
  }


  Future<bool> addLeave(AddLeaveModel quotationdetails) async {
    baseurl =  await geturl();
    var data = json.encode(
      quotationdetails,
    );
    Logger().i(quotationdetails.toString());
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app.make_leave_application',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Leave created successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO Order!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG,
        msg: "${e.response?.data['message'].toString()}",
        backgroundColor: Color(0xFFBA1A1A),
        textColor: Color(0xFFFFFFFF),
      );
      Logger().e(e.response?.data['message'].toString());
    }
    return false;
  }

}