class AddLeaveModel {
  String? name;
  String? owner;
  String? fromDate;
  String? toDate;
  int? halfDay;
  String? halfDayDate;
  double? totalLeaveDays;
  String? leaveType;
  String? description;

  AddLeaveModel(
      {this.name,
        this.owner,
        this.fromDate,
        this.toDate,
        this.halfDay,
        this.halfDayDate,
        this.totalLeaveDays,
        this.leaveType,
        this.description});

  AddLeaveModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    halfDay = json['half_day'];
    halfDayDate = json['half_day_date'];
    totalLeaveDays = json['total_leave_days'];
    leaveType = json['leave_type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['owner'] = owner;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['half_day'] = halfDay;
    data['half_day_date'] = halfDayDate;
    data['total_leave_days'] = totalLeaveDays;
    data['leave_type'] = leaveType;
    data['description'] = description;
    return data;
  }
}
