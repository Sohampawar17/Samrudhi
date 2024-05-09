
class CustomerTerritoryData {

  String? customerName;
  String? territory;

  CustomerTerritoryData({
    this.customerName,
    this.territory,
  });
  CustomerTerritoryData.fromJson(dynamic json) {
    customerName = json['customer_name']!.toString();
    territory = json['territory']!.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['customer_name'] = customerName;
    data['territory'] = territory;
    return data;
  }
}

class TerritoryData {

  String? territoryName;
  String? latitude;
  String? longitude;

  TerritoryData({
    this.territoryName
  });

  TerritoryData.fromJson(dynamic json) {
    territoryName = json['name']!.toString();
    latitude = json['custom_latitude']!.toString();
    longitude = json['custom_longitude']!.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = territoryName;
    return data;
  }
}

class RouteMasterData {

  String? routeName;
  String? name;
  String? worflowState;
  List<Waypoint>? wayPoints;

  RouteMasterData({
    this.routeName,
    this.name,
    this.worflowState,
    this.wayPoints
  });

  RouteMasterData.fromJson(dynamic json) {
    var childDataList = json['child_table_data'] as List;
    List<Waypoint> ways = childDataList.map((data) => Waypoint.fromJson(data)).toList();
    worflowState= json['workflow_state'].toString();
    routeName = json['route_name'].toString();
    name = json['name']!.toString();
    wayPoints = ways;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['route_name'] = routeName;
    data['workflow_state'] = worflowState;
    return data;
  }
}

class RouteMaster {
  String? name;
  String? workflowstate;
  String? routename;
  int? enabled;
  String? doctype;
  List<Waypoint?>? waypoints;

  RouteMaster({this.name, this.workflowstate, this.routename, this.enabled, this.doctype, this.waypoints});

  RouteMaster.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    workflowstate = json['workflow_state'];
    routename = json['route_name'];
    enabled = json['enabled'];
    doctype = json['doctype'];
    if (json['waypoints'] != null) {
      waypoints = <Waypoint>[];
      json['waypoints'].forEach((v) {
        waypoints!.add(Waypoint.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['workflow_state'] = workflowstate;
    data['route_name'] = routename;
    data['enabled'] = enabled;
    data['doctype'] = doctype;
    data['waypoints'] =waypoints != null ? waypoints!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}

class Waypoint {
  String? territory;
  double? latitude;
  double? longitude;

  Waypoint({ this.territory, this.latitude, this.longitude});

  Waypoint.fromJson(Map<String, dynamic> json) {

    territory = json['territory'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['territory'] = territory;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}


class RouteAssignmentData {

  String? employeeName;
  String? routeName;
  String? datetime;
  String? name;

  RouteAssignmentData({
    this.employeeName,
    this.routeName,
    this.datetime,
    this.name
  });

  RouteAssignmentData.fromJson(dynamic json) {
    employeeName= json['employee_name'].toString();
    routeName = json['route_name'].toString();
    datetime = json['datetime']!.toString();
    name = json['name']!.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['employee_name'] = employeeName;
    data['route_name'] = routeName;
    data['datetime'] = datetime;
    data['name'] = name;
    return data;
  }
}


class RoutesAssignment {
  String? name;
  String? employee;
  String? routesMaster;
  String? routeName;
  String? employeeName;
  String? datetime;
  String? routesMap;
  List<RoutesTable>? routesTable;

  RoutesAssignment({
    this.name,
    this.employee,
    this.routesMaster,
    this.routeName,
    this.employeeName,
    this.datetime,
    this.routesMap,
    this.routesTable,
  });

  RoutesAssignment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    employee = json['employee'];
    routesMaster = json['routes_master'];
    routeName = json['route_name'];
    employeeName = json['employee_name'];
    datetime = json['datetime'];
    routesMap = json['routes_map'];

    if (json['routes_table'] != null) {
      routesTable = [];
      json['routes_table'].forEach((v) {
        routesTable?.add(new RoutesTable.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['employee'] = this.employee;
    data['routes_master'] = this.routesMaster;
    data['route_name'] = this.routeName;
    data['employee_name'] = this.employeeName;
    data['datetime'] = this.datetime;
    data['routes_map'] = this.routesMap;

    if (this.routesTable != null) {
      data['routes_table'] = this.routesTable?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoutesTable {
  String? territory;
  double? latitude;
  double?longitude;

  RoutesTable({
    this.territory,
    this.latitude,
    this.longitude,
  });

  RoutesTable.fromJson(Map<String, dynamic> json) {
    territory = json['territory'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['territory'] = this.territory;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}



