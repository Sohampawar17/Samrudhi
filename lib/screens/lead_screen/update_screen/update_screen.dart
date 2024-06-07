
import 'package:flutter/material.dart';
import 'package:geolocation/screens/lead_screen/update_screen/update_viewmodel.dart';
import 'package:geolocation/widgets/customtextfield.dart';
import 'package:geolocation/widgets/drop_down.dart';

import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';


class UpdateLeadScreen extends StatefulWidget {
  final String updateId;
  const UpdateLeadScreen({super.key, required this.updateId});

  @override
  State<UpdateLeadScreen> createState() => _UpdateLeadScreenState();
}

class _UpdateLeadScreenState extends State<UpdateLeadScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateLeadModel>.reactive(
        viewModelBuilder: () => UpdateLeadModel(),
        onViewModelReady: (model) => model.initialise(context,widget.updateId),
        builder: (context, model, child)=> Scaffold(
          appBar: AppBar(title:  Text(model.leaddata.name ?? "",style: const TextStyle(fontSize: 18),),
            actions: [IconButton(onPressed: ()=>Navigator.popAndPushNamed(context, Routes.addLeadScreen,arguments: AddLeadScreenArguments(leadid: widget.updateId)), icon:const Icon(Icons.edit) ),],
      ),
          body: fullScreenLoader(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 1,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: <Widget>[

                                  _buildInfoItem('Requested Type', model.leaddata.customCustomRequestType ?? ""),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                                    decoration: BoxDecoration(

                                      color: model.getColorForStatus(model.leaddata.customEnquiryStatus.toString()).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            model.leaddata.customEnquiryStatus ?? "",
                                            style: TextStyle(

                                              color: model.getColorForStatus(model.leaddata.customEnquiryStatus.toString()),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          PopupMenuButton<String>(
                                            icon: Icon(Icons.arrow_drop_down, color: model.getColorForStatus(model.leaddata.customEnquiryStatus.toString())),
                                            itemBuilder: (BuildContext context) {
                                              return model.enquiryTypes.map<PopupMenuItem<String>>((String item) {
                                                return PopupMenuItem<String>(
                                                  value: item,
                                                  child: Text(item),
                                                );
                                              }).toList();
                                            },
                                            onSelected: (String value) {

                                                setState(() {
                                                  model.leaddata.customEnquiryStatus = value;
                                                  if(value == "Not Interested"){
                                                    showAlertDialog(context, model);
                                                  }else if(value == "Interested"){
                                                    model.updateEnquiryType(value, "");
                                                  }
                                                });


                                            },
                                          ),]
                                    ),
                                  )
                                  // _buildDropdown('Enquiry Status', model),

                                ]
                            ),
                            if(model.leaddata.customReason !="")
                            _buildInfoItem('Reason', model.leaddata.customReason ?? ""),
                            _buildInfoItem('Lead Owner', model.leaddata.leadOwner ?? ""),
                            _buildInfoItem('Name', model.leaddata.leadName ?? ""),
                            _buildInfoItem('Email', model.leaddata.emailId ??""),
                            _buildInfoItem('Mobile', model.leaddata.mobileNo ?? ""),
                            _buildInfoItem('Territory', model.leaddata.territory ?? ""),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildContactButton(
                                  image: 'assets/images/whatsapp.png',
                                  onPressed: () => model.whatsapp(model.leaddata.mobileNo ?? ""),
                                ),
                                _buildContactButton(
                                  image: 'assets/images/telephone.png',
                                  onPressed: () => model.service.call(model.leaddata.mobileNo ?? ""),
                                ),
                                _buildContactButton(
                                  image: 'assets/images/comments.png',
                                  onPressed: () => model.service.sendSms(model.leaddata.mobileNo ?? ""),
                                ),
                                _buildContactButton(
                                  image: 'assets/images/gmail.png',
                                  onPressed: () => model.service.sendEmail(model.leaddata.emailId ?? ""),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: Text('Notes',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
                      ],
                    ),
                    //  Center(child: const Text('----------------------------  Notes  -----------------------------',style: TextStyle(fontWeight: FontWeight.bold),)),
                    CustomSmallTextFormField(
                      controller: model.controller, hintText: 'Add your notes here',
                      labelText: 'Add Notes',
                      suffixicon: IconButton.filled(color: Colors.blue,style: const ButtonStyle(),
                        onPressed: () {model.addnote(widget.updateId,model.controller.text);
                        }, // Implement edit functionality
                        icon: const Icon(Icons.send_rounded,color: Colors.white,),
                      ), ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), itemCount: model.notes.length, itemBuilder: (context, index) {final noteData = model.notes[index];
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
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          bool dismiss = false;
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: const Text("Are you sure you want to delete the note"),
                                  title: const Text("Delete Note?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          dismiss = false;
                                          Navigator.pop(context);
                                        },
                                        child: const Text("No")),
                                    TextButton(
                                        onPressed: () {
                                          dismiss = true;
                                          model.deletenote(widget.updateId,noteData.name);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Yes")),
                                  ],
                                );
                              });
                          return dismiss;
                        }
                      },
                      //  onDismissed: (direction) {

                      //           model.deleteitem(index);
                      //           // Shows the information on Snackbar

                      //         },
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


                  ],
                ),
              ),
            ),
            loader: model.isBusy,
            context: context,
          ),
          // floatingActionButton: FloatingActionButton(onPressed: ()=> Navigator.pushNamed(context, Routes.addLeadScreen,arguments: AddLeadScreenArguments(leadid: '')),child: Icon(Icons.add),),
        ));
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
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
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }


  // Widget _buildDropdown(String label, UpdateLeadModel updateLeadModel) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 8.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           label,
  //           style: TextStyle(
  //             color: Colors.grey[600],
  //             fontSize: 14,
  //           ),
  //         ),
  //         SizedBox(height: 4),
  //         DropdownButton<String>(
  //           value: updateLeadModel.selectedEnquiryType,
  //           hint: Text('Select an option'),
  //           items: updateLeadModel.enquiryTypes.map((String option) {
  //             return DropdownMenuItem<String>(
  //               value: option,
  //               child: Text(option),
  //             );
  //           }).toList(),
  //           onChanged: (String? newValue) {
  //             setState(() {
  //               updateLeadModel.selectedEnquiryType = newValue!;
  //               if(newValue == "Not Interested"){
  //                 showAlertDialog(context, updateLeadModel);
  //               }else{
  //                 updateLeadModel.updateEnquiryType(newValue, "");
  //               }
  //             });
  //
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void showAlertDialog(BuildContext context,UpdateLeadModel updateLeadModel) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reason'),
          content: TextField(
            controller: updateLeadModel.descriptonController,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Enter your reason',
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
                updateLeadModel.updateEnquiryType("Not Interested", updateLeadModel.descriptonController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }



  Widget _buildContactButton({required String image, required Function onPressed}) {
    return InkWell(
      onTap: onPressed as void Function()?,
      borderRadius: BorderRadius.circular(30),
      child: Image.asset(
        image,
        scale: 8,
      ),
    );
  }

}