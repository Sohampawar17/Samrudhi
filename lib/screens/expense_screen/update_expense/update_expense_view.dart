import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/expense_screen/update_expense/update_expense_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../router.router.dart';
import '../../../widgets/full_screen_loader.dart';

class UpdateExpense extends StatefulWidget {
  final String updateId;
  const UpdateExpense({super.key, required this.updateId});

  @override
  State<UpdateExpense> createState() => _UpdateExpenseState();
}

class _UpdateExpenseState extends State<UpdateExpense> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateExpenseViewModel>.reactive(
        viewModelBuilder: () => UpdateExpenseViewModel(),
        onViewModelReady: (model) =>
            model.initialise(context, widget.updateId),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title:  Text(model.expensedata.name.toString()),
              actions: [
                model.expensedata.allowEdit==true
                    ? IconButton(
                    onPressed: () => Navigator.pushNamed(
                        context, Routes.addExpenseScreen,
                        arguments: AddExpenseScreenArguments(
                            expenseId: widget.updateId)),
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
                                model.expensedata.name ?? "",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                model.expensedata.expenseType ?? "",
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

                            color: model.getColorForStatus(model.expensedata.workflowState.toString()).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Text(
                          model.expensedata.workflowState ?? "",
                            style: TextStyle(

                              color: model.getColorForStatus(model.expensedata.workflowState.toString()),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.arrow_drop_down, color: model.getColorForStatus(model.expensedata.workflowState.toString())),
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
                        )],
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
                                labelText: 'Expense Date',
                                additionalText:
                                model.expensedata.expenseDate ?? "")),
                        Expanded(
                            child: buildItemColumn(
                                labelText: 'Amount',
                                additionalText:
                                model.expensedata.amount?.toString() ?? "N/A")),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    buildItemColumn(
                        labelText: 'Company',
                        additionalText: model.expensedata.company ?? ""),
                    const Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    buildItemColumn(
                        labelText: 'Expense Approver',
                        additionalText:
                        model.expensedata.expenseApprover ?? ""),

                    const Divider(),

                    buildItemColumn(
                        labelText: 'Description',
                        additionalText:
                        model.expensedata.expenseDescription ?? "N/A"),
                    const SizedBox(
                      height: 15,
                    ),
                    buildItemColumn(
                        labelText: 'Payable Account',
                        additionalText:
                        model.expensedata.payableAccount ?? "N/A"),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(child: buildItemColumn(
                            labelText: 'Total Sanction Amount',
                            additionalText:
                            model.expensedata.totalSanctionedAmount?.toString() ?? "N/A"),
                        ),
                        SizedBox(width: 15,),
                        Expanded(child: buildItemColumn(
                            labelText: 'Total Claimed Amount',
                            additionalText:
                            model.expensedata.totalClaimedAmount?.toString() ?? "N/A"),
                        )
                      ],
                    )
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
