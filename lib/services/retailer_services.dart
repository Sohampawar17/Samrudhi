
import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../model/retailer_model.dart';


class RetailerServices {

  Future<bool> addRetailer(RetailerModel retailerModel) async {
    baseurl =  await geturl();


    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.lead.retailer_registration',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: retailerModel.toJson(),
      );

      if (response.statusCode == 200) {
        // afterSave(name);
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO Lead!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response?.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e.response?.data["message"].toString());
    }
    return false;
  }


  Future<RetailerModel?> getId(String id) async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Retailer Registration/$id',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        Logger().i(RetailerModel.fromJson(response.data["data"]));
        return RetailerModel.fromJson(response.data["data"]);
      } else {

        return null;
      }
    }  on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return null;
  }

}