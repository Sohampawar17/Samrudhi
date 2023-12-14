import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import '../model/list_lead_model.dart';

class ListLeadServices{
   Future<List<ListLeadModel>> fetchleadlist() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Lead?order_by=creation desc&fields=["name","lead_name","status","company_name","territory"]',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<ListLeadModel> caneList = List.from(jsonData['data'])
            .map<ListLeadModel>((data) => ListLeadModel.fromJson(data))
            .toList();
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch Lead");
        return [];
      }
    } catch (e) {
      Logger().i(e);
      Fluttertoast.showToast(msg: "Unauthorized Orders!");
      return [];
    }
  }
}