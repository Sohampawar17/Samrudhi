class ExpenseData {
  String? expenseType;
  String? expenseDescription;
  String? expenseDate;
  List<Attachments>? attachments;
double? amount;
  ExpenseData(
      {this.expenseType,
      this.expenseDescription,
      this.expenseDate,
      this.attachments,
      this.amount});

  ExpenseData.fromJson(Map<String, dynamic> json) {
    expenseType = json['expense_type'];
    amount=json['amount'];
    expenseDescription = json['expense_description'];
    expenseDate = json['expense_date'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expense_type'] = this.expenseType;
    data['expense_description'] = this.expenseDescription;
    data['expense_date'] = this.expenseDate;
    data['amount']=this.amount;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attachments {
  String? name;

  Attachments({this.name});

  Attachments.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
