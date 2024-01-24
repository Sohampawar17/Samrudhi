class DashBoard {
  List<LeaveBalance>? leaveBalance;
  String? lastLogType;
  AttendanceDetails? attendanceDetails;
  String? empName;
  String? company;
  String? lastLogTime;
  String? employeeImage;

  DashBoard(
      {this.leaveBalance,
        this.lastLogType,
        this.attendanceDetails,
        this.empName,
        this.company,
        this.lastLogTime,
        this.employeeImage});

  DashBoard.fromJson(Map<String, dynamic> json) {
    if (json['leave_balance'] != null) {
      leaveBalance = <LeaveBalance>[];
      json['leave_balance'].forEach((v) {
        leaveBalance!.add(new LeaveBalance.fromJson(v));
      });
    }
    lastLogType = json['last_log_type'];
    attendanceDetails = json['attendance_details'] != null
        ? new AttendanceDetails.fromJson(json['attendance_details'])
        : null;
    empName = json['emp_name'];
    company = json['company'];
    lastLogTime = json['last_log_time'];
    employeeImage = json['employee_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaveBalance != null) {
      data['leave_balance'] =
          this.leaveBalance!.map((v) => v.toJson()).toList();
    }
    data['last_log_type'] = this.lastLogType;
    if (this.attendanceDetails != null) {
      data['attendance_details'] = this.attendanceDetails!.toJson();
    }
    data['emp_name'] = this.empName;
    data['company'] = this.company;
    data['last_log_time'] = this.lastLogTime;
    data['employee_image'] = this.employeeImage;
    return data;
  }
}

class LeaveBalance {
  String? leaveType;
  String? employee;
  String? employeeName;
  double? leavesAllocated;
  double? leavesExpired;
  double? openingBalance;
  double? leavesTaken;
  double? closingBalance;
  int? indent;

  LeaveBalance(
      {this.leaveType,
        this.employee,
        this.employeeName,
        this.leavesAllocated,
        this.leavesExpired,
        this.openingBalance,
        this.leavesTaken,
        this.closingBalance,
        this.indent});

  LeaveBalance.fromJson(Map<String, dynamic> json) {
    leaveType = json['leave_type'];
    employee = json['employee'];
    employeeName = json['employee_name'];
    leavesAllocated = json['leaves_allocated'];
    leavesExpired = json['leaves_expired'];
    openingBalance = json['opening_balance'];
    leavesTaken = json['leaves_taken'];
    closingBalance = json['closing_balance'];
    indent = json['indent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leave_type'] = this.leaveType;
    data['employee'] = this.employee;
    data['employee_name'] = this.employeeName;
    data['leaves_allocated'] = this.leavesAllocated;
    data['leaves_expired'] = this.leavesExpired;
    data['opening_balance'] = this.openingBalance;
    data['leaves_taken'] = this.leavesTaken;
    data['closing_balance'] = this.closingBalance;
    data['indent'] = this.indent;
    return data;
  }
}

class AttendanceDetails {
  String? monthTitle;
  int? tillDays;
  int? totalDays;
  double? dayOff;
  double? present;
  double? absent;

  AttendanceDetails(
      {this.monthTitle,
        this.tillDays,
        this.totalDays,
        this.dayOff,
        this.present,
        this.absent});

  AttendanceDetails.fromJson(Map<String, dynamic> json) {
    monthTitle = json['month_title'];
    tillDays = json['till_days'];
    totalDays = json['total_days'];
    dayOff = json['day off'];
    present = json['present'];
    absent = json['absent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month_title'] = this.monthTitle;
    data['till_days'] = this.tillDays;
    data['total_days'] = this.totalDays;
    data['day off'] = this.dayOff;
    data['present'] = this.present;
    data['absent'] = this.absent;
    return data;
  }
}