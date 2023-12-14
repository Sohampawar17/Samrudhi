class LeaveList {
  String? name;
  String? leaveType;
  String? fromDate;
  String? toDate;
  double? totalLeaveDays;
  String? description;
  String? status;
  String? postingDate;

  LeaveList(
      {this.name,
        this.leaveType,
        this.fromDate,
        this.toDate,
        this.totalLeaveDays,
        this.description,
        this.status,
        this.postingDate});

  LeaveList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    leaveType = json['leave_type'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    totalLeaveDays = json['total_leave_days'];
    description = json['description'];
    status = json['status'];
    postingDate = json['posting_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['leave_type'] = this.leaveType;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['total_leave_days'] = this.totalLeaveDays;
    data['description'] = this.description;
    data['status'] = this.status;
    data['posting_date'] = this.postingDate;
    return data;
  }
}
