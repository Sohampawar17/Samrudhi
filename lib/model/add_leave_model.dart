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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['half_day'] = this.halfDay;
    data['half_day_date'] = this.halfDayDate;
    data['total_leave_days'] = this.totalLeaveDays;
    data['leave_type'] = this.leaveType;
    data['description'] = this.description;
    return data;
  }
}
