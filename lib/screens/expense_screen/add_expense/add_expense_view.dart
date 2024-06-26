import 'package:flutter/material.dart';
import 'package:geolocation/constants.dart';
import 'package:geolocation/widgets/drop_down.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:geolocation/widgets/text_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import '../../../widgets/customtextfield.dart';
import '../../../widgets/view_docs_from_internet.dart';
import 'add_expense_viewmodel.dart';

class AddExpenseScreen extends StatefulWidget {
final String expenseId;
  const AddExpenseScreen({super.key, required this.expenseId});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddExpenseViewModel>.reactive(
        viewModelBuilder: () => AddExpenseViewModel(),
        onViewModelReady: (model) => model.initialise(context,widget.expenseId),
        builder: (context, model, child)=>Scaffold(
backgroundColor: Colors.white,
          appBar:AppBar(title:   Text( model.isEdit==true?"Update Expense":'Create Expense',style: TextStyle(fontSize: 18),),
           ),
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
const SizedBox(height: 10,),
CustomDropdownButton2(items:model.expensetype, hintText: 'select the expense type', onChanged: model.setexpensetype, labelText: 'Expense Type',validator: model.validateexpensetyepe,value: model.expensedata.expenseType,),
                      const SizedBox(height: 10,),
                      CustomSmallTextFormField(controller: model.descriptoncontroller, labelText: 'Expense Description', hintText: 'Enter the Description',validator: model.validatedescription,onChanged: model.setdescription,),
                      const SizedBox(height: 10,),
                      CustomSmallTextFormField(controller: model.amountcontroller, labelText: 'Amount', hintText: 'Enter the amount',validator: model.validateamount,onChanged: model.setamount,keyboardtype: TextInputType.number,),
                      const SizedBox(height: 10,),


                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          elevation: 1,
                        ),
                        onPressed: () {
model.selectPdf(ImageSource.gallery);
                        },
                        icon: const Icon(Icons.upload,color: Colors.white,),
                        label: const Text('Upload Document',style: TextStyle(color: Colors.white,),),
                      ),
                      const SizedBox(height: 10,),
                  model.attachment.isNotEmpty
                      ? SizedBox(height: getHeight(context)/5,
                        child: ListView.separated(
                        itemBuilder: (builder, index) {
                  return  InputChip(
                    deleteIconColor: Colors.red,
                    onPressed: (){
                      ViewImageInternet(url: model.attachment[index].name ??"");
                    },
onDeleted: () {
  model.deleteitem(index, model.attachment[index].name);
},
                    label: Text(
                      model.attachment[index].fileName ?? "",
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  );
                        },separatorBuilder: (context, builder) {
            return const Divider(
            thickness: 1,
            );
            },
              itemCount: model.attachment.length,),
                      ):Container(),
                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Expanded(child: CtextButton(onPressed: () => Navigator.of(context).pop(), text: 'Cancel', buttonColor: Colors.red.shade500,)),
                      SizedBox(width: 20,),    Expanded(child: CtextButton(onPressed: ()=> model.onSavePressed(context), text:model.isEdit==true?"Update Expense":'Create Expense', buttonColor: Colors.blueAccent,))
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