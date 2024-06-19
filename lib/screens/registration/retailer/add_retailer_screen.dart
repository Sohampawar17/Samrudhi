import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/lead_screen/add_lead_screen/add_lead_viewmodel.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:geolocation/widgets/text_button.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stacked/stacked.dart';
import '../../../widgets/customtextfield.dart';
import '../../../widgets/drop_down.dart';
import 'add_retailer_view_model.dart';

class AddRetailerScreen extends StatefulWidget {
  final String retailerId;
  const AddRetailerScreen({super.key, required this.retailerId});

  @override
  State<AddRetailerScreen> createState() => _AddRetailerScreenState();
}

class _AddRetailerScreenState extends State<AddRetailerScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddRetailerViewModel>.reactive(
        viewModelBuilder: () => AddRetailerViewModel(),
        onViewModelReady: (model) => model.initialise(context,""),
        builder: (context, model, child)=>Scaffold(

          appBar:AppBar(title:  Text('Register Retailer',style: const TextStyle(fontSize: 18),),

          ),
          body: fullScreenLoader(
            loader: model.isBusy,context: context,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      CustomSmallTextFormField(
                        prefixIcon: Icons.shop,
                        controller: model.shopNameController,
                        labelText: 'Name of the shop',
                        hintText: 'Name of the shop',
                        onChanged: model.setShopName,
                        validator: model.validateString,
                      ),
                      const SizedBox(height: 15),
                      CustomSmallTextFormField(
                        prefixIcon: Icons.person,
                        controller: model.shopOwnerNameController,
                        labelText: 'Name of the shop owner',
                        hintText: 'Name of the shop owner',
                        onChanged: model.setShopOwnerName,
                        // validator: model.validateString,
                      ),
                      const SizedBox(height: 15),
                      CustomSmallTextFormField(
                        prefixIcon: Icons.phone,
                        controller: model.mobileNoController,
                        labelText: 'Mobile No',
                        hintText: 'Enter the mobile number',
                        onChanged: model.setMobileNo,
                        validator: model.validateString,
                      ),
                      const SizedBox(height: 15),
                      CustomSmallTextFormField(
                        prefixIcon: Icons.email,
                        controller: model.emailController,
                        labelText: 'Email',
                        hintText: 'Enter the email',
                        onChanged: model.setEmail,
                       // validator: model.validateString,
                      ),
                      const SizedBox(height: 15),
                      CustomSmallTextFormField(
                        prefixIcon: Icons.phone,
                        controller: model.whatsAppNoController,
                        labelText: 'WhatsApp No',
                        hintText: 'Enter the WhatsApp number',
                        onChanged: model.setWhatsappNo,
                        //validator: model.validateString,
                      ),
                      const SizedBox(height: 15),
                      CustomSmallTextFormField(
                        prefixIcon: Icons.home,
                        controller: model.nameOfTheBuildingController,
                        labelText: 'Name of the building',
                        hintText: 'Enter the building name',
                        onChanged: model.setBuildingNameOfTheController,
                       // validator: model.validateString,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: CustomSmallTextFormField(
                              prefixIcon: Icons.location_city,
                              controller: model.areaController,
                              labelText: 'Area',
                              hintText: 'Enter the area',
                              onChanged: model.setAreaController,
                              //validator: model.validateString,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: CustomSmallTextFormField(
                              prefixIcon: Icons.route,
                              controller: model.roadController,
                              labelText: 'Road',
                              hintText: 'Enter the road',
                              onChanged: model.setRoadController,
                              //validator: model.validateString,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: CustomSmallTextFormField(
                              prefixIcon: Icons.location_on,
                              controller: model.tehsilController,
                              labelText: 'Tehsil',
                              hintText: 'Enter the tehsil',
                              onChanged: model.setTehsil,
                              //validator: model.validateString,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: CustomSmallTextFormField(
                              prefixIcon: Icons.location_on,
                              controller: model.tehsilController,
                              labelText: 'Tehsil',
                              hintText: 'Enter the tehsil',
                              onChanged: model.setTehsil,
                              validator: model.validateString,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),
                      CustomSmallTextFormField(
                        prefixIcon: Icons.location_on,
                        controller: model.landmarkController,
                        labelText: 'Landmark',
                        hintText: 'Enter the landmark',
                        onChanged: model.setLandmark,
                        validator: model.validateString,
                      ),
                      const SizedBox(height: 15),
                      CustomSmallTextFormField(
                        prefixIcon: Icons.location_on,
                        controller: model.stateController,
                        labelText: 'State',
                        hintText: 'Enter the state',
                        onChanged: model.setState,
                        validator: model.validateString,
                      ),
                      const SizedBox(height: 15),
                      CustomSmallTextFormField(
                        prefixIcon: Icons.location_on,
                        controller: model.cityController,
                        labelText: 'City/Town',
                        hintText: 'Enter the city/town',
                        onChanged: model.setCity,
                        validator: model.validateString,
                      ),
                      const SizedBox(height: 15),
                      CustomSmallTextFormField(
                        prefixIcon: Icons.location_on,
                        controller: model.districtController,
                        labelText: 'District',
                        hintText: 'Enter the district',
                        onChanged: model.setDistrict,
                        //validator: model.validateString,
                      ),
                      const SizedBox(height: 15),
                      CustomSmallTextFormField(
                        prefixIcon: Icons.location_on,
                        controller: model.pincodeController,
                        labelText: 'Pin Code',
                        hintText: 'Enter the pin code',
                        onChanged: model.setPincode,
                        validator: model.validateString,
                      ),
                      const SizedBox(height: 15),
                      CustomSmallTextFormField(
                        prefixIcon: Icons.account_balance,
                        controller: model.panController,
                        labelText: 'PAN',
                        hintText: 'Enter the PAN',
                        onChanged: model.setPan,
                       // validator: model.validateString,
                      ),
                      const SizedBox(height: 15),
                      CustomSmallTextFormField(
                        prefixIcon: Icons.business,
                        controller: model.typeOfShopController,
                        labelText: 'Type of Shop',
                        hintText: 'Enter the type of shop',
                        onChanged: model.setTypeOfShop,
                       // validator: model.validateString,
                      ),
                      const SizedBox(height: 15),
                      CustomSmallTextFormField(
                        prefixIcon: Icons.business,
                        controller: model.gstController,
                        labelText: 'GST',
                        hintText: 'Enter the GST',
                        onChanged: model.setGst,
                        //validator: model.validateString,
                      ),
                      const SizedBox(height: 15),
                      CustomSmallTextFormField(
                        prefixIcon: Icons.business,
                        controller: model.assignedDistributorController,
                        labelText: 'Assigned Distributor',
                        hintText: 'Enter the assigned distributor',
                        onChanged: model.setAssignedDistributor,
                        //validator: model.validateString,
                      ),
                      const SizedBox(height: 15),
                      CustomSmallTextFormField(
                        prefixIcon: Icons.document_scanner,
                        controller: model.aadharNoController,
                        labelText: 'Aadhar No',
                        hintText: 'Enter the Aadhar number',
                        onChanged: model.setAadharNo,
                       // validator: model.validateString,
                      ),
                      const SizedBox(height: 15),

                      const SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Expanded(child: CtextButton(onPressed: () => Navigator.of(context).pop(), text: 'Cancel', buttonColor: Colors.red.shade500,)),
                          const SizedBox(width: 20), Expanded(child: CtextButton(onPressed: ()=> {
                            model.onSavePressed(context)

                          }, text:model.isEdit?'Update Enquiry' : 'Add Retailer', buttonColor: Colors.blueAccent.shade400,))],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),  ));
  }
}