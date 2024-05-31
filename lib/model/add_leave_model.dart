class AddLeaveModel {
  String? name;
  String? employee;
  String? employeeName;
  int? docstatus;
  String? company;
  String? workflowState;
  String? leaveType;
  String? fromDate;
  String? toDate;
  int? halfDay;
  String? halfDayDate;
  double? totalLeaveDays;
  String? leaveApprover;
  String? leaveApproverName;
  String? postingDate;
  String? status;
  String? description;
  List<String>? nextAction;
  bool? allowEdit;

  AddLeaveModel(
      {this.name,
        this.employee,
        this.employeeName,
        this.docstatus,
        this.company,
        this.workflowState,
        this.leaveType,
        this.fromDate,
        this.toDate,
        this.halfDay,
        this.halfDayDate,
        this.totalLeaveDays,
        this.leaveApprover,
        this.leaveApproverName,
        this.postingDate,
        this.status,
        this.description,
        this.nextAction,
        this.allowEdit});

  AddLeaveModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    employee = json['employee'];
    employeeName = json['employee_name'];
    docstatus = json['docstatus'];
    company = json['company'];
    workflowState = json['workflow_state'];
    leaveType = json['leave_type'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    halfDay = json['half_day'];
    halfDayDate = json['half_day_date'];
    totalLeaveDays = json['total_leave_days'];
    leaveApprover = json['leave_approver'];
    leaveApproverName = json['leave_approver_name'];
    postingDate = json['posting_date'];
    status = json['status'];
    description = json['description'];
    nextAction = json['next_action'].cast<String>();
    allowEdit = json['allow_edit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['employee'] = this.employee;
    data['employee_name'] = this.employeeName;
    data['docstatus'] = this.docstatus;
    data['company'] = this.company;
    data['workflow_state'] = this.workflowState;
    data['leave_type'] = this.leaveType;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['half_day'] = this.halfDay;
    data['half_day_date'] = this.halfDayDate;
    data['total_leave_days'] = this.totalLeaveDays;
    data['leave_approver'] = this.leaveApprover;
    data['leave_approver_name'] = this.leaveApproverName;
    data['posting_date'] = this.postingDate;
    data['status'] = this.status;
    data['description'] = this.description;
    data['next_action'] = nextAction;
    data['allow_edit'] = this.allowEdit;
    return data;
  }
}
