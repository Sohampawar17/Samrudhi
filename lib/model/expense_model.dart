class ExpenseData {
  String? expenseType;
  String? expenseDescription;
  String? expenseDate;
  double? amount;
  List<Attachments>? attachments;

  ExpenseData(
      {this.expenseType,
        this.expenseDescription,
        this.expenseDate,
        this.amount,
        this.attachments});

  ExpenseData.fromJson(Map<String, dynamic> json) {
    expenseType = json['expense_type'];
    expenseDescription = json['expense_description'];
    expenseDate = json['expense_date'];
    amount = json['amount'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expense_type'] = this.expenseType;
    data['expense_description'] = this.expenseDescription;
    data['expense_date'] = this.expenseDate;
    data['amount'] = this.amount;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attachments {
  String? name;
  String? fileName;
  String? fileUrl;
  Attachments({this.name, this.fileName,this.fileUrl});

  Attachments.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fileName = json['file_name'];
    fileUrl=json["file_url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['file_name'] = this.fileName;
    data['file_url']=this.fileUrl;
    return data;
  }
}
