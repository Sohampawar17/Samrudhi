import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../router.router.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/full_screen_loader.dart';
import 'assigned_routes_view_model.dart';
import 'custom_calendar_header.dart';
import 'maps_screen.dart';

class AssignedRoutesScreen extends StatelessWidget {
  final DateTime now = DateTime.now();
  DateTime firstDate = DateTime(DateTime.now().year, 1, 1).subtract(Duration(days: 30));
  DateTime lastDate = DateTime(DateTime.now().year, 12, 31).add(Duration(days: 30));

  DateTime? selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoutesViewModel>.reactive(
      viewModelBuilder: () => RoutesViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialise(context),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Routes'),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: fullScreenLoader(
          loader: model.isBusy,
          context: context,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(

                children: [
                  const SizedBox(height: 10),
                  CustomDropdownButton2(value:model.selectedEmployee,items: model.getEmployeeNames(), hintText:"Select Employee",
                      onChanged:(newValue) {
                           model.updateSelectedEmployee(newValue!);
                  }, labelText:"Employees" ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: TableCalendar(

                      calendarBuilders: CalendarBuilders(
                        headerTitleBuilder: (context, date) {
                          return Row(
                            children: [
                              Expanded(
                                child: CustomCalendarHeader(

                                  selectedYear: model.selectedYear,
                                  selectedMonth: model.selectedMonth,
                                  onYearChanged: (year) {
                                    print(model.focusedDay);
                                    if (model.focusedDay?.year != now.year) {
                                      // Update firstDate and lastDate when year changes
                                      firstDate = DateTime(model.selectedYear!, 1, 1).subtract(Duration(days: 30));
                                      lastDate = DateTime(model.selectedYear!, 12, 31).add(Duration(days: 30));
                                      // Check if focusedDay is after lastDate, then set it to lastDate

                                    }
                                    model.updateSelectedYear(year);
                                    model.setFocusedDay(DateTime(year!, model.selectedMonth!));
                                    model.getAssignedDetailsForTheMonth(
                                      model.selectedYear!,
                                      model.selectedMonth!,
                                    );
                                  },
                                  onMonthChanged: (month) {
                                    model.updateSelectedMonth(month);
                                    model.setFocusedDay(DateTime(model.selectedYear!, month!));
                                    model.getAssignedDetailsForTheMonth(
                                      model.selectedYear!,
                                      model.selectedMonth!,
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                        defaultBuilder: (context, date, _) {
                          final isAssigned = model.filteredList.any((routeData) {
                            DateTime routeDate =
                            DateFormat('yyyy-MM-dd').parse(routeData.datetime!);
                            return isSameDay(date, routeDate);
                          });

                          Color textColor =
                          isAssigned ? Colors.green : Colors.orange;
                          bool isSunday = date.weekday == DateTime.sunday;
                          return Center(
                            child: Text(
                              '${date.day}',
                              style: TextStyle(color: isSunday ? Colors.red : textColor),
                            ),
                          );
                        },
                      ),
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month',
                        CalendarFormat.week: 'Week',
                      },
                      firstDay: DateTime(model.selectedYear!, model.selectedMonth!, 1),
                      lastDay: DateTime(model.selectedYear!, model.selectedMonth! + 1, 0),
                      focusedDay:model.focusedDay ?? DateTime.now(),

                      calendarFormat: model.calendarFormat,
                      onFormatChanged: (format) {
                        model.calenderformat(format);
                        _handleCalendarFormatChange(format, model);
                      },
                      selectedDayPredicate: (day) {
                        return model.focusedDay != null ? isSameDay(model.focusedDay!, day) : false;
                      },
                      onPageChanged: (focusedDay) {
                        model.setFocusedDay(focusedDay);
                        final newMonth = focusedDay.month;
                        final newYear = focusedDay.year;
                        model.updateSelectedMonth(newMonth);
                        model.updateSelectedYear(newYear);
                       // model.getAssignedDetailsForTheMonth(newYear, newMonth);
                        _handleCalendarFormatChange(model.calendarFormat, model);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        model.setFocusedDay(focusedDay);
                        model.getAssignmentDetails(formatDate(focusedDay));
                      },
                      headerStyle: const HeaderStyle(
                        titleCentered: true,
                        titleTextStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  model.filteredList.isNotEmpty
                      ? ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (builder, index) {
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          isThreeLine: true,
                          focusColor: Colors.white,
                          leading: const Icon(
                            Icons.route,
                            size: 34,
                          ),
                          title: Text(
                            model.filteredList[index].routeName ?? 'Not Available',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Assigned to"),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  model.filteredList[index].employeeName ?? 'Not available',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                          trailing: Text(
                            model.filteredList[index].datetime ?? 'Not Available',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      MapsScreen(name: model.filteredList[index].name!)),
                            );
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, builder) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: model.filteredList.length,
                  )
                      : Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: const Text(
                        'Sorry, you got nothing!',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.pushNamed(context, Routes.routeAssignmentForm),
          label: const Text('Assign Route'),
        ),
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  void _handleCalendarFormatChange(CalendarFormat format, RoutesViewModel model) {
    if (format == CalendarFormat.month) {
      model.getAssignedDetailsForTheMonth(model.selectedYear!, model.selectedMonth!);
    } else if (format == CalendarFormat.week) {
      final firstDayOfWeek = model.focusedDay?.subtract(Duration(days: model.focusedDay!.weekday - 1));
      model.getAssignedDetailsForTheWeek(firstDayOfWeek!);
    }
  }
}
