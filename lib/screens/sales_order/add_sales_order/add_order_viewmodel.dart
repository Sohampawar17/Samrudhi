import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/model/order_details_model.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../model/add_order_model.dart';
import '../../../router.router.dart';
import '../../../services/add_order_services.dart';
import 'package:intl/intl.dart';

class AddOrderViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  DateTime? selectedtransactionDate;
  DateTime? selecteddeliveryDate;
  List<String> searchcutomer = [""];
  List<String> warehouse = [""];
  List<Items> selectedItems = [];
  List<OrderDetailsModel> orderetails = [];

  // int quantity= 0;
  bool res = false;
  bool isEdit = false;
  bool isloading = false;
  
  List<String> ordetype = ["Sales", "Maintenance", "Shopping Cart"];
  TextEditingController customercontroller = TextEditingController();
  TextEditingController searchcustomercontroller = TextEditingController();
  TextEditingController deliverydatecontroller = TextEditingController();
  late String orderId;

  AddOrderModel orderdata = AddOrderModel();

  initialise(BuildContext context, String orderid) async {
    setBusy(true);
    searchcutomer = await AddOrderServices().fetchcustomer();
    warehouse = await AddOrderServices().fetchwarehouse();
    orderId = orderid;
   
    //setting aleardy available data
    if (orderId != "") {
      isEdit = true;
      orderdata = await AddOrderServices().getOrder(orderid) ?? AddOrderModel();
      customercontroller.text = orderdata.customer ?? "";
      deliverydatecontroller.text = orderdata.deliveryDate ?? "";
      selectedItems.addAll(orderdata.items?.toList() ?? []);
    }
    orderdata.orderType = "Sales";
    notifyListeners();
    setBusy(false);
  }

  void onSavePressed(BuildContext context) async {
     if(orderdata.docstatus == 1){
      Fluttertoast.showToast(msg: 'You cannot edit the Submitted documnet',backgroundColor: Colors.redAccent,textColor: Colors.white );
    }
    isloading = true;
    if (formKey.currentState!.validate()) {
      orderdata.items = selectedItems;
      bool res = false;
      Logger().i(orderdata.toJson());
      if(isEdit == true){
        res = await AddOrderServices().addOrder(orderdata);
        if (res) {
          if (context.mounted) {
            isloading = false;
            isloading = false;
            Navigator.pushReplacementNamed(context, Routes.listOrderScreen);
          }
        }
      }else{
      res = await AddOrderServices().addOrder(orderdata);
      if (res) {
        if (context.mounted) {
          isloading = false;
          isloading = false;
          Navigator.pushReplacementNamed(context, Routes.listOrderScreen);
        }
      }}
    }
    isloading = false;
  }

  ///dates functions///

  Future<void> selectdeliveryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selecteddeliveryDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selecteddeliveryDate) {
      selecteddeliveryDate = picked;
      deliverydatecontroller.text = DateFormat('yyyy-MM-dd').format(picked);
      orderdata.deliveryDate = deliverydatecontroller.text;
    }
  }

  ///setvalues//

  void ondeliveryDobChanged(String value) {
    orderdata.deliveryDate = value;
  }

  void setcustomer(String? customer) {
    orderdata.customer = customer;
    notifyListeners();
  }

  void setordertype(String? ordertype) {
    orderdata.orderType = ordertype;
    notifyListeners();
  }

  void setwarehouse(String? setWarehouse) {
    orderdata.setWarehouse = setWarehouse;
    notifyListeners();
  }



  void setSelectedItems(List<Items> selectedItems) async {
    for (var item in selectedItems) {
      // Check if the item is already present in the list
      var existingItem = this.selectedItems.firstWhereOrNull(
            (selectedItem) => selectedItem.itemCode == item.itemCode,
      );

      if (existingItem != null) {
        // Update quantity and amount for existing item
        existingItem.qty = (existingItem.qty ?? 0) + (item.qty ?? 0);
        existingItem.amount = (existingItem.qty ?? 1.0) * (existingItem.rate ?? 0.0);
      } else {
        // If the item is not present, add it to the list
        item.warehouse = orderdata.setWarehouse;
        item.deliveryDate = orderdata.deliveryDate;
        item.amount = (item.qty ?? 1.0) * (item.rate ?? 0.0);
        this.selectedItems.add(item);
      }
    }

    orderdata.items = this.selectedItems;
    Logger().i(orderdata.toJson());
    orderdetails(await AddOrderServices().orderdetails(orderdata));
    notifyListeners();
  }


  void orderdetails(List<OrderDetailsModel> orderdetail) {
    orderdata.totalTaxesAndCharges =
        orderdetail.isNotEmpty ? orderdetail[0].totalTaxesAndCharges : 0.0;
    orderdata.grandTotal =
        orderdetail.isNotEmpty ? orderdetail[0].grandTotal : 0.0;
    orderdata.discountAmount =
        orderdetail.isNotEmpty ? orderdetail[0].discountAmount : 0.0;
    orderdata.total = orderdetail.isNotEmpty ? orderdetail[0].netTotal : 0.0;
    orderdata.netTotal = orderdetail.isNotEmpty ? orderdetail[0].netTotal : 0.0;
  }

  void updateItemQuantity(int index, int quantityChange) async {
    if (selectedItems.isNotEmpty) {
      selectedItems[index].qty =
          (selectedItems[index].qty ?? 0.0) + quantityChange.toDouble();
      selectedItems[index].amount = (selectedItems[index].qty ?? 0.0) *
          (selectedItems[index].rate ?? 0.0);
      orderdetails(await AddOrderServices().orderdetails(orderdata));
    }
    notifyListeners();
  }

  double getQuantity(Items item) {
    return item.qty ?? 1;
  }

  void additem(int index) async {
    updateItemQuantity(index, 1);
    notifyListeners();
  }

  void removeitem(int index) async {
    updateItemQuantity(index, -1);
    notifyListeners();
  }

  void deleteitem(int index) async {
   selectedItems.removeAt(index);
   orderdetails(await AddOrderServices().orderdetails(orderdata));
    notifyListeners();

   Logger().i(selectedItems.length);
  }



  ///validators////
  String? validatewarehouse(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Source warehouse';
    }
    return null;
  }

  String? validatedeliveryDob(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Delivery Date';
    }
    return null;
  }

  String? validateordertype(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Order Type';
    }
    return null;
  }

  @override
  void dispose() {
    customercontroller.dispose();
    deliverydatecontroller.dispose();
    super.dispose();
  }
}
