import 'package:flutter/material.dart';
import 'package:geolocation/widgets/drop_down.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:geolocation/widgets/text_button.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../../widgets/customtextfield.dart';
import 'add_expense_viewmodel.dart';

class AddExpenseScreen extends StatefulWidget {

  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddExpenseViewModel>.reactive(
        viewModelBuilder: () => AddExpenseViewModel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child)=>Scaffold(

          appBar:AppBar(title:  Text('Create Expense',style: TextStyle(fontSize: 18),),
            leading: IconButton.outlined(onPressed: ()=>Navigator.popAndPushNamed(context, Routes.expenseScreen), icon: const Icon(Icons.arrow_back)),actions: [
               IconButton.outlined(onPressed: ()=>model.onSavePressed(context), icon: const Icon(Icons.check))
            ],),
          body: fullScreenLoader(
            loader: model.isBusy,context: context,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        readOnly: true,
                        controller: model.datecontroller,
                        onTap: () => model.selectdeliveryDate(context),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          labelText: 'Expense date',
                          hintText: 'Enter the expense Date',
                          prefixIcon:const Icon(Icons.calendar_today_rounded),
                          labelStyle: const TextStyle(
                            color: Colors.black54, // Customize label text color
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          hintStyle: const TextStyle(
                            color: Colors.grey, // Customize hint text color
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            borderSide: const BorderSide(
                              color: Colors.blue, // Customize focused border color
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            borderSide: const BorderSide(
                              color: Colors.grey, // Customize enabled border color
                            ),
                          ),
                        ),
                        validator: model.validatedate,
                        onChanged: model.setdate,
                      ),
SizedBox(height: 10,),
CustomDropdownButton2(items:model.expensetype, hintText: 'select the expense type', onChanged: model.setexpensetype, labelText: 'Expense Type'),
                      SizedBox(height: 10,),
                      CustomSmallTextFormField(controller: model.descriptoncontroller, labelText: 'Expense Description', hintText: 'Enter the Description',validator: model.validatedescription,onChanged: model.setdescription,),
                      SizedBox(height: 10,),
                      CustomSmallTextFormField(controller: model.amountcontroller, labelText: 'Amount', hintText: 'Enter the amount',validator: model.validateamount,onChanged: model.setamount,keyboardtype: TextInputType.number,),
                      SizedBox(height: 25,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [CtextButton(onPressed: () => Navigator.of(context).pop(), text: 'Cancel'),
                          CtextButton(onPressed: ()=> model.onSavePressed(context), text:'Create Expense')
              ]
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),  ));
  }
}