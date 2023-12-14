import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../model/expenselist_model.dart';
import '../../../model/leave_list.dart';
import '../../../services/list_expense_services.dart';
import '../../../services/list_leave_services.dart';


class  LeaveViewModel extends BaseViewModel{
List<LeaveList> _upcomingleavelist=[];
List<LeaveList> _takenleavelist=[];
  final List<int> _availableYears = [2022,2023,2024,2025,2026,2027];
  int? _selectedYear;
  int? _selectedmonth;

  List<LeaveList> get leavelist => _upcomingleavelist;
List<LeaveList> get takenlist => _takenleavelist;
  List<int> get availableYears => _availableYears;
  int? get selectedYear => _selectedYear;
  int? get selectedMonth => _selectedmonth;

  initialise(BuildContext context) async {
    setBusy(true);
    _upcomingleavelist=await fetchupcomingleaveForCurrentYear();
    _takenleavelist=await fetchTakenLeaveForCurrentYear();
    notifyListeners();
    setBusy(false);
  }

  Future<List<LeaveList>> fetchupcomingleaveForCurrentYear() async {
    _selectedYear = DateTime.now().year.toInt();
    _selectedmonth=DateTime.now().month;
    List<LeaveList> holidays = await ListLeaveServices().fetchLeaves();
    return holidays;
  }

Future<List<LeaveList>> fetchTakenLeaveForCurrentYear() async {
  _selectedYear = DateTime.now().year.toInt();
  _selectedmonth=DateTime.now().month;
  List<LeaveList> holidays = await ListLeaveServices().fetchtakenLeaves();
  return holidays;
}

  void updateSelectedYear(int? year) {
    // Update the selected year and fetch holidays for the selected year
    _selectedYear = year;
    fetchHolidaysForSelectedYear();
    notifyListeners();
  }

  void updateSelectedmonth(int? month) {
    // Update the selected year and fetch holidays for the selected year
    _selectedmonth = month;
    fetchHolidaysForSelectedYear();
    notifyListeners();
  }

  Future<void> fetchHolidaysForSelectedYear() async {
    if (_selectedYear != null && _selectedmonth != null) {
      _upcomingleavelist = await ListLeaveServices().fetchLeaves();
      notifyListeners();
    }
  }
  String getMonthName(int month) {
    // Ensure that the month is within a valid range (1 to 12)
    if (month < 1 || month > 12) {
      throw ArgumentError('Invalid month: $month');
    }
    // Create a DateTime object with the desired month and format it to get the month name
    DateTime dateTime = DateTime(2023, month, 1); // You can set any year, as it won't affect the month name
    String monthName = DateFormat('MMMM').format(dateTime);
    return monthName;
  }
}