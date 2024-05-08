import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../router.router.dart';
import '../../../widgets/full_screen_loader.dart';
import '../../lead_screen/update_screen/update_viewmodel.dart';

class UpdateVisitScreen extends StatefulWidget {
  final String updateId;
  const UpdateVisitScreen({super.key, required this.updateId});

  @override
  State<UpdateVisitScreen> createState() => _UpdateVisitScreenState();
}

class _UpdateVisitScreenState extends State<UpdateVisitScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateLeadModel>.reactive(
        viewModelBuilder: () => UpdateLeadModel(),
        onViewModelReady: (model) => model.initialise(context,widget.updateId),
        builder: (context, model, child)=> Scaffold(
          appBar: AppBar(title:  Text(model.leaddata.name ?? "",style: const TextStyle(fontSize: 18),),
            actions: [IconButton(onPressed: ()=>Navigator.pushNamed(context, Routes.addLeadScreen,arguments: AddLeadScreenArguments(leadid: widget.updateId)), icon:const Icon(Icons.edit) ),],
            leading: IconButton.outlined(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back)),),
          body: fullScreenLoader(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                  ],
                ),
              ),
            ),
            loader: model.isBusy,
            context: context,
          ),
          floatingActionButton: FloatingActionButton(onPressed: ()=> Navigator.pushNamed(context, Routes.addLeadScreen,arguments: AddLeadScreenArguments(leadid: '')),child: Icon(Icons.add),),
        ));
  }


}