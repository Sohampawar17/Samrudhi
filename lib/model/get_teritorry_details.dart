
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
  List<Waypoints>? wayPoints;

  RouteMasterData({
    this.routeName,
    this.name,
    this.worflowState,
    this.wayPoints
  });

  RouteMasterData.fromJson(dynamic json) {
    var childDataList = json['child_table_data'] as List;
    List<Waypoints> ways = childDataList.map((data) => Waypoints.fromJson(data)).toList();
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
  String? workflowState;
  String? routeName;
  int? enabled;
  List<Waypoints>? waypoints=[];
  List<String>? nextAction;
  bool? allowEdit;

  RouteMaster(
      {this.name,
        this.workflowState,
        this.routeName,
        this.enabled,
        this.waypoints,
        this.nextAction,
        this.allowEdit});

  RouteMaster.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    workflowState = json['workflow_state'];
    routeName = json['route_name'];
    enabled = json['enabled'];
    if (json['waypoints'] != null) {
      waypoints = <Waypoints>[];
      json['waypoints'].forEach((v) {
        waypoints!.add(new Waypoints.fromJson(v));
      });
    }
    nextAction = json['next_action'].cast<String>();
    allowEdit = json['allow_edit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['workflow_state'] = this.workflowState;
    data['route_name'] = this.routeName;
    data['enabled'] = this.enabled;
    if (this.waypoints != null) {
      data['waypoints'] = this.waypoints!.map((v) => v.toJson()).toList();
    }
    data['next_action'] = this.nextAction;
    data['allow_edit'] = this.allowEdit;
    return data;
  }
}

class Waypoints {
  String? name;
  String? owner;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? territory;
  double? latitude;
  double? longitude;
  String? parent;

  Waypoints(
      {this.name,
        this.owner,
        this.modifiedBy,
        this.docstatus,
        this.idx,
        this.territory,
        this.latitude,
        this.longitude,
        this.parent});

  Waypoints.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    territory = json['territory'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['territory'] = this.territory;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['parent'] = this.parent;
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



