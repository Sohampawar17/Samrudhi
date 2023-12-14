import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import '../../../constants.dart';
import '../../../router.router.dart';
import 'list_leave_viewmodel.dart';



class ListLeaveScreen extends StatelessWidget {
  const ListLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LeaveViewModel>.reactive(
        viewModelBuilder: () => LeaveViewModel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child)=> Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(title: const Text('My Leaves'),
            leading: IconButton.outlined(onPressed: ()=>Navigator.popAndPushNamed(context, Routes.homePage), icon: const Icon(Icons.arrow_back)),
            bottom:  PreferredSize(preferredSize: Size(20, 75), child:Container(
              padding: EdgeInsets.all(8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: model.selectedMonth, // The currently selected month
                      onChanged: (int? month) {
                        // Update the selected month when the user changes the dropdown value
                        model.updateSelectedmonth(month);
                      },
                      decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 60),
                        labelText: 'Month',
                        hintText: 'Select month',
                        prefixIcon: Icon(Icons.calendar_month),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      items: List.generate(12, (index) {
                        // Generate a list of 12 months (1-based index)
                        return DropdownMenuItem<int>(
                          value: index + 1, // Months are 1-based
                          child: Text(model.getMonthName(index + 1)), // Replace with your method to get month name
                        );
                      }),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: model.selectedYear, // The currently selected year
                      onChanged: (int? year) {
                        // Update the selected year when the user changes the dropdown value
                        model.updateSelectedYear(year);
                      },
                      decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 60),
                        labelText: 'Year',
                        hintText: 'Select year',
                        prefixIcon: Icon(Icons.calendar_month),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(30.0),
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
          body: fullScreenLoader(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Upcoming Leaves (${model.leavelist.length})", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  model.leavelist.isNotEmpty
                      ? Expanded(
                    child: ListView.separated(
                      itemBuilder: (builder, index) {
                        return _buildLeaveItem(
                          model.leavelist[index].leaveType.toString().toUpperCase(),
                          model.leavelist[index].status.toString(),
                          "${model.leavelist[index].fromDate ?? ""} to ${model.leavelist[index].toDate ?? ""}",
                          model.leavelist[index].description ?? "",
                        );
                      },
                      separatorBuilder: (context, builder) {
                        return const Divider(
                          height: 20,
                          thickness: 1,
                        );
                      },
                      itemCount: model.leavelist.length,
                    ),
                  )
                      : _buildEmptyContainer('No upcoming leave found for this year and month'),

                  SizedBox(height: 20),

                  Text("Taken Leaves(${model.takenlist.length})", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  model.takenlist.isNotEmpty
                      ? Expanded(
                    child: ListView.separated(
                      itemBuilder: (builder, index) {
                        return _buildLeaveItem(
                          model.takenlist[index].leaveType.toString().toUpperCase(),
                          model.takenlist[index].status.toString(),
                          "${model.takenlist[index].fromDate ?? ""} to ${model.takenlist[index].toDate ?? ""}",
                          model.takenlist[index].description ?? "",
                        );
                      },
                      separatorBuilder: (context, builder) {
                        return const Divider(
                          height: 20,
                          thickness: 1,
                        );
                      },
                      itemCount: model.takenlist.length,
                    ),
                  )
                      : _buildEmptyContainer('No taken leave found for this year and month'),
                ],
              ),
            ),


    loader: model.isBusy,
            context: context,
          ),
floatingActionButton: FloatingActionButton(onPressed: ()=>Navigator.pushNamed(context, Routes.addLeaveScreen),
child: Icon(Icons.add),),
        ));
  }


  Widget _buildLeaveItem(String leaveType, String status, String dateRange, String description) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // Change the color to your preference
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLabelContainer(leaveType),
              _buildLabelContainer(status),
            ],
          ),
          SizedBox(height: 10),
          Text(dateRange, style: TextStyle(fontSize: 15)),
          SizedBox(height: 10),
          Text(description, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildLabelContainer(String text) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: AutoSizeText(text, style: TextStyle(fontSize: 12)),
    );
  }

  Widget _buildEmptyContainer(String message) {
    return Container(
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
      child: Center(child: Text(message)),
    );
  }
}