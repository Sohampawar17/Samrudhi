import 'package:flutter/material.dart';
import 'package:geolocation/constants.dart';
import 'package:geolocation/widgets/drop_down.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:geolocation/widgets/text_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../../widgets/customtextfield.dart';
import '../../../widgets/view_docs_from_internet.dart';
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
                      SizedBox(height: 10,),
                      CtextButton(onPressed: () { model.selectPdf(ImageSource.gallery); }, text: 'Upload Documents',),
//                       ElevatedButton.icon(
//                         onPressed: () {
// model.selectPdf(ImageSource.gallery);
//                         },
//                         icon: Icon(Icons.upload),
//                         label: Text('Upload Document'),
//                       ),
                      SizedBox(height: 10,),
                  model.attachment.isNotEmpty
                      ? SizedBox(height: getHeight(context)/5,
                        child: ListView.separated(
                        itemBuilder: (builder, index) {
                  return  GestureDetector(
                    onTap: () => ViewImageInternet(url: model.attachment[index].fileUrl ?? ""),
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black54, width: 2),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.attachment[index].fileName ?? "",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            icon: Icon(Icons.cancel, color: Colors.redAccent),
                            onPressed: () {
                              model.deleteitem(index, model.attachment[index].name);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                        },separatorBuilder: (context, builder) {
            return const Divider(
            thickness: 0.5,
            );
            },
              itemCount: model.attachment.length,),
                      ):Container(),
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