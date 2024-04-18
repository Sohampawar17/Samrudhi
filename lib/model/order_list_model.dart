class OrderList {
  String? name;
  String? customerName;
  String? transactionDate;
  double? grandTotal;
  String? status;
  double? totalQty;
  String? customOrderStatus;

  OrderList(
      {this.name,
      this.customerName,
      this.transactionDate,
      this.grandTotal,
      this.status,
        this.customOrderStatus,
      this.totalQty});

  OrderList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customerName = json['customer_name'];
    transactionDate = json['transaction_date'];
    grandTotal = json['grand_total'];
    customOrderStatus=json['custom_order_status'];
    status = json['status'];
    totalQty = json['total_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['customer_name'] = customerName;
    data['transaction_date'] = transactionDate;
    data['grand_total'] = grandTotal;
    data['custom_order_status']=customOrderStatus;
    data['status'] = status;
    data['total_qty'] = totalQty;
    return data;
  }
}
