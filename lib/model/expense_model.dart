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
        attachments!.add(Attachments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['expense_type'] = expenseType;
    data['expense_description'] = expenseDescription;
    data['expense_date'] = expenseDate;
    data['amount'] = amount;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['file_name'] = fileName;
    data['file_url']=fileUrl;
    return data;
  }
}
