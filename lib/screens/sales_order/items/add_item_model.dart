import 'package:flutter/cupertino.dart';
import 'package:geolocation/model/add_order_model.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../services/add_order_services.dart';

class ItemListModel extends BaseViewModel {
  List<Items> selecteditems = [];
  List<Items> isSelecteditems = [];
  double quantity = 0.0;
  final TextEditingController searchController = TextEditingController();
  List<Items> get selectedItems => selecteditems;

  bool isSelected(Items item) {
    return isSelecteditems.contains(item);
  }

bool selected=false;
  List<Items> filteredItems = [];

  void initialise(
      BuildContext context, String warehouse, List<Items> itemList) async {
    setBusy(true);
    selecteditems = await AddOrderServices().fetchitems(warehouse);
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

  void toggleSelection(Items item) {
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


  double getQuantity(Items item) {
    return item.qty ?? 1.0;
  }
}
