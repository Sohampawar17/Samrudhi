class Dashboard {
  String? lastLogType;
  String? empName;
  String? company;
  String? lastLogTime;
  String? employeeImage;

  Dashboard(
      {this.lastLogType,
      this.empName,
      this.company,
      this.lastLogTime,
      this.employeeImage});

  Dashboard.fromJson(Map<String, dynamic> json) {
    lastLogType = json['last_log_type'];
    empName = json['emp_name'];
    company = json['company'];
    lastLogTime = json['last_log_time'];
    employeeImage = json['employee_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_log_type'] = this.lastLogType;
    data['emp_name'] = this.empName;
    data['company'] = this.company;
    data['last_log_time'] = this.lastLogTime;
    data['employee_image'] = this.employeeImage;
    return data;
  }
}
