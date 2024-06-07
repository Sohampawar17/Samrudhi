import 'package:flutter/material.dart';
import 'package:geolocation/screens/visit_screens/update_visit/update_visit_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../../router.router.dart';
import '../../../widgets/full_screen_loader.dart';


class UpdateVisitScreen extends StatefulWidget {
  final String updateId;
  const UpdateVisitScreen({super.key, required this.updateId});

  @override
  State<UpdateVisitScreen> createState() => _UpdateVisitScreenState();
}

class _UpdateVisitScreenState extends State<UpdateVisitScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateVisitViewModel>.reactive(
        viewModelBuilder: () => UpdateVisitViewModel(),
        onViewModelReady: (viewModel) => viewModel.initialise(context,widget.updateId),
        builder: (context, model, child)=> Scaffold(
          appBar: AppBar(title:  Text(model.visitModel.name ?? "",style: const TextStyle(fontSize: 18),),
            actions: [IconButton(onPressed: ()=>Navigator.pushNamed(context, Routes.updateLeadScreen,arguments: AddLeadScreenArguments(leadid: widget.updateId)), icon:const Icon(Icons.edit) ),],
            leading: IconButton.outlined(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back)),),
          body: fullScreenLoader(
            child:  Padding(
              padding: EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(model.visitModel.visitor == "Customer")
                    _buildInfoItem("Client Name", model.visitModel.customerName != null? model.visitModel.customerName!:"--"),
                     if(model.visitModel.visitor == "Enquiry")
                    _buildInfoItem("Enquiry Name", model.visitModel.enquiryName != null? model.visitModel.enquiryName!:"--"),
                    const SizedBox(height: 20),
                    _buildInfoItem("Visit Type", model.visitModel.visitType != null? model.visitModel.visitType!:"--"),
                    const SizedBox(height: 20),
                    _buildInfoItem("Date", model.visitModel.date != null? model.visitModel.date!:"--"),
                    const SizedBox(height: 20),
                    _buildInfoItem("Start Location", model.visitModel.startLocation != null? model.visitModel.startLocation!:"--"),
                    const SizedBox(height: 20),
                    _buildInfoItem("End Location", model.visitModel.endLocation != null? model.visitModel.endLocation!:"--"),
                    const SizedBox(height: 20),
                    _buildInfoItem("Start Time", model.visitModel.startTime != null? model.visitModel.startTime!:"--"),
                    const SizedBox(height: 20),
                    _buildInfoItem("End Time", model.visitModel.endTime != null? model.visitModel.endTime!:"--"),
                    const SizedBox(height: 20),
                    _buildInfoItem("Duration ", model.visitModel.time != null? model.visitModel.time!:"--"),
                    const SizedBox(height: 20),

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

  Widget _buildInfoItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

