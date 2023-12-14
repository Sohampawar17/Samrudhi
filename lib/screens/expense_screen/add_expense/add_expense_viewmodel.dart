import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../model/expense_model.dart';
import '../../../router.router.dart';
import '../../../services/add_expense_services.dart';

class AddExpenseViewModel extends BaseViewModel{
  TextEditingController datecontroller=TextEditingController();
  TextEditingController descriptoncontroller=TextEditingController();
  TextEditingController amountcontroller=TextEditingController();
  DateTime? selecteddeliveryDate;

  ExpenseData expensedata =ExpenseData();
  final formKey = GlobalKey<FormState>();
  List<String> expensetype=[""];
List<Attachments> attachment=[];

  initialise(BuildContext context) async {
    setBusy(true);
    expensetype=await AddExpenseServices().fetexpensetype();
    setBusy(false);
  }

  
  void onSavePressed(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {
      expensedata.attachments=attachment;
      Logger().i(expensedata.toJson());

      bool res = false;
        res = await AddExpenseServices().bookexpense(expensedata);
        if (res) {
          if (context.mounted) {
            setBusy(false);
            Navigator.pushReplacementNamed(context, Routes.expenseScreen);
          }}
    }
    setBusy(false);
  }

  void setimage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      List<int> imageBytes = await pickedFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
attachment.add(Attachments(name: base64Image));
      // Now you can use the base64Image as needed, such as sending it in your API request.
      print("Base64 Image: $base64Image");
    }
  }

  Future<void> selectdeliveryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selecteddeliveryDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selecteddeliveryDate) {
      selecteddeliveryDate = picked;
      datecontroller.text = DateFormat('yyyy-MM-dd').format(picked);
      expensedata.expenseDate = datecontroller.text;
    }
  }


  void setdate(String expenseDate){
    datecontroller.text=expenseDate;
    expensedata.expenseDate =datecontroller.text;
    notifyListeners();
  }

  void setdescription(String expenseDescription){
    descriptoncontroller.text=expenseDescription;
    expensedata.expenseDescription =descriptoncontroller.text;
    notifyListeners();
  }

  void setamount(String amount){
    amountcontroller.text=amount;
    expensedata.amount =double.tryParse(amountcontroller.text);
    notifyListeners();
  }

  void setexpensetype(String? expenseType){
    expensedata.expenseType =expenseType;
    notifyListeners();
  }

  ///validators
  String? validatedate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Select the date';
    }
    return null;
  }

  String? validateexpensetyepe(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select expense type';
    }
    return null;
  }
  String? validatedescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter description';
    }
    return null;
  }
  String? validateamount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter amount';
    }
    return null;
  }

  ///dispose controllers
  @override
  void dispose() {
    descriptoncontroller.dispose();
    datecontroller.dispose();
    amountcontroller.dispose();
    super.dispose();
  }
}