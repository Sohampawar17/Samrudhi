import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../../widgets/full_screen_loader.dart';
import 'list_expense_viewmodel.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExpenseViewModel>.reactive(
      viewModelBuilder: () => ExpenseViewModel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text('My Expenses'),
          bottom: PreferredSize(
            preferredSize: const Size(20, 75),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: model.selectedMonth,
                      onChanged: (int? month) {
                        model.updateSelectedmonth(month!);
                      },
                      decoration: InputDecoration(
                        constraints: const BoxConstraints(maxHeight: 60),
                        labelText: 'Month',
                        hintText: 'Select month',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: List.generate(12, (index) {
                        return DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text(model.getMonthName(index + 1)),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: model.selectedYear,
                      onChanged: (int? year) {
                        model.updateSelectedYear(year);
                      },
                      decoration: InputDecoration(
                        constraints: const BoxConstraints(maxHeight: 60),
                        labelText: 'Year',
                        hintText: 'Select year',
                        prefixIcon: const Icon(Icons.calendar_month),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: model.availableYears.map((int year) {
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => model.refresh(context),
          child: fullScreenLoader(
            child: Container(
              margin: EdgeInsets.only(top: 10),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  model.expenselist.isNotEmpty
                      ? Expanded(
                    child: ListView.separated(
                      itemBuilder: (builder, index) {
                        final expense = model.expenselist[index];
                        return MaterialButton(
                          onPressed: ()=>model.onRowClick(context,expense),
                          child: Container(
              
                            padding: EdgeInsets.all(16.0),
              
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              border: Border(left: BorderSide(color:model.getColorForStatus(expense.approvalStatus), width: 10)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildRow('Expense Date',  Text(
                                  expense.expenseDate ?? "N/A",
              
                                ),),
                                SizedBox(height: 10.0),
                                buildRow('Expense Type',  Text(
                                  expense.expenseType ?? "N/A",
              
                                ),),
                                SizedBox(height: 10.0),
                                buildRow('Expense Amount',  Text(
                                  "${expense.totalClaimedAmount?.toInt().toString()}/-",
              
                                ),),
                                SizedBox(height: 10.0),
                                buildRow(
                                  'Status',
                                  Container(
                                    decoration: BoxDecoration(
                                      color: model.getColorForStatus(expense.approvalStatus).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                    child: Text(
                                        expense.approvalStatus ?? "",
                                      style: TextStyle(color:model.getColorForStatus(expense.approvalStatus), fontSize: 15, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, builder) {
                        return const Divider(thickness: 1);
                      },
                      itemCount: model.expenselist.length,
                    ),
                  )
                      : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    height: 100,
                    child: const Center(
                      child: Text('No expenses found for this year and month'),
                    ),
                  )
                ],
              ),
            ),
            loader: model.isBusy,
            context: context,
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.pushNamed(
            context,
            Routes.addExpenseScreen,
            arguments: const AddExpenseScreenArguments(expenseId: ""),
          ),
          label: const Text('Create Expense'),
        ),
      ),
    );
  }


  Widget buildRow(String label, Widget value) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ),
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.centerLeft,
            child: value,
          ),
        ),
      ],
    );
  }
}
