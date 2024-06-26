import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/lead_screen/update_screen/update_viewmodel.dart';
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
          backgroundColor: Colors.white,
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
                      elevation: 3.5,
                      color: Colors.white,
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(

                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildItemColumn(  additionalText: model.leaddata.customCustomRequestType ?? "", labelText: 'Requested Type'),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                                  decoration: BoxDecoration(

                                    color: model.getColorForStatus(model.leaddata.customEnquiryStatus.toString()).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          model.leaddata.customEnquiryStatus ?? "N/A",
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
                                ),
                              ],
                            ),
                            if(model.leaddata.customEnquiryStatus =="Not Interested")
                            const SizedBox(height: 10,),
                            if(model.leaddata.customEnquiryStatus =="Not Interested")
                              buildItemColumn(labelText: 'Reason for Not Interested',additionalText:  model.leaddata.customReason ?? "N/A"),
                            const SizedBox(height: 10,),
                            buildItemColumn(labelText:'Lead Owner',additionalText: model.leaddata.leadOwner ?? "N/A"),],
                        ),
                      ) ,
                    ),

                    Card(
                      elevation: 3.5,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(alignment:Alignment.topLeft,
                                child: buildItemColumn(labelText:'Name',additionalText: model.leaddata.leadName ?? "N/A")),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(child: buildItemColumn(labelText:'Email',additionalText: model.leaddata.emailId ?? "N/A"),),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child:buildItemColumn(labelText:'Mobile',additionalText: model.leaddata.mobileNo ?? "N/A"),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(child: buildItemColumn(labelText:'Territory',additionalText: model.leaddata.territory ?? "N/A")),
                                const SizedBox(width: 10,),
                                // Expanded(
                                //   child:buildItemColumn(labelText:'Date',additionalText: model.leaddata ?? "N/A"),
                                // ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),

                    Card(
                      elevation: 3.5,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Align(alignment:Alignment.topLeft,child: buildItemColumn(labelText:'Company Name',additionalText: model.leaddata.companyName ?? "N/A")),
                            const SizedBox(height: 10,),
                            Align(alignment:Alignment.topLeft,child: buildItemColumn(labelText:'Industry type',additionalText: model.leaddata.industry ?? "N/A")),

                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 3.5,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    model.whatsapp(model.leaddata.mobileNo ??"");
                                  },
                                  child: CircleAvatar(
                                    child: Image.asset(
                                      'assets/images/whatsapp.png',scale: 5,),
                                  )),
                            ),

                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    model.service.call(model.leaddata.mobileNo ??"");
                                  },
                                  child: CircleAvatar(
                                    child: Image.asset(
                                      'assets/images/telephone.png',scale: 5,),
                                  )),
                            ),

                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    model.service.sendSms(model.leaddata.mobileNo ?? "");
                                  },
                                  child: CircleAvatar(
                                    child: Image.asset(
                                      'assets/images/comments.png',scale: 5,),
                                  )),
                            ),
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    model.service.sendEmail(model.leaddata.emailId ??"");
                                  },
                                  child: CircleAvatar(
                                    child: Image.asset(
                                      'assets/images/gmail.png',scale: 5,),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 1, // Height of the divider
                            color: Colors.blueAccent, // Color of the divider
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Activity',
                          style: TextStyle(color: Colors.blueAccent,
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 1, // Height of the divider
                            color: Colors.blueAccent, // Color of the divider
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: model.controller,
                      decoration: InputDecoration(
                        hintText: 'Add the note Here.....',
                        hintStyle: const TextStyle(fontSize: 15),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Colors.blue, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Colors.grey, width: 2),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Colors.black45, width: 2),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: TextButton(
                            onPressed: () {
                              if (model.controller.text.isNotEmpty) {
                                model.addnote(widget.updateId,model.controller.text);
                              }
                            },
                            child: const Text(
                              'Send',
                              style: TextStyle(fontSize: 14.0, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    model.notes.isNotEmpty
                        ? ListView.separated(
                      separatorBuilder: (context, builder) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), itemCount: model.notes.length, itemBuilder: (context, index) {final noteData = model.notes[index];
                    return Dismissible(
                      background: Container(
                        color: Colors.red.shade400,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                         'Remove',
                          style: TextStyle( color: Colors.white,fontSize: 20),
                          // color: Colors.white,size: 40,
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
                      child:Card(
                        elevation: 2,
                        color: Colors.white,
                        child: ListTile(
                          leading: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: noteData.image ??"",
                              width: 40,
                              matchTextDirection: true,
                              height: 40,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
                              errorWidget: (context, url, error) => Center(child: Image.asset('assets/images/profile.png', scale: 5)),
                            ),
                          ),
                          title: Text(
                            noteData.note ?? "",

                          ),
                          subtitle: Text("${noteData.commented ?? ""} | ${noteData.addedOn ?? ""}",style: const TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      ),
                    );
                    },
                    ) : Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Text(
                          'There is no any notes!',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
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

  Widget buildItemColumn( {required String additionalText, required String labelText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(labelText,style: const TextStyle(fontWeight: FontWeight.w400),minFontSize: 15,),
        AutoSizeText(additionalText,style: const TextStyle(fontWeight: FontWeight.bold),maxFontSize: 20,),
      ],
    );
  }

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





}