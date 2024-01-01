import 'dart:convert';
import 'dart:io';
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

  Future<Attachments?> uploadDocs(File? file) async {
    if (file == null) {
      return null;
    }
    try {
      FormData data = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: generateUniqueFileName(file),
        ),
      });
      var dio = Dio();
      var response = await dio.request(
        apiUploadFilePost,
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Logger().i(Attachments.fromJson(response.data["message"]));
        return Attachments.fromJson(response.data["message"]);
      } else {
        return null;
      }
    } catch (e) {
      Logger().e(e);
    }
    // Add a return statement to handle the case where the function completes normally
    return null; // or throw an error if you prefer
  }



  Future<bool> deletedoc(String name) async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/File/$name',
        options: Options(
          method: 'DELETE',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 202) {
        print('Deleted');
        // Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: '${response.data["message"].toString()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFF006C50),);
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
}



