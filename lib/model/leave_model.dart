class LeaveData {
  String? leaveType;
  String? employee;
  String? employeeName;
  double? leavesAllocated;
  double? leavesExpired;
  double? openingBalance;
  double? leavesTaken;
  double? closingBalance;
  int? indent;

  LeaveData(
      {this.leaveType,
        this.employee,
        this.employeeName,
        this.leavesAllocated,
        this.leavesExpired,
        this.openingBalance,
        this.leavesTaken,
        this.closingBalance,
        this.indent});

  LeaveData.fromJson(Map<String, dynamic> json) {
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
