import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../model/expense_model.dart';

class AddExpenseServices{
  Future<bool> bookexpense(ExpenseData expense) async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app.book_expense',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: expense.toJson(),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: '${response.data["message"].toString()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFF006C50),);

        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO Lead!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString().split(":").elementAt(1).trim()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return false;
  }


  Future<List<String>> fetexpensetype() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Expense Claim Type?limit_page_length=999',
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
        Fluttertoast.showToast(msg: "Unable to fetch industry type");
        return [];
      }
    } catch (e) {
      Logger().e(e);
      Fluttertoast.showToast(msg: "Unauthorized industry!");
      return [];
    }
  }

}