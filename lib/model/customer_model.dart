class Customer {
  String? name;
  String? customerName;
  String? defaultPriceList;

  Customer({this.name, this.customerName, this.defaultPriceList});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customerName = json['customer_name'];
    defaultPriceList = json['default_price_list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['customer_name'] = this.customerName;
    data['default_price_list'] = this.defaultPriceList;
    return data;
  }
}
