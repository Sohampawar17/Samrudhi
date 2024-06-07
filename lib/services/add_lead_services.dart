import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import '../model/add_lead_model.dart';
import '../model/sub_complaint_model.dart';

class AddLeadServices{
    Future<bool> addLead(AddLeadModel lead) async {
    baseurl =  await geturl();
    var data = json.encode({
      "data": lead,
    });

    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Lead',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        String name=response.data['data']['name'];
        // afterSave(name);
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO Lead!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return false;
  }

  Future<bool> updateOrder(AddLeadModel leaddetails) async {
    baseurl =  await geturl();

    Logger().i(leaddetails.toString());
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Lead/${leaddetails.name.toString()}',
        options: Options(
          method: 'PUT',
          headers: {'Authorization': await getTocken()},
        ),
        data: leaddetails.toJson(),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Lead Updated successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO update Lead!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return false;
  }

 Future<List<String>> fetchindustrytype() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Industry Type?limit_page_length=99',
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

  Future<List<String>> fetchterritory() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Territory?limit_page_length=99',
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


  
  Future<AddLeadModel?> getlead(String id) async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Lead/$id',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        Logger().i(AddLeadModel.fromJson(response.data["data"]));
        return AddLeadModel.fromJson(response.data["data"]);
      } else {
        
        return null;
      }
    }  on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return null;
  }

    Future<List<String>> fetchCustomer() async {
      baseurl =  await geturl();
      try {
        var dio = Dio();
        var response = await dio.request(
          '$baseurl/api/method/mobile.mobile_env.lead.get_customer_list',
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
          Logger().i(namesList.length);
          return namesList;
        } else {
          Fluttertoast.showToast(msg: "Unable to fetch Customer");
          return [];
        }
      } catch (e) {
        Logger().e(e);
        Fluttertoast.showToast(msg: "Unauthorized Customer!");
        return [];
      }
    }

    Future<List<String>> fetchComplaintType() async {
      baseurl =  await geturl();
      try {
        var dio = Dio();
        var response = await dio.request(
          '$baseurl/api/resource/Complaint Type',
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
          Logger().i(namesList.length);
          return namesList;
        } else {
          Fluttertoast.showToast(msg: "Unable to fetch Customer");
          return [];
        }
      } catch (e) {
        Logger().e(e);
        Fluttertoast.showToast(msg: "Unauthorized Complaint Type!");
        return [];
      }
    }
    Future<List<SubComplaint>> fetchSubComplaintType(String? filter) async {
      baseurl =  await geturl();
      try {
        var dio = Dio();
        var response = await dio.request(
          '$baseurl/api/resource/Sub Complaint Type?filters=[["complaint_type","like","$filter%"]]&fields=["name","department"]',
          options: Options(
            method: 'GET',
            headers: {'Authorization': await getTocken()},
          ),
        );

        if (response.statusCode == 200) {

          Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
          List<SubComplaint> namesList = List.from(jsonData['data'])
              .map<SubComplaint>((data) => SubComplaint.fromJson(data))
              .toList();
          Logger().i(namesList.length);
          return namesList;
        } else {
          Fluttertoast.showToast(msg: "Unable to fetch Customer");
          return [];
        }
      } catch (e) {
        Logger().e(e);
        Fluttertoast.showToast(msg: "Unauthorized Sub Complaint Type!");
        return [];
      }
    }

    Future<bool> afterSave(String name) async {
      baseurl =  await geturl();
      var data = {
        "name": name,
      };
      try {
        var dio = Dio();
        var response = await dio.request(
          '$baseurl/api/method/mobile.mobile_env.lead.after_save',
          options: Options(
            method: 'POST',
            headers: {'Authorization': await getTocken()},
          ),
data: data
        );

        if (response.statusCode == 200) {
          Fluttertoast.showToast(msg: response.data["message"]);
          return true;
        } else {
          Fluttertoast.showToast(msg: "UNABLE TO update Lead!");
          return false;
        }
      } on DioException catch (e) {
        Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
        Logger().e(e);
      }
      return false;
    }


}