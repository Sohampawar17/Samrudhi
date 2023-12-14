import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../../constants.dart';
import '../../../router.router.dart';
import 'list_expense_viewmodel.dart';



class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExpenseViewModel>.reactive(
        viewModelBuilder: () => ExpenseViewModel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child)=> Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(title: const Text('My Expenses'),
            leading: IconButton.outlined(onPressed: ()=>Navigator.popAndPushNamed(context, Routes.homePage), icon: const Icon(Icons.arrow_back)),
            // bottom:  PreferredSize(preferredSize: Size(20, 75), child:Container(
            //   padding: EdgeInsets.all(8),
            //   color: Colors.white,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: DropdownButtonFormField<String>(
            //           value: model.selectedMonth, // The currently selected month
            //           onChanged: (String? month) {
            //             // Update the selected month when the user changes the dropdown value
            //             model.updateSelectedmonth(month);
            //           },
            //           decoration: InputDecoration(
            //             constraints: BoxConstraints(maxHeight: 60),
            //             labelText: 'Month',
            //             hintText: 'Select month',
            //             prefixIcon: Icon(Icons.calendar_month),
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(30.0),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //               borderSide: BorderSide(color: Colors.blue, width: 2.0),
            //               borderRadius: BorderRadius.circular(30.0),
            //             ),
            //             enabledBorder: OutlineInputBorder(
            //               borderSide: BorderSide(color: Colors.grey, width: 1.0),
            //               borderRadius: BorderRadius.circular(30.0),
            //             ),
            //           ),
            //           items: List.generate(12, (index) {
            //             // Generate a list of 12 months using a DateFormat
            //             DateTime monthDate = DateTime(2022, index + 1, 1);
            //             String monthName = DateFormat.MMMM().format(monthDate);
            //
            //             return DropdownMenuItem<String>(
            //               value: monthName,
            //               child: Text(monthName),
            //             );
            //           }),
            //         ),
            //       ),
            //       SizedBox(width: 10,),
            //       Expanded(
            //         child: DropdownButtonFormField<int>(
            //           value: model.selectedYear, // The currently selected year
            //           onChanged: (int? year) {
            //             // Update the selected year when the user changes the dropdown value
            //             model.updateSelectedYear(year);
            //           },
            //           decoration: InputDecoration(
            //             constraints: BoxConstraints(maxHeight: 60),
            //             labelText: 'Year',
            //             hintText: 'Select year',
            //             prefixIcon: Icon(Icons.calendar_month),
            //
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(30.0),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //               borderSide: BorderSide(color: Colors.blue, width: 2.0),
            //               borderRadius: BorderRadius.circular(30.0),
            //             ),
            //             enabledBorder: OutlineInputBorder(
            //               borderSide: BorderSide(color: Colors.grey, width: 1.0),
            //               borderRadius: BorderRadius.circular(30.0),
            //             ),
            //
            //           ),
            //           items: model.availableYears.map((int year) {
            //             return DropdownMenuItem<int>(
            //               value: year,
            //               child: Text(year.toString()),
            //             );
            //           }).toList(),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // ),
          ),
          body: fullScreenLoader(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  model.expenselist.isNotEmpty
                      ? Expanded(
                    child: ListView.separated(
                        itemBuilder: (builder, index) {
                          return Card(
                            elevation: 4, // Add elevation for a subtle shadow
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildContainer("${model.expenselist[index].expenseType.toString()} Expense"),
                                      _buildContainer(model.expenselist[index].status.toString()),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText("Sanction Amount", style: TextStyle(fontSize: 15)),
                                          AutoSizeText(model.expenselist[index].totalSanctionedAmount?.toString() ?? "0.0",style: TextStyle(fontSize: 15,color: Colors.green)),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText("Claimed Amount",style: TextStyle(fontSize: 15)),
                                          AutoSizeText(model.expenselist[index].totalClaimedAmount?.toString() ?? "0.0",style: TextStyle(fontSize: 15,color: Colors.green,fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  _buildSubtitle("posting Date :- ${model.expenselist[index].expenseDate ?? ""}"),
                                  SizedBox(height: 10),
                                  _buildSubtitle("Description :- ${model.expenselist[index].expenseDescription ?? ""}"),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, builder) {
                          return const Divider(
                            thickness: 1,
                          );
                        },
                        itemCount: model.expenselist.length),
                  )
                      : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Customize the shadow color and opacity
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // Customize the shadow offset
                        ),
                      ],
                    ),
                    height: 100,
                    child: const Center(child: Text('No attendance found for this year and month')),
                  )
                ],
              ),
            ),
            loader: model.isBusy,
            context: context,
          ),
floatingActionButton: FloatingActionButton(onPressed: ()=>Navigator.pushNamed(context, Routes.addExpenseScreen),
child: Icon(Icons.add),),
        ));
  }


  Widget _buildContainer(String text) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: AutoSizeText(text, style: TextStyle(fontSize: 15)),
    );
  }

  Widget _buildSubtitle(String text) {
    return AutoSizeText(text, style: TextStyle(fontSize: 15));
  }
}