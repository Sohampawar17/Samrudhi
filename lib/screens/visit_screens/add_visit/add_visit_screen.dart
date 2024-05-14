import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import '../../../router.router.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/full_screen_loader.dart';
import '../../../widgets/text_button.dart';
import 'add_visit_view_model.dart';

class AddVisitScreen extends StatefulWidget {
  final String VisitId;
  const AddVisitScreen({super.key, required this.VisitId});

  @override
  State<AddVisitScreen> createState() => _AddVisitScreenState();
}

class _AddVisitScreenState extends State<AddVisitScreen> {


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddVisitViewModel>.reactive(
        viewModelBuilder: () => AddVisitViewModel(),
        onViewModelReady: (viewModel) => viewModel.initialise(context,widget.VisitId),
        builder: (context, viewModel, child)=>Scaffold(

          appBar:AppBar(title:   Text(viewModel.isEdit? (viewModel.visitdata.name ?? ""):'Create Visit',style: TextStyle(fontSize: 18),),
            leading: IconButton.outlined(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back)),actions: [
              IconButton.outlined(onPressed: ()=>viewModel.onSavePressed(context), icon: const Icon(Icons.check))
            ],),
          body: fullScreenLoader(
            loader: viewModel.isBusy,context: context,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                 Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomDropdownButton2(value: viewModel.visitdata.customer,items:viewModel.customer, hintText: 'select the customer', onChanged: viewModel.setcustomer, labelText: 'Customer'),
                      const SizedBox(height: 15,),
                      CustomDropdownButton2(value: viewModel.visitdata.visitType,items:viewModel.visitType, hintText: 'select the visit type', onChanged: viewModel.seteleavetype, labelText: 'Visit Type'),
                      const SizedBox(height: 15,),

                      const Text(
                        'Timer',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        viewModel.formatTimer(viewModel.countdownSeconds),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: CtextButton(onPressed: () => viewModel.initTimerOperation(context), text: 'Start Timer', buttonColor: Colors.red)),
                          SizedBox(width: 20),
                          Expanded(child: CtextButton(onPressed: () =>
                          {
                            viewModel.stopTimer(),
                            showAlertDialog(context,viewModel)
                          },
                            text: 'Stop Timer',
                            buttonColor: Colors.blue,))

                          //CtextButton(onPressed: () => resetTimer, text: 'Reset', buttonColor: Colors.redAccent.shade400,)
                        ],
                      )
                    ],
                  ),

                      const SizedBox(height: 25,),

                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  if (!viewModel.isTimerRunning) {
                    Navigator.pushNamed(context, Routes.addCustomer,arguments: const AddCustomerArguments( id: ''));
                  }
                },
                child: Icon(Icons.person),
                backgroundColor: Colors.white,
              ),
              SizedBox(height: 16),
              FloatingActionButton(
                onPressed: () {
                  if (!viewModel.isTimerRunning) {
                    Navigator.pushNamed(context, Routes.addLeadScreen,arguments: const AddLeadScreenArguments( leadid: ''));
                  }
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.white,
              ),
            ],
          ),

        ));
  }

  void showAlertDialog(BuildContext context,AddVisitViewModel addVisitViewModel) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Report'),
          content: TextField(
            controller: addVisitViewModel.descriptoncontroller,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Enter your description',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                addVisitViewModel.onVisitSubmit(context);

                Navigator.of(context).popUntil((route) => route.settings.name == Routes.visitScreen);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }




}