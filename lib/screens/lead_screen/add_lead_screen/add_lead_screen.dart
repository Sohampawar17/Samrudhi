import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/lead_screen/add_lead_screen/add_lead_viewmodel.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:geolocation/widgets/text_button.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/customtextfield.dart';
import '../../../widgets/drop_down.dart';

class AddLeadScreen extends StatefulWidget {
  final String leadid;
  const AddLeadScreen({super.key, required this.leadid});

  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddLeadViewModel>.reactive(
      viewModelBuilder: () => AddLeadViewModel(),
      onViewModelReady: (model) => model.initialise(context,widget.leadid),
      builder: (context, model, child)=>Scaffold(
       
      appBar:AppBar(title:  Text(model.isEdit ?model.leaddata.name.toString() :'Create Enquiry',style: const TextStyle(fontSize: 18),),
leading: IconButton.outlined(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back)),actions: [
  IconButton.outlined(onPressed: ()=>model.onSavePressed(context), icon: const Icon(Icons.check))
],),
    body: fullScreenLoader(
      loader: model.isBusy,context: context,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: model.formKey,
            child: Column(
              children: [
                CdropDown(dropdownButton: DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: model.leaddata.customCustomRequestType,
                  decoration: const InputDecoration(
                    labelText: 'Request Type*',
                  ),
                  hint:
                  const Text('Select Is type'),
                  items: model.requestType.map((val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: AutoSizeText(val),
                    );
                  }).toList(),
                  onChanged: (value) {model.setRequestType(value);},
                  validator: model.validateRequestType,
                ),),
if(model.visible==true)
                  CustomDropdownButton2(labelText: 'Customer',value: model.leaddata.customComplaintCustomer,prefixIcon:Icons.person,searchInnerWidgetHeight: 35,items:model.customerList, hintText: 'select Customer', onChanged: model.setCustomer,),
                if(model.visible==true)
                CdropDown(dropdownButton: DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: model.leaddata.customComplaintStatus,
                  decoration: const InputDecoration(
                    labelText: 'Complaint Status',
                  ),
                  hint:const Text('Select Is Complaint Status'),
                  items: model.complaintStatus.map((val){
                    return DropdownMenuItem<String>(
                      value: val,
                      child: AutoSizeText(val),
                    );
                  }).toList(),
                  onChanged: (value) {model.setCustomerStatus(value);},
                ),),
                if(model.visible==true)
                CdropDown(dropdownButton: DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: model.leaddata.customComplaintType,
                  decoration: const InputDecoration(
                    labelText: 'Complaint Type',
                  ),
                  hint:const Text('Select Is complaint type'),
                  items: model.complaintTypeList.map((val){
                    return DropdownMenuItem<String>(
                      value: val,
                      child: AutoSizeText(val),
                    );
                  }).toList(),
                  onChanged: (value) {model.setComplaintType(value);},

                ),),
                if(model.visible==true)
                CdropDown(dropdownButton: DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: model.leaddata.customSubComplaintType,
                  decoration: const InputDecoration(
                    labelText: 'Sub Complaint Type',
                  ),
                  hint:
                  const Text('Select Is Sub Complaint Type'),
                  items: model.subComplaintTypeList.map((val) {
                    return DropdownMenuItem<String>(
                      value: val.name,
                      child: AutoSizeText(val.name ?? ""),
                    );
                  }).toList(),
                  onChanged: (value) {
                    final routeData = model.subComplaintTypeList
                      .firstWhere((route) =>
                  route.name == value);
                  model.setSubComplaintType(routeData);},
                ),),
                if(model.visible==true)
                CustomSmallTextFormField(readOnly: true
                    ,prefixIcon:Icons.warehouse,controller: model.departmentController,labelText:'Department' ,hintText: 'Enter your Department',onChanged: model.setDepartment),
                if(model.visible==true)
                const SizedBox(height: 15,),
                if(model.visible==false)
                Row(children: [
 Expanded(child: CustomSmallTextFormField(prefixIcon: Icons.person,controller: model.firstnamecontroller,labelText:'First Name' ,hintText: 'Enter the first name',onChanged: model.setfirstname,validator: model.validatefirstname,)),
 const SizedBox(width: 15,),
   Expanded(child: CustomSmallTextFormField(prefixIcon: Icons.person,controller: model.lastnamecontroller,labelText:'Last Name' ,hintText: 'Enter the last name',onChanged: model.setlastname)),
                
                ],),
                if(model.visible==false)
                           const SizedBox(height: 15,),
                if(model.visible==false)
                            CustomSmallTextFormField(prefixIcon:EvaIcons.email_outline,controller: model.emailcontroller,labelText:'Email Address' ,hintText: 'Enter your email id',onChanged: model.setemail),
                if(model.visible==false)
            const SizedBox(height: 15,),
                if(model.visible==false)
                        Row(children: [
 Expanded(child:  CustomSmallTextFormField(prefixIcon: Icons.phone,controller:model.mobilenumbercontroller,labelText:'Mobile Number' ,hintText: 'Enter the your mobile number',onChanged: model.setmobilenumber,length: 10,keyboardtype: TextInputType.phone),
              ),
 const SizedBox(width: 15,),
   Expanded(child:  CustomSmallTextFormField(prefixIcon:Bootstrap.whatsapp,controller: model.whatsappcontroller,labelText:'WhatsApp Number' ,hintText: 'Enter your whatsapp number',onChanged: model.setwhatsapp,length: 10,keyboardtype: TextInputType.phone,),
   )
                ],),

                if(model.visible==false)
                          const SizedBox(height: 15,),
                if(model.visible==false)
                  CustomDropdownButton2(labelText: 'Territory',value: model.leaddata.territory,prefixIcon:Icons.location_on,searchInnerWidgetHeight: 35,items:model.territory, hintText: 'select territory', onChanged: model.setterritory,),
                if(model.visible==false)
                            const SizedBox(height: 15,),
                if(model.visible==false)
                             CustomSmallTextFormField(prefixIcon: Icons.factory_outlined,controller: model.companynamecontroller,labelText:'Organisation Name' ,hintText: 'Enter the organisation',onChanged: model.setCompanyName,),
                if(model.visible==false)
                           const SizedBox(height: 15,),
                if(model.visible==false)
                            CustomDropdownButton2(prefixIcon: Icons.factory_sharp,labelText: 'Industry Type',value:model.leaddata.industry,items:model.industrytype, hintText: 'select industry', onChanged: model.setindustry,searchController: model.textEditingController,),
                if(model.visible==false)
          const SizedBox(height: 15,),
                if(model.visible==false)
            Row(children: [
 Expanded(child: CustomSmallTextFormField(prefixIcon:Icons.location_on,controller: model.citycontroller,labelText:'City' ,hintText: 'Enter the City',onChanged: model.setcity,),
                
              ),
 const SizedBox(width: 15,),
   Expanded(child:   CustomDropdownButton2(labelText: 'State',value:model.leaddata.state..toString,items:model.state, hintText: 'select state', onChanged: model.setstate,searchController: model.statecontroller,),
   )
                ],),

                          const SizedBox(height: 25,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [Expanded(child: CtextButton(onPressed: () => Navigator.of(context).pop(), text: 'Cancel', buttonColor: Colors.red.shade500,)),
                           SizedBox(width: 20), Expanded(child: CtextButton(onPressed: ()=> model.onSavePressed(context), text:model.isEdit?'Update Enquiry' : 'Create Enquiry', buttonColor: Colors.blueAccent.shade400,))],
                          )
              ],
            ),
          ),
        ),
      ),
    ),  ));
  }
}