import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../router.router.dart';
import 'attendence_viewmodel.dart';


class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AttendenceViewModel>.reactive(
        viewModelBuilder: () => AttendenceViewModel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child)=> Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(title: const Text('Attendance'),

            leading: IconButton.outlined(onPressed: ()=>Navigator.popAndPushNamed(context, Routes.homePage), icon: const Icon(Icons.arrow_back)),

            bottom:  PreferredSize(preferredSize: Size(20, 105), child:Container(
              padding: EdgeInsets.all(16),
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

                        constraints: const BoxConstraints(maxHeight: 60),
                        labelText: 'Month',
                        hintText: 'Select month',
                        prefixIcon: const Icon(Icons.calendar_month),
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
                  SizedBox(width: 10,),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
height: 200,
                    color: Colors.white,
                    child: SfCalendar(
                      view: CalendarView.month,
                      monthViewSettings: const MonthViewSettings(
                        showAgenda: false,

                      ),

                    ),
                  ),
                  SizedBox(height: 20,),
                  model.attendancelist.isNotEmpty
                      ? Expanded(
                    child: ListView.separated(
                        itemBuilder: (builder, index) {
                          return Container(padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                            height: 90,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText('${model.attendancelist[index].attendanceDate}',style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(height: 10,)
                                  ,Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          AutoSizeText('CheckIn Time',style: TextStyle(fontWeight: FontWeight.w300
                                          ),),
                                          AutoSizeText('${model.attendancelist[index].inTime ?? "- -"}',style: TextStyle(fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                      const Divider(thickness: 1,color: Colors.black,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          AutoSizeText('CheckOut Time',style: TextStyle(fontWeight: FontWeight.w300),),
                                          AutoSizeText('${model.attendancelist[index].outTime ?? "- -"}',style: TextStyle(fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                      const Divider(thickness: 1,),Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          AutoSizeText('Working Hours',style: TextStyle(fontWeight: FontWeight.w300),),
                                          AutoSizeText('${model.attendancelist[index].workingHours}',style: TextStyle(fontWeight: FontWeight.bold),)
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                          );
                        },
                        separatorBuilder: (context, builder) {
                          return Divider(
                            thickness: 1,
                          );
                        },
                        itemCount: model.attendancelist.length),
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

        ));
  }
}