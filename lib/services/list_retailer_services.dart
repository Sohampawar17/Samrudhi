import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../screens/registration/retailer/reatiler_list/retailer_list_model.dart';

class RetailerListServices{
  Future<List<RetailerListModel>> retailers() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Retailer Registration?fields=["name","name_of_the_shop","name_of_the_shop_owner","territorry","creation"]&order_by=creation desc&limit_page_length=99',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<RetailerListModel> caneList = List.from(jsonData['data'])
            .map<RetailerListModel>((data) => RetailerListModel.fromJson(data))
            .toList();
        Logger().i(caneList);
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
}