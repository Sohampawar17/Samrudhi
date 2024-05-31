class ExpenseData {
  String? name;
  String? employee;
  String? employeeName;
  String? company;
  String? workflowState;
  String? expenseApprover;
  String? approvalStatus;
  String? postingDate;
  String? payableAccount;
  double? totalClaimedAmount;
  double? totalSanctionedAmount;
  String? expenseType;
  String? expenseDescription;
  double? amount;
  String? expenseDate;
  List<Attachments>? attachments;
  List<String>? nextAction;
  bool? allowEdit;

  ExpenseData(
      {this.name,
        this.employee,
        this.employeeName,
        this.company,
        this.workflowState,
        this.expenseApprover,
        this.approvalStatus,
        this.postingDate,
        this.payableAccount,
        this.totalClaimedAmount,
        this.totalSanctionedAmount,
        this.expenseType,
        this.expenseDescription,
        this.amount,
        this.expenseDate,
        this.attachments,
        this.nextAction,
        this.allowEdit});

  ExpenseData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    employee = json['employee'];
    employeeName = json['employee_name'];
    company = json['company'];
    workflowState = json['workflow_state'];
    expenseApprover = json['expense_approver'];
    approvalStatus = json['approval_status'];
    postingDate = json['posting_date'];
    payableAccount = json['payable_account'];
    totalClaimedAmount = json['total_claimed_amount'];
    totalSanctionedAmount = json['total_sanctioned_amount'];
    expenseType = json['expense_type'];
    expenseDescription = json['expense_description'];
    amount = json['amount'];
    expenseDate = json['expense_date'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
    nextAction = json['next_action'].cast<String>();
    allowEdit = json['allow_edit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['employee'] = this.employee;
    data['employee_name'] = this.employeeName;
    data['company'] = this.company;
    data['workflow_state'] = this.workflowState;
    data['expense_approver'] = this.expenseApprover;
    data['approval_status'] = this.approvalStatus;
    data['posting_date'] = this.postingDate;
    data['payable_account'] = this.payableAccount;
    data['total_claimed_amount'] = this.totalClaimedAmount;
    data['total_sanctioned_amount'] = this.totalSanctionedAmount;
    data['expense_type'] = this.expenseType;
    data['expense_description'] = this.expenseDescription;
    data['amount'] = this.amount;
    data['expense_date'] = this.expenseDate;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    data['next_action'] = nextAction;
    data['allow_edit'] = this.allowEdit;
    return data;
  }
}

class Attachments {
  String? fileUrl;
  String? name;
  String? fileName;

  Attachments({this.fileUrl, this.name, this.fileName});

  Attachments.fromJson(Map<String, dynamic> json) {
    fileUrl = json['file_url'];
    name = json['name'];
    fileName = json['file_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_url'] = this.fileUrl;
    data['name'] = this.name;
    data['file_name'] = this.fileName;
    return data;
  }
}
