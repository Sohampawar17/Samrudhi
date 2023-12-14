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
    isSelecteditems = itemlist;
    isSelecteditems.clear(); // Clear the list before adding items
    selecteditems = await AddQuotationServices().fetchitems();
    filteredItems=selectedItems;
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
    notifyListeners();
  }

  void additem(int index) {
    quantity++;
    selecteditems[index].qty =
        quantity.toDouble() as double?; // or just quantity.toDouble()
    notifyListeners();
  }


  void searchItems(String query) {
    filteredItems = selecteditems
        .where((item) =>
        item.itemName.toString().toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  num getQuantity(Items item) {
    return item.qty ?? 0.0;
  }

  void removeitem(int index) {
    if (quantity > 0) {
      quantity--;
      selecteditems[index].qty =
          quantity.toDouble() as double?; // or just quantity.toDouble()
      notifyListeners();
    }
  }
}
