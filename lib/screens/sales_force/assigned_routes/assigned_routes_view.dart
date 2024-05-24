import 'package:flutter/material.dart';
import 'package:geolocation/screens/location_tracking/show_maps_screen.dart';
import 'package:geolocation/screens/sales_force/assigned_routes/assigned_routes_view_model.dart';
import 'package:geolocation/screens/sales_force/assigned_routes/maps_screen.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../router.router.dart';


class AssignedRoutesScreen extends StatelessWidget {

  DateTime firstDate = DateTime.now().subtract(Duration(days: 30)); // One year ago from now
  DateTime lastDate = DateTime.now().add(Duration(days: 30));
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoutesViewModel>.reactive(
        viewModelBuilder: () => RoutesViewModel(),
        onViewModelReady: (viewModel) => viewModel.initialise(context),
        builder: (context, model, child)=> Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(title: const Text('Routes'),

            leading: IconButton.outlined(onPressed: ()=> Navigator.pop(context), icon: const Icon(Icons.arrow_back)),

          ),
          body: fullScreenLoader(
            loader: model.isBusy,
            context: context,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: CalendarDatePicker(initialDate: DateTime.now(),
                          onDateChanged: (newDate){
                          selectedDate = newDate;
                          var date = formatDate(selectedDate!);
                          model.getAssignmentDetails(date);
                        }, firstDate: firstDate,lastDate: lastDate),
            //           child: TableCalendar(
            //             focusedDay: DateTime(model.selectedYear ?? DateTime.now().year, model.selectedMonth ?? DateTime.now().month, 1),
            //             firstDay: DateTime(2000),
            //             lastDay: DateTime(2100),
            //             weekendDays: const [DateTime.sunday],
            //             startingDayOfWeek: StartingDayOfWeek.sunday,
            //             onDaySelected: (date, events) {
            //             },
            //             availableCalendarFormats: {CalendarFormat.month: 'Month'},
            //             enabledDayPredicate: (DateTime date) {
            //               return false;
            //             },
            // calendarStyle: CalendarStyle(
            //               markersAnchor: 0.7,
            //               markersMaxCount: 1,
            //               weekendTextStyle: TextStyle(
            //                 color: Colors.red,
            //               ),
            //               todayDecoration: BoxDecoration(
            //                 color: Colors.blue[300],
            //                 shape: BoxShape.circle,
            //               ),
            //               selectedDecoration: BoxDecoration(
            //                 color: Colors.blue,
            //                 shape: BoxShape.circle,
            //               ),
            //             ),
            //
            //           ),
                    ),
                    const SizedBox(height: 10,),

                    model.routes.isNotEmpty
                        ? ListView.separated(

                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (builder, index) {
                              return Card(
                                color: Colors.white,
                                child: ListTile(
                                  isThreeLine: true,
                                  focusColor: Colors.white,
                                  leading:  const Icon(
                                    Icons.route,
                                    size: 34, // Adjust the size of the icon as needed
                                  ),
                                  title: Text(" ${model.routes[index].routeName}"??'Not Available', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal,color: Colors.black)),
                                  subtitle: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                      children:[Text("Assigned to"),
                                        Padding(padding:EdgeInsets.all(10.0),child: Text(model.routes[index].employeeName?? 'Not available', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal,color: Colors.blue)))
                                        ],

                                  ),

                                  onTap: () {
                                    // viewModel.setSelectedString(viewModel.routes[index].name!);
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (_) => MapsScreen(name : model.routes[index].name!)
                                    ));
                                  },
                                ),
                              );

                            },
                            separatorBuilder: (context, builder) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: model.routes.length)
                        : Center(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: const Text('Sorry, you got nothing!',style: TextStyle(fontWeight: FontWeight.w700),),),
                    )
            ],
          ),
        ))),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: ()=>Navigator.pushNamed(context, Routes.routeAssignmentForm),
             label: const Text('Assign Route'),),
    )


    );


  }
  String formatDate(DateTime dateTime){
    DateFormat formatter = DateFormat('yyyy-MM-dd'); // Change the format as needed
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }
}
///fdsfsdfdfdsfsdfsdf

