import 'package:flutter/cupertino.dart';

import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../../../model/add_invoice_model.dart';
import '../../../services/add_invoice_services.dart';

class ItemListModel extends BaseViewModel {
  List<InvoiceItems> selecteditems = [];
  List<InvoiceItems> isSelecteditems = [];
  double quantity = 0.0;
  final TextEditingController searchController = TextEditingController();
  List<InvoiceItems> get selectedItems => selecteditems;

  bool isSelected(InvoiceItems item) {
    return isSelecteditems.contains(item);
  }

bool selected=false;
  List<InvoiceItems> filteredItems = [];

  void initialise(
      BuildContext context, List<InvoiceItems> itemList,String warehouse) async {
    setBusy(true);
 selecteditems = await AddInvoiceServices().fetchitems(warehouse);
   filteredItems=selectedItems;
    for (var selectedItem in itemList) {
      var originalItem =
      filteredItems.firstWhere((item) => item.itemCode == selectedItem.itemCode);
      originalItem.qty = selectedItem.qty;
      toggleSelection(originalItem);
    }


    Logger().i(isSelecteditems.length);
    notifyListeners();
    setBusy(false);
  }


  void searchItems(String query) {
    filteredItems = selecteditems
        .where((item) =>
        item.itemName.toString().toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void toggleSelection(InvoiceItems item) {
    if (isSelected(item)) {
      isSelecteditems.remove(item);
    } else {
      isSelecteditems.add(item);
    }
    notifyListeners();
  }

  void additem(int index) {
    selecteditems[index].qty = (selecteditems[index].qty ?? 0) + 1;
    notifyListeners();
  }

  void removeitem(int index) {
    if (selecteditems[index].qty != null && selecteditems[index].qty! > 0) {
      selecteditems[index].qty = (selecteditems[index].qty!) - 1;
      notifyListeners();
    }
  }

  double getQuantity(InvoiceItems item) {
    return item.qty ?? 1.0;
  }
}
