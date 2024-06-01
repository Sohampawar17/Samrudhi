import 'dart:convert';
import 'dart:ui';
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
        '$baseurl/api/resource/Lead?order_by=creation desc&fields=["name","lead_name","status","company_name","territory","custom_address"]',
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

   Future<List<ListLeadModel>> fetchfilterquotation(String customerName,String request) async {
     baseurl = await geturl();
     try {
       var dio = Dio();

       // Construct the base URL
       String apiUrl =
           '$baseurl/api/resource/Lead?order_by=creation desc&fields=["name","lead_name","status","company_name","territory","custom_address"]';

       if(customerName.isNotEmpty && request.isNotEmpty){
         apiUrl += '&filters=[["lead_name", "=", "$customerName"],["request_type", "=", "$request"]]';
       }
       // Add filters based on conditions
       if(customerName.isNotEmpty) {
         apiUrl += '&filters=[["lead_name", "=", "$customerName"]]';
       }
       // Format the date in a way that your API expects, adjust as needed
       if(request.isNotEmpty) {
         apiUrl += '&filters=[["request_type", "=", "$request"]]';
       }
       //
       Logger().i(apiUrl);
       var response = await dio.request(
         apiUrl,
         options: Options(
           method: 'GET',
           headers: {'Authorization': await getTocken()},
         ),
       );
       Logger().i(apiUrl);
       if (response.statusCode == 200) {
         Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
         List<ListLeadModel> orderList = List.from(jsonData['data'])
             .map<ListLeadModel>((data) => ListLeadModel.fromJson(data))
             .toList();
         Logger().i(orderList.length);
         return orderList;
       } else {
         Fluttertoast.showToast(msg: "Unable to fetch orders");
         return [];
       }
     } on DioException catch (e) {
       Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
       Logger().e(e);
       return [];
     }
   }

   Future<List<String>> getCustomer() async {
     baseurl =  await geturl();
     try {
       var dio = Dio();
       var response = await dio.request(
         '$baseurl/api/method/mobile.mobile_env.lead.filter_customer_list',
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
         dataList.map((item) => item["lead_name"].toString()).toList();
         return namesList;
       } else {
         Fluttertoast.showToast(msg: "UNABLE TO get notes!");
         return [];
       }
     } on DioException catch (e) {
       Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:Color(0xFFFFFFFF),backgroundColor: Color(0xFFBA1A1A),);
       Logger().e(e);
     }
     return [];
   }

}