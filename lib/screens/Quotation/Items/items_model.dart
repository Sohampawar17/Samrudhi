import 'package:flutter/cupertino.dart';
import 'package:geolocation/services/add_quotation_services.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../../../model/addquotation_model.dart';



class QuotationItemListModel extends BaseViewModel {
  List<Items> selecteditems = [];
  List<Items> isSelecteditems = [];
  double quantity = 0.0;
  final TextEditingController searchController = TextEditingController();
  List<Items> get selectedItems => selecteditems;
  List<Items> filteredItems = [];
  bool isSelected(Items item) {
    return isSelecteditems.contains(item);
  }

  void initialise(
      BuildContext context,  List<Items> itemlist) async {
    setBusy(true);
    Logger().i(itemlist.length);
// Clear the list before adding items
    selecteditems = await AddQuotationServices().fetchitems();
    filteredItems=selectedItems;
    for (var selectedItem in itemlist) {
      var originalItem =
      filteredItems.firstWhere((item) => item.itemCode == selectedItem.itemCode);
      originalItem.qty = selectedItem.qty;
      isSelected(originalItem);
    }
    isSelecteditems
        .addAll(itemlist.toList());
    Logger().i(isSelecteditems.length);
    notifyListeners();
    setBusy(false);
  }

  void toggleSelection(Items item) {
    if (isSelected(item)) {
      isSelecteditems.remove(item);
    } else {
      isSelecteditems.add(item);
    }
    print(isSelecteditems);
    for (var i in isSelecteditems){
      Logger().i(i.qty);
    }
    notifyListeners();
  }

  void additem(int index) {
    quantity++;
    selecteditems[index].qty =
        quantity.toDouble(); // or just quantity.toDouble()
    notifyListeners();
  }

  void searchItems(String query) {
    filteredItems = selecteditems
        .where((item) =>
        item.itemName.toString().toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  double getQuantity(Items item) {
    return item.qty ?? 1.0;
  }

  void removeitem(int index) {
    if (quantity > 0) {
      quantity--;
      selecteditems[index].qty =
          quantity.toDouble(); // or just quantity.toDouble()
      notifyListeners();
    }
  }
}
