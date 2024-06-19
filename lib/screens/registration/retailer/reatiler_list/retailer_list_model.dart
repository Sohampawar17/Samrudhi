import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../router.router.dart';
import '../../../../services/list_retailer_services.dart';

class RetailerListViewModel extends BaseViewModel{
  final TextEditingController searchController = TextEditingController();
  List<RetailerListModel> retailerList=[];
  List<RetailerListModel> filterRetailerList=[];
  String filterQuery = '';
  initialise(BuildContext context) async {
    setBusy(true);
retailerList=await RetailerListServices().retailers();
    filterRetailerList=retailerList;
    setBusy(false);
  }

  void onRowClick(BuildContext context, RetailerListModel? leadList) {
    Navigator.pushNamed(
      context,
      Routes.addRetailerScreen,
      arguments: AddRetailerScreenArguments(retailerId: leadList?.name.toString() ?? ""),
    );
  }

  Future<void> refresh() async {
    filterRetailerList=await RetailerListServices().retailers();
    notifyListeners();
  }

  void searchItems(String query) {
    filterRetailerList = retailerList.where((shop) {
    final lowerCaseQuery = query.toLowerCase();
    final matchNameOfTheShop = shop.nameOfTheShop?.toLowerCase().contains(lowerCaseQuery);
    final matchNameOfTheShopOwner = shop.nameOfTheShopOwner?.toLowerCase().contains(lowerCaseQuery);
    return matchNameOfTheShop! || matchNameOfTheShopOwner!;
    }).toList();
    notifyListeners();
  }
}

class RetailerListModel {
  String? nameOfTheShop;
  String? nameOfTheShopOwner;
  String? territorry;
  String? creation;
  String? name;

  RetailerListModel(
      {this.nameOfTheShop,
        this.nameOfTheShopOwner,
        this.territorry,
        this.creation,
        this.name});

  RetailerListModel.fromJson(Map<String, dynamic> json) {
    nameOfTheShop = json['name_of_the_shop'];
    nameOfTheShopOwner = json['name_of_the_shop_owner'];
    territorry = json['territorry'];
    creation = json['creation'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_of_the_shop'] = this.nameOfTheShop;
    data['name_of_the_shop_owner'] = this.nameOfTheShopOwner;
    data['territorry'] = this.territorry;
    data['creation'] = this.creation;
    data['name'] = this.name;
    return data;
  }
}
