import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../model/get_teritorry_details.dart';
import '../../../services/route_services.dart';

class RoutesViewModel extends BaseViewModel{
  final List<int> _availableYears = [2022,2023,2024,2025,2026,2027];
  int? _selectedYear;
  int? _selectedmonth;
  int? _selectedday;
  List<int> get availableYears => _availableYears;
  int? get selectedYear => _selectedYear;
  int? get selectedMonth => _selectedmonth;
  int? get selectedDay => _selectedday;
  List<RouteAssignmentData> routes = [];
  CalendarFormat calendarFormat = CalendarFormat.month;

  initialise (BuildContext context)async{
    setBusy(true);
    getAssignmentDetails(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    setBusy(false);
    notifyListeners();
  }
  void calenderformat(format){
    calendarFormat=format;
    notifyListeners();
  }

 Future<void> getAssignmentDetails(String date) async {
    routes = await RouteServices().getRouteAssignmentDetails(date);
    notifyListeners();
  }

  Future<void> refresh() async {

    notifyListeners();
  }


  void updateSelectedDay(int? day) {
    // Update the selected year and fetch holidays for the selected year
    _selectedday = day;
    notifyListeners();
  }


  void updateSelectedYear(int? year) {
    // Update the selected year and fetch holidays for the selected year
    _selectedYear = year;
    notifyListeners();
  }

  void updateSelectedmonth(int? month) {
    // Update the selected year and fetch holidays for the selected year
    _selectedmonth = month;
    notifyListeners();
  }


}