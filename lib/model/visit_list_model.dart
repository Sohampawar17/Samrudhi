class VisitListModel {
  String? name;
  String? visitor;
  String? customerName;
  String? enquiry;
  String? date;
  String? startTime;
  String? endTime;
  String? visitType;
  String? duration;

  VisitListModel({this.name, this.customerName, this.date, this.startTime,this.endTime, this.visitType, this.duration});

  VisitListModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    visitor = json["visitor"];
    enquiry = json["enquiry"];
    customerName = json['customer_name'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    duration =json['duration'];
    visitType = json['visit_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['visitor']= visitor;
    data["enquiry"]= enquiry;
    data['customer_name'] = customerName;
    data['date'] = date;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['duration'] = duration;
    data['visit_type'] = visitType;
    return data;
  }
}