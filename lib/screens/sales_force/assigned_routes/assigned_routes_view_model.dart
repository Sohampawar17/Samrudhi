import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../model/calendar_services.dart';
import '../../../model/employee_list.dart';
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
    setBusy(false);
  }

  void setFocusedDay(DateTime date) {
    focusedDay = date;
    notifyListeners();
  }

  List<String> getEmployeeNames() {
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
    routes = await RouteServices().getRouteAssignmentDetails(date);
    applyFilters();
  }

  /// Update the selected employee.
  void updateSelectedEmployee(String employee) async {
    selectedEmployee = employee;
    applyFilters();
  }

  /// Updates the selected day.
  void updateSelectedDay(int? day) {
    _selectedDay = day;
    applyFilters();
  }

  /// Updates the selected year.
  void updateSelectedYear(int? year) {
    _selectedYear = year;
    applyFilters();
  }

  /// Updates the selected month.
  void updateSelectedMonth(int? month) {
    _selectedMonth = month;
    applyFilters();
  }

  Future<void> getAssignedDetailsForTheMonth(int year, int month) async {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
    String startDate = formatDate(firstDayOfMonth);
    String endDate = formatDate(lastDayOfMonth);
    routes = await CalendarServices().getRouteAssignmentDetailsForMonth(startDate, endDate);
    applyFilters();
  }

  void getAssignedDetailsForTheWeek(DateTime startOfWeek) async {
    final DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
    final String startWeek = DateFormat('yyyy-MM-dd').format(startOfWeek);
    final String endWeek = DateFormat('yyyy-MM-dd').format(endOfWeek);

    routes = await CalendarServices().getRouteAssignmentDetailsForMonth(startWeek, endWeek);
    applyFilters();
  }

  String formatDate(DateTime dateTime) {
    DateFormat formatter = DateFormat('yyyy-MM-dd'); // Change the format as needed
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  /// Apply filters to the routes list based on the selected criteria.
  void applyFilters() {
    print('Applying filters...');
    filteredList = routes.where((route) {
      bool matchesEmployee = selectedEmployee == null || route.employeeName == selectedEmployee;
      return matchesEmployee;
    }).toList();

    print('Filtered routes count: ${filteredList.length}');

    filteredList.sort((a, b) => DateFormat('yyyy-MM-dd').parse(b.datetime!).compareTo(DateFormat('yyyy-MM-dd').parse(a.datetime!)));

    notifyListeners();
  }
}
