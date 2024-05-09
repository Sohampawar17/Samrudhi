import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/model/customer_visit_model.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../model/visit_list_model.dart';

class ListVisitServices{
  Future<List<VisitListModel>> fetchVisit() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(

        '$baseurl/api/method/mobile.mobile_env.visit.get_visit_list',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<VisitListModel> caneList = List.from(jsonData['data'])
            .map<VisitListModel>((data) => VisitListModel.fromJson(data))
            .toList();
        Logger().i(caneList.first.toJson());
        return caneList;

      } else {
        Fluttertoast.showToast(msg: "Unable to fetch Quotation");
        return [];
      }
    } catch (e) {

      Logger().e(e);
      Fluttertoast.showToast(msg: "Unauthorized Quotation!");
      return [];
    }
  }
  Future<CustomerVisitModel> getCustomerVisitReport(String date, String? selectedEmployee)async {
    CustomerVisitModel customerVisitModel= CustomerVisitModel([], []);
    var token = await getTocken();
    baseurl = await geturl();
    var headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    var data = json.encode({
      "date": date,
      "employee":selectedEmployee
    });
    var dio = Dio();
    var response = await dio.request(
      '$baseurl/api/method/mobile.mobile_env.route.routes',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      return CustomerVisitModel.fromJson(response.data["data"]);

    }
    else {
      print(response.statusMessage);
    }
    return customerVisitModel;
  }

}