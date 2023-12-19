import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../model/addquotation_model.dart';
import '../../../model/quotation_details_model.dart';
import '../../../router.router.dart';
import 'package:intl/intl.dart';
import '../../../services/add_quotation_services.dart';


class AddQuotationModel extends BaseViewModel {

  final formKey = GlobalKey<FormState>();
  DateTime? selectedtransactionDate;
  DateTime? selectedvalidtillDate;
  List<String> searchcustomer = [""];
  List<String> quotationto = ["Customer","Lead","Prospect"];
  List<Items> selectedItems = [];
  List<Items> selectedItemsList = [];
  List<QuotationDetailsModel> quotationdetailsmodel = [];
  Items product = Items();
  // int quantity= 0;
  bool res = false;
  bool isEdit = false;
  bool isloading = false;
  List<String> ordetype = ["Sales", "Maintenance", "Shopping Cart"];
  TextEditingController customercontroller = TextEditingController();
  TextEditingController customernamecontroller = TextEditingController();
  TextEditingController searchcustomercontroller = TextEditingController();
  TextEditingController validtilldatecontroller = TextEditingController();

  //TextEditingController quotationtodatecontroller = TextEditingController();
  late String QuotationId;

  String customerLabel = 'Customer';
  AddQuotation quotationdata = AddQuotation();

  initialise(BuildContext context, String quotationid) async {
    setBusy(true);
    // searchcustomer = await AddQuotationServices().fetchcustomer();
  //  warehouse = await AddQuotationServices().fetchwarehouse();
    QuotationId = quotationid;

    //setting aleardy available data
    if (QuotationId != "") {
      isEdit = true;
      quotationdata = await AddQuotationServices().getquotation(quotationid) ?? AddQuotation();
      customercontroller.text = quotationdata.partyName ?? "";
      validtilldatecontroller.text = quotationdata.validTill ?? "";
      customernamecontroller.text=quotationdata.customerName ?? "";
    //  quotationtodatecontroller.text = quotationdata.quotationTo ??"";
      selectedItems.addAll(quotationdata.items?.toList() ?? []);

    }
    quotationdata.orderType = "Sales";
    notifyListeners();
    setBusy(false);
  }

  void onSavePressed(BuildContext context) async {
   
    isloading = true;
    if (formKey.currentState!.validate()) {
      quotationdata.items = selectedItems;
      bool res = false;
      Logger().i(quotationdata.toJson());
      if(isEdit == true){
        res = await AddQuotationServices().addOrder(quotationdata);
        if (res) {
          if (context.mounted) {
            isloading = false;
            isloading = false;
            Navigator.pushReplacementNamed(context, Routes.listQuotationScreen);
          }
        }
      }else{
        res = await AddQuotationServices().addOrder(quotationdata);
        if (res) {
          if (context.mounted) {
            isloading = false;
            isloading = false;
            Navigator.pushReplacementNamed(context, Routes.listQuotationScreen);
          }
        }}
    }
    isloading = false;
  }

  ///dates functions///

  Future<void> selectvalidtillDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedvalidtillDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != selectedvalidtillDate) {
      selectedvalidtillDate = picked;
      validtilldatecontroller.text = DateFormat('yyyy-MM-dd').format(picked);
      quotationdata.validTill = validtilldatecontroller.text;
    }
  }




  ///setvalues//

  void onvalidtillDobChanged(String value) {
    quotationdata.validTill = value;
  }

  void setcustomer(String? customer) {
    quotationdata.partyName = customer;
    notifyListeners();
  }
  void setquotationto(String? quotationTo) async {
    quotationdata.quotationTo = quotationTo;
    quotationdata.partyName="";
    if(quotationTo!.isNotEmpty){
    searchcustomer= await AddQuotationServices().getcustomer(quotationTo);}
    setCustomerLabel(quotationTo);
    notifyListeners();
  }


  void setordertype(String? ordertype) {
    quotationdata.orderType = ordertype;
    notifyListeners();
  }

 // Default label for the customer dropdown

  void setCustomerLabel(String? quotationTo) {
    // Customize the label based on the selected value of quotationTo
    if (quotationTo == 'Prospect') {
      customerLabel = 'Prospect';
    } else if (quotationTo == 'Lead') {
      customerLabel = 'Lead';
    } else {
      customerLabel = 'Customer';
    }
    notifyListeners();
  }



  //
  //
  // void addProduct(String? product) {
  //
  //   bool isItemAlreadyAdded = products.any((existingProduct) =>
  //   existingProduct.productName == product);
  //   Logger().i(product);
  //   final selectedCaneData = productList.firstWhere(
  //           (caneData) => caneData.productName == product);
  //
  //   if (!isItemAlreadyAdded) {
  //     products.add(Product(
  //       productName: selectedCaneData.name,
  //       product: selectedCaneData.product,
  //       description: selectedCaneData.description,
  //     ));
  //     notifyListeners();
  //   }
  // }




  void setSelectedItems(List<Items> SelectedItems) async {
    selectedItems = SelectedItems;
    for (var item in selectedItems) {
    //  item.validTill = quotationdata.validTill;
      item.amount = ((item.qty ?? 0.0) * (item.rate ?? 0.0));
    }
    quotationdata.items = selectedItems;
    Logger().i(quotationdata.toJson());
    quotationdetails(await AddQuotationServices().quotationdetails(quotationdata));
    notifyListeners();
  }

  void quotationdetails(List<QuotationDetailsModel> quotationdetail) {
    quotationdata.totalTaxesAndCharges =
    (quotationdetail.isNotEmpty ? quotationdetail[0].totalTaxesAndCharges : 0.0) ;
    quotationdata.grandTotal =
    (quotationdetail.isNotEmpty ? quotationdetail[0].grandTotal : 0.0) ;
    quotationdata.discountAmount =
    (quotationdetail.isNotEmpty ? quotationdetail[0].discountAmount : 0.0) ;
    quotationdata.total = (quotationdetail.isNotEmpty ? quotationdetail[0].netTotal : 0.0) ;
    quotationdata.netTotal = (quotationdetail.isNotEmpty ? quotationdetail[0].netTotal : 0.0) ;
  }

  void updateItemQuantity(int index, int quantityChange) async {
    if (selectedItems.isNotEmpty) {
      selectedItems[index].qty =
          ((selectedItems[index].qty ?? 0.0) + quantityChange.toDouble());
      selectedItems[index].amount = ((selectedItems[index].qty ?? 0.0) *
          (selectedItems[index].rate ?? 0.0));
      quotationdetails(await AddQuotationServices().quotationdetails(quotationdata));
    }
    notifyListeners();
  }

  num getQuantity(Items item) {
    return item.qty ?? 0;
  }

  void additem(int index) async {
    updateItemQuantity(index, 1);
    notifyListeners();
  }

  void removeitem(int index) async {
    updateItemQuantity(index, -1);
    notifyListeners();
  }

  // void deleteitem(int index) async {
  //   selectedItems.removeAt(index);
  //   notifyListeners();
  //   quotationdetails(await AddQuotationServices().quotationdetails(quotationdata));
  //   Logger().i(selectedItems.length);
  // }

  Function(Items removedItem)? onItemRemovedCallback;

  // Method to listen for item removal
  void listenForItemRemoval(Function(Items removedItem) callback) {
    onItemRemovedCallback = callback;
  }


  // Method to trigger item removal callback
  void triggerItemRemovalCallback(Items removedItem) {
    if (onItemRemovedCallback != null) {
      onItemRemovedCallback!(removedItem);
    }
  }

  void deleteitem(int index) async {
    selectedItems.removeAt(index);
    notifyListeners();
    quotationdetails(await AddQuotationServices().quotationdetails(quotationdata));
    Logger().i(selectedItems.length);

    // Trigger the callback when an item is removed
    triggerItemRemovalCallback(selectedItems[index]);
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
    validtilldatecontroller.dispose();
    super.dispose();
  }
}
