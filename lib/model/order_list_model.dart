class OrderList {
  String? name;
  String? customerName;
  String? transactionDate;
  double? grandTotal;
  String? status;
  double? totalQty;

  OrderList(
      {this.name,
      this.customerName,
      this.transactionDate,
      this.grandTotal,
      this.status,
      this.totalQty});

  OrderList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customerName = json['customer_name'];
    transactionDate = json['transaction_date'];
    grandTotal = json['grand_total'];
    status = json['status'];
    totalQty = json['total_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['customer_name'] = customerName;
    data['transaction_date'] = transactionDate;
    data['grand_total'] = grandTotal;
    data['status'] = status;
    data['total_qty'] = totalQty;
    return data;
  }
}
