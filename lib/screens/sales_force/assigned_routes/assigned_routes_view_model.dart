import 'package:flutter/cupertino.dart';
import 'package:geolocation/model/calendar_services.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../model/employee_list.dart';
import '../../../model/get_teritorry_details.dart';
import '../../../services/route_services.dart';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../model/get_teritorry_details.dart';
import '../../../services/route_services.dart';

class RoutesViewModel extends BaseViewModel {
  late final List<int> _availableYears = [2022, 2023, 2024, 2025, 2026, 2027];
  late int? _selectedYear;
  late int? _selectedMonth;
  late int? _selectedDay;
  late int? _selectedWeek;
  DateTime? focusedDay;
  List<EmployeeAssignerDetails> employees = [];
  String? selectedEmployee;

  List<int> get availableYears => _availableYears;

  int? get selectedYear => _selectedYear;

  int? get selectedMonth => _selectedMonth;

  int? get selectedDay => _selectedDay;

  int? get selectedWeek => _selectedWeek;

  List<RouteAssignmentData> routes = [];
  List<RouteAssignmentData> filteredList = [];
  CalendarFormat calendarFormat = CalendarFormat.month;

  /// Initializes the view model.
  Future<void> initialise(BuildContext context) async {
    setBusy(true);
    focusedDay = DateTime.now();
    _selectedMonth = focusedDay?.month;
    _selectedYear = focusedDay?.year;
    employees = await RouteServices().getEmployeeList();

    await getAssignedDetailsForTheMonth(_selectedYear!, _selectedMonth!);
   // await getAssignmentDetails(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    setBusy(false);
  }
  void setFocusedDay(DateTime date) {
    focusedDay = date;
    notifyListeners();
  }


  List<String> getEmployeeNames(){
    if (employees.isEmpty) {
      return [];
    }
    return employees
        .where((item) => item.employeeName != null && item.employeeName!.isNotEmpty)
        .map((item) => item.employeeName.toString())
        .toList();
  }


  /// Sets the calendar format.
  void calenderformat(CalendarFormat format) {
    calendarFormat = format;
    notifyListeners();
  }

  /// Retrieves route assignment details for the specified date.
  Future<void> getAssignmentDetails(String date) async {
    filteredList = await RouteServices().getRouteAssignmentDetails(date);
    notifyListeners();
  }

  /// Update the selected employee.
  Future<void> updateSelectedEmployee(String employee) async {
    selectedEmployee = employee;
    filteredList = routes.where((item) => item.employeeName != null && item.employeeName! == selectedEmployee)
        .toList();
    notifyListeners();
  }


  /// Updates the selected day.
  void updateSelectedDay(int? day) {
    _selectedDay = day;
    notifyListeners();
  }

  /// Updates the selected year.
  void updateSelectedYear(int? year) {
    _selectedYear = year;
    notifyListeners();
  }

  /// Updates the selected month.
  void updateSelectedMonth(int? month) {
    _selectedMonth = month;
    notifyListeners();
  }

  Future<void> getAssignedDetailsForTheMonth(int year, int month) async {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
    String startDate = formatDate(firstDayOfMonth);
    String endDate = formatDate(lastDayOfMonth);
    filteredList = await CalendarServices().getRouteAssignmentDetailsForMonth(startDate, endDate);
    // routes = assignmentList.where((item) => item.employeeName != null && item.employeeName! == selectedEmployee)
    //     .toList();
    notifyListeners();
  }

  void getAssignedDetailsForTheWeek(DateTime startOfWeek) async{
    final DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
    final String startWeek = DateFormat('yyyy-MM-dd').format(startOfWeek);
    final String endWeek = DateFormat('yyyy-MM-dd').format(endOfWeek);

   filteredList = await  CalendarServices().getRouteAssignmentDetailsForMonth(startWeek, endWeek);
    // routes = assignmentList.where((item) => item.employeeName != null && item.employeeName! == selectedEmployee)
    //     .toList();
   notifyListeners();

  }


  String formatDate(DateTime dateTime){
    DateFormat formatter = DateFormat('yyyy-MM-dd'); // Change the format as needed
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }



//   /// Retrieves routes data for the selected month.
//  void  getRoutesForSelectedMonth() {
//     if (_selectedMonth != null && _selectedYear != null) {
//       routes =  routes.where((route) {
//         DateTime routeDate = DateFormat('yyyy-MM-dd').parse(route.datetime!);
//          routeDate.month == _selectedMonth! &&
//             routeDate.year == _selectedYear!;
//       }).toList();
//       notifyListeners();
//     } else {
//       routes =[];
//     }
//   }
// }
}