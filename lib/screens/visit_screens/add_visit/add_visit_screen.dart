import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocation/model/list_lead_model.dart';
import 'package:stacked/stacked.dart';

import '../../../router.router.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/full_screen_loader.dart';
import '../../../widgets/text_button.dart';
import 'add_visit_view_model.dart';

class AddVisitScreen extends StatefulWidget {
  final ListLeadModel leadModel;
  const AddVisitScreen({super.key, required this.leadModel});

  @override
  State<AddVisitScreen> createState() => _AddVisitScreenState();
}

class _AddVisitScreenState extends State<AddVisitScreen> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddVisitViewModel>.reactive(
        viewModelBuilder: () => AddVisitViewModel(),
        onViewModelReady: (viewModel) => viewModel.initialise(context,widget.leadModel.name!),
        builder: (context, viewModel, child)=>WillPopScope(
          onWillPop: () async{
            if (viewModel.isTimerRunning) {
                await viewModel.saveTimerState();
             }
             return true;
            },
          child: Scaffold(

            appBar:AppBar(title:   Text(viewModel.isEdit? (viewModel.visitData.name ?? ""):'Create Visit',style: TextStyle(fontSize: 18),),
              leading: IconButton.outlined(onPressed: () async =>
                 {
                   if (viewModel.isTimerRunning) {
                      await viewModel.saveTimerState()
                   },
                 Navigator.pop(context)}, icon: const Icon(Icons.arrow_back)),
                 actions: [
                    IconButton.outlined(onPressed: ()=>viewModel.onSavePressed(), icon: const Icon(Icons.check))
                 ],),
            body: fullScreenLoader(
              loader: viewModel.isBusy,context: context,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150,
                              child: _buildInfoItem(
                                  "Full Name",
                                  "${viewModel.leadData.firstName ?? '--'} ${viewModel.leadData.lastName ?? ''}"
                              ),
                            ),
                            Container(
                              width: 150,
                              child: _buildInfoItem(
                                  "Request Type",
                                  viewModel.leadData.customCustomRequestType ?? '--'
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150,
                              child: _buildInfoItem(
                                  "Mobile",
                                  viewModel.leadData.mobileNo ?? '--'
                              ),
                            ),
                            Container(
                              width: 150,
                              child: _buildInfoItem(
                                  "Email",
                                  viewModel.leadData.emailId ?? '--'
                              ),
                            ),
                          ],
                        ),

                        _buildInfoItem("Territory", viewModel.leadData.territory??'--'),
                        const SizedBox(height: 10),
                        const Text(
                          'Notes',
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(), itemCount: viewModel.notes.length, itemBuilder: (context, index) {final noteData = viewModel.notes[index];
                         return Dismissible(
                          background: Container(
                            color: Colors.red.shade400,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.centerLeft,
                            child: const Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.white,size: 40,
                            ),
                          ),

                          direction: DismissDirection.startToEnd,
                          key: Key(index.toString()),
                          child: Card(
                            elevation: 1,
                            color: Colors.white,
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipOval(
                                    // Set background color for the avatar
                                    child: Image.network(
                                      noteData.image ??"",
                                      fit: BoxFit.cover,
                                      height: 30,
                                      width: 30,
                                      loadingBuilder: (BuildContext context, Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          // Image is done loading
                                          return child;
                                        } else {
                                          // Image is still loading
                                          return const Center(
                                              child: CircularProgressIndicator(color: Colors.blueAccent));
                                        }
                                      },
                                      errorBuilder:
                                          (BuildContext context, Object error, StackTrace? stackTrace) {
                                        // Handle the error by displaying a broken image icon
                                        return  Center(
                                            child: Image.asset('assets/images/profile.png',scale: 8,));
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          child: Text(
                                            noteData.note ?? "",
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              noteData.commented ?? "",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            Text(
                                              noteData.addedOn ?? "",
                                              style: const TextStyle(fontSize: 12.0),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        },
                        ),

                        const SizedBox(height: 10),
                        Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        CustomDropdownButton2(value: viewModel.selectedVisitType,items:viewModel.visitType, hintText: 'select the visit type', onChanged:(newValue){viewModel.setVisitType(newValue!);}, labelText: 'Visit Type'),
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
                            Expanded(child: CtextButton(onPressed: () =>  viewModel.onSavePressed(), text: 'Start Timer', buttonColor: Colors.red)),
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
            )

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
            controller: addVisitViewModel.descriptonController,
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


  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }




}