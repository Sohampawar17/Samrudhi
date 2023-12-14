import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import '../model/holiday_model.dart';

class HolidayServices{
  Future<List<HolidayList>> fetchHoliday(String year) async {
    baseurl =  await geturl();
    var data = {'year': year};
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app.get_holiday_list',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
        data: data
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<HolidayList> caneList = List.from(jsonData['data'])
            .map<HolidayList>((data) => HolidayList.fromJson(data))
            .toList();
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch holidays");
        return [];
      }
    } on DioException catch (e) {
      // Fluttertoast.showToast(
      //   msg: "${e.response?.data['message'].toString()}",
      //   backgroundColor: Color(0xFFBA1A1A),
      //   textColor: Color(0xFFFFFFFF),
      // );
      Logger().e(e.response?.data['message'].toString());
      return [];
    }
  }
}