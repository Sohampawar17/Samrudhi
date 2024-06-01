import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/leave_screen/update_leave/update_leave_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../router.router.dart';
import '../../../widgets/full_screen_loader.dart';

class UpdateLeave extends StatefulWidget {
  final String UpdateId;
  const UpdateLeave({super.key, required this.UpdateId});

  @override
  State<UpdateLeave> createState() => _UpdateLeaveState();
}

class _UpdateLeaveState extends State<UpdateLeave> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateLeaveViewModel>.reactive(
        viewModelBuilder: () => UpdateLeaveViewModel(),
        onViewModelReady: (model) =>
            model.initialise(context, widget.UpdateId),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title:  Text(model.leavedata.name.toString()),
              actions: [
                model.leavedata.docstatus == 0
                    ? IconButton(
                    onPressed: () => Navigator.pushNamed(
                        context, Routes.addLeaveScreen,
                        arguments: AddLeaveScreenArguments(
                            leaveId: widget.UpdateId)),
                    icon: const Icon(Icons.edit))
                    : Container()
              ],
            ),
            body: fullScreenLoader(
              loader: model.isBusy,
              context: context,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.leavedata.name ?? "",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                model.leavedata.leaveType ?? "",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                          decoration: BoxDecoration(

                            color: model.getColorForStatus(model.leavedata.workflowState.toString()).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  model.leavedata.workflowState ?? "",
                                  style: TextStyle(

                                    color: model.getColorForStatus(model.leavedata.workflowState.toString()),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  icon: Icon(Icons.arrow_drop_down, color: model.getColorForStatus(model.leavedata.workflowState.toString())),
                                  itemBuilder: (BuildContext context) {
                                    return model.status.map<PopupMenuItem<String>>((String item) {
                                      return PopupMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList();
                                  },
                                  onSelected: (String value) {
                                    model.changeState(context, value);
                                  },
                                ),]
                          ),
                        )
                      ],
                    )
                    ,
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: buildItemColumn(
                                labelText: 'From Date',
                                additionalText:
                                model.leavedata.fromDate ?? "")),
                        Expanded(
                            child: buildItemColumn(
                                labelText: 'To Date',
                                additionalText:
                                model.leavedata.toDate ?? "")),
                        Expanded(
                            child: buildItemColumn(
                                labelText: 'Total Leaves',
                                additionalText:
                                model.leavedata.totalLeaveDays.toString() ?? ""))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    buildItemColumn(
                        labelText: 'Company',
                        additionalText: model.leavedata.company ?? ""),
                    const Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    buildItemColumn(
                        labelText: 'Leave Approver',
                        additionalText:
                        model.leavedata.leaveApproverName ?? ""),

                    const Divider(),

                    buildItemColumn(
                        labelText: 'Description',
                        additionalText:
                        model.leavedata.description ?? "N/A"),

                  ],
                ),
              ),
            ),
          );
        });
  }


  Widget buildItemColumn(
      {required String additionalText, required String labelText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          labelText,
          style: TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
        AutoSizeText(
          additionalText,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }



}
