class AddVisitModel {
  String? name;
  String? owner;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? customer;
  String? customerName;
  String? date;
  String? time;
  String? startTime;
  String? startLatitude;
  String? startLongitude;
  String? endTime;
  String? endLatitude;
  String? endLongitude;
  String? visitType;
  String? description;
  String? employee;
  String? user;
  String? latitude;
  String? location;
  String? longitude;
  String? doctype;

  AddVisitModel(
      {this.name,
        this.owner,
        this.modifiedBy,
        this.docstatus,
        this.idx,
        this.customer,
        this.customerName,
        this.date,
        this.time,
        this.visitType,
        this.description,
        this.employee,
        this.location,
        this.startTime,
        this.startLatitude,
        this.startLongitude,
        this.endTime,
        this.endLatitude,
        this.endLongitude,
        this.user,
        this.latitude,
        this.longitude,
        this.doctype});

  AddVisitModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    customer = json['customer'];
    customerName = json['customer_name'];
    date = json['date'];
    time = json['time'];
    startTime = json["start_time"];
    endTime = json["end_time"];
    startLatitude = json["start_latitude"];
    startLongitude = json["start_longitude"];
    endLatitude = json["end_latitude"];
    endLongitude = json["end_longitude"];
    visitType = json['visit_type'];
    description = json['description'];
    employee = json['employee'];
    location=json['location'];
    user = json['user'];
    longitude=json['longitude'].toString();
    latitude=json['latitude'].toString();
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['owner'] = owner;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['customer'] = customer;
    data['customer_name'] = customerName;
    data['date'] = date;
    data['time'] = time;
    data['start_time']=startTime;
    data['end_time']=endTime;
    data['start_latitude']=startLatitude;
    data['start_longitude']=startLongitude;
    data['end_time']=endTime;
    data['end_latitude']=endLatitude;
    data['end_longitude']=endLongitude;

    data['visit_type'] = visitType;
    data['description'] = description;
    data['location']=location;
    data['employee'] = employee;
    data['latitude']=latitude;
    data['longitude']=longitude;
    data['user'] = user;
    data['doctype'] = doctype;
    return data;
  }
}