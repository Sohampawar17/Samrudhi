import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/constants.dart';
import 'package:geolocation/model/employee_list.dart';
import 'package:geolocation/model/get_teritorry_details.dart';
import 'package:logger/logger.dart';



class RouteServices {

  Future<bool> changeWorkflow(String? id,String? action) async {
    baseurl =  await geturl();

    var data={
      "reference_doctype":"Routes Master",
      "reference_name":id,
      "action":action

    };
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/mobile.mobile_env.app_utils.update_workflow_state',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {

        Fluttertoast.showToast(msg: response.data["message"].toString());
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO update Order!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);

    }
    return false;
  }



  Future<List<CustomerTerritoryData>> getCustomerRoute() async {
    try {
      var url = await geturl();
      var token = await getTocken();
      var dio = Dio();
      var response = await dio.request(
        '$url/api/resource/Customer?fields=["customer_name","territory"]',
        options: Options(
          method: 'GET',
          headers: {'Authorization':token},
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<CustomerTerritoryData> customerList = List.from(jsonData["data"]
            .map<CustomerTerritoryData>((data) => CustomerTerritoryData.fromJson(data))
            .toList());

        return customerList;
      } else {
        return [];
      }
    }  on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response?.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return [];

  }

  Future<List<TerritoryData>> getTerritory() async {
    List<TerritoryData> territoryList = [];
    try {
      var url = await geturl();
      var token = await getTocken();
      var dio = Dio();
      var response = await dio.request(
        '$url/api/resource/Territory?fields=["name","custom_latitude","custom_longitude"]&limit_page_length=999',
        options: Options(
          method: 'GET',
          headers: {'Authorization':token},
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        territoryList = List.from(jsonData["data"]
            .map<TerritoryData>((data) => TerritoryData.fromJson(data))
            .toList());

        return territoryList;
      } else {
        return territoryList;
      }
    }  on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response?.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return territoryList;

  }

  Future<List<CustomerTerritoryData>> saveRoute(Map<String, dynamic> payload) async {
    try {
      var url = await geturl();
      var token = await getTocken();
      var dio = Dio();
      var response = await dio.request(
        '$url/api/resource/Routes Master',
        data: jsonEncode(payload),
        options: Options(
          method: 'POST',
          headers: {'Authorization':token},
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
         print(response.data);
        Fluttertoast.showToast(gravity: ToastGravity.BOTTOM,
          msg: 'Route Created Successfully',
          textColor: const Color(0xFFFFFFFF),
          backgroundColor: const Color(0xFFBA1A1A),);
        return [];
      } else {

        return [];
      }
    }  on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response?.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return [];

  }
  Future<List<EmployeeAssignerDetails>> getEmployeeList() async {
    List<EmployeeAssignerDetails> employeeNames = [];
    var url = await geturl();
    var token = await getTocken();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$url/api/resource/Employee?fields=["employee_name","name"]',
        options: Options(
          method: 'GET',
          headers: {'Authorization': token},
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
         employeeNames = List.from(jsonData["data"]
        .map<EmployeeAssignerDetails>((data) => EmployeeAssignerDetails.fromJson(data))
        .toList());
        return employeeNames;
      } else {
        return employeeNames;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response?.data["message"].toString()} ',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return employeeNames;
  }




  Future<List<RouteMasterData>> getPlannedRoutes(String state) async {
    List<RouteMasterData> routes = [];
    var url = await geturl();
    var token = await getTocken();
    var data = json.encode({
      "workflow_state": state
    });
    try {
      var dio = Dio();

      var response = await dio.request(
        '$url/api/method/mobile.mobile_env.route.get_route_master_list',
        options: Options(
          method: 'GET',
          headers: {'Authorization': token},

        ),
        data: data
        //queryParameters: {'fields': '["route_name","name","workflow_state"]', "filters": jsonEncode([["workflow_state", "=", state]])},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        print(jsonData.toString());
        routes = List.from(jsonData["data"]
            .map<RouteMasterData>((data) => RouteMasterData.fromJson(data))
            .toList());

        return routes;
      } else {
        return routes;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response?.data["message"].toString()} ',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);

    }
    return routes;
  }


  Future<RouteMaster> getRouteDetails(String name) async {
   RouteMaster routes = RouteMaster();
    var url = await geturl();
    var token = await getTocken();
    try {
      var dio = Dio();

      var response = await dio.request(
        '$url/api/method/mobile.mobile_env.route.get_master_entry?id=$name',
        options: Options(
          method: 'GET',
          headers: {'Authorization': token},

        ),


     //   queryParameters: {'fields': '["route_name","name","workflow_state"]'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        print(jsonData["data"]);
       // print(jsonData.toString());

           routes = RouteMaster.fromJson(jsonData["data"]);
          // Handle the case where "data" key is missing or not a list

        // routes = List.from(jsonData["data"]
        //     .map<RouteMaster>((data) => RouteMaster.fromJson(data))
        //     );
        return routes;
      } else {
        return routes;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response?.data["message"].toString()} ',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);

    }
    return routes;
  }

  Future<void> editWorkflowState(String name, Map<String, dynamic> payload) async {
    print(name);
    var url = await geturl();
    var token = await getTocken();
    try {
      var dio = Dio();

      var response = await dio.request(
        '$url/api/resource/Routes Master/$name',
        data: jsonEncode(payload),
        options: Options(
          method: 'PUT',
          headers: {'Authorization': token},
        )
      );

      if (response.statusCode == 200) {
        print(response.data);

      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response?.data["message"].toString()} ',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);

    }

  }



  Future<void> assignRoute(Map<String, dynamic> payload) async {
    try {
      var dio = Dio();
      var url = await geturl();
      var token = await getTocken();
      var response = await dio.request(
        '$url/api/resource/Routes Assignment',
        data: jsonEncode(payload),
        options: Options(
          method: 'POST',
          headers: {'Authorization':token},
        ),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Route is assigned successfully.',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
        print(response.data);
      } else {

      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response?.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }

  }

  Future<List<RouteAssignmentData>> getRouteAssignmentDetails(String date) async {
    print(date);
    List<RouteAssignmentData> routes = [];
    var url = await geturl();
    var token = await getTocken();
    try {
      var dio = Dio();
      var response = await dio.request(
          '$url/api/resource/Routes Assignment?fields=["employee_name","route_name","datetime","name"]&filters=[["datetime", "=", "$date"]]',
          options: Options(
            method: 'GET',
            headers: {'Authorization': token},
          ),

//  String formatDate(DateTime dateTime){
//     DateFormat formatter = DateFormat('yyyy-MM-dd'); // Change the format as needed
//     String formattedDate = formatter.format(dateTime);
//     return formattedDate;
//   }"filters": jsonEncode([["workflow_state", "=", state]
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        routes = List.from(jsonData["data"]
            .map<RouteAssignmentData>((data) => RouteAssignmentData.fromJson(data)).toList());
        print(jsonData["data"]);
        return routes;
      } else {
        return routes;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response?.data["message"].toString()} ',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);

    }
    return routes;
  }

  Future<RoutesAssignment> getRouteTableDetails(String name) async {
    RoutesAssignment routes = RoutesAssignment();
    var url = await geturl();
    var token = await getTocken();
    try {
      var dio = Dio();

      var response = await dio.request(
          '$url/api/resource/Routes Assignment/$name',
          options: Options(
            method: 'GET',
            headers: {'Authorization': token},

          ),

        //   queryParameters: {'fields': '["route_name","name","workflow_state"]'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));

        // print(jsonData.toString());

        routes = RoutesAssignment.fromJson(jsonData["data"]);
        print(routes);
        // Handle the case where "data" key is missing or not a list

        // routes = List.from(jsonData["data"]
        //     .map<RouteMaster>((data) => RouteMaster.fromJson(data))
        //     );
        return routes;
      } else {
        return routes;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response?.data["message"].toString()} ',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);

    }
    return routes;
  }

}