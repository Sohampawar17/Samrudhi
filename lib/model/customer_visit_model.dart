class CustomerVisitModel {
  List<ActualRoute>? actualRoutes;
  List<PlannedRoute>? plannedRoutes;

  CustomerVisitModel(this.actualRoutes, this.plannedRoutes);

  CustomerVisitModel.fromJson(Map<String, dynamic> json) {
    if (json['actual_routes'] != null) {

      json['actual_routes'].forEach((v) {
        actualRoutes?.add(ActualRoute.fromJson(v));
      });
    }
    if (json['planned_routes'] != null) {
      plannedRoutes = [];
      json['planned_routes'].forEach((v) {
        plannedRoutes?.add(PlannedRoute.fromJson(v));
      });
    }
  }
}

class ActualRoute {
  String? territory;
  String? latitude;
  String? longitude;

  ActualRoute({territory, latitude,longitude});

  ActualRoute.fromJson(Map<String, dynamic> json) {
    territory = json['territory'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}

class PlannedRoute {
  String? territory;
  double? latitude;
  double? longitude;

  PlannedRoute({this.territory, this.latitude, this.longitude});

  PlannedRoute.fromJson(Map<String, dynamic> json) {
    territory = json['territory'];
    latitude = json['latitude'] is int ? (json['latitude'] as int).toDouble() : json['latitude'];
    longitude = json['longitude'] is int ? (json['longitude'] as int).toDouble() : json['longitude'];
  }
}
