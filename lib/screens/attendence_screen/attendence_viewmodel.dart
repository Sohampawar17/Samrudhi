import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../model/attendance_model.dart';
import '../../services/attendence_services.dart';


class  AttendenceViewModel extends BaseViewModel{
  Map<DateTime, List<AttendanceList>> events = {};
  CalendarFormat calendarFormat = CalendarFormat.week;

  final List<int> _availableYears = [2022,2023,2024,2025,2026,2027];
  int? _selectedYear;
  int? _selectedmonth;

  List<AttendanceList> get attendancelist => _attendancelist;
  List<int> get availableYears => _availableYears;
  int? get selectedYear => _selectedYear;
  int? get selectedMonth => _selectedmonth;
  List<AttendanceList> _attendancelist=[];
  AttendanceDetails attendeancedetails=AttendanceDetails();

  initialise(BuildContext context) async {
    setBusy(true);
    _attendancelist=await fetchHolidaysForCurrentYear();
    attendeancedetails=await fetchattendancedetails();

    notifyListeners();
    setBusy(false);
  }

  Future<List<AttendanceList>> fetchHolidaysForCurrentYear() async {
    _selectedYear = DateTime.now().year.toInt();
    _selectedmonth=DateTime.now().month;
    List<AttendanceList> holidays = await AttendanceServices().fetchattendence(_selectedYear!,_selectedmonth!);
    return holidays;
  }

  Future<AttendanceDetails> fetchattendancedetails() async {
    _selectedYear = DateTime.now().year.toInt();
    _selectedmonth=DateTime.now().month;
    AttendanceDetails holidays = await AttendanceServices().attendencedata(_selectedYear!,_selectedmonth!) ?? AttendanceDetails();
    return holidays;
  }

  AttendanceList? getAttendanceForDate(DateTime date) {
    try {
      final attendance = attendancelist.firstWhere(
            (attendance) => isSameDay(DateTime.parse(attendance.attendanceDate ?? ""), date),
      );

      return attendance;
    } catch (e) {
      // Handle the case when no element is found
      return null;
    }
  }

  void calenderformat(format){
    calendarFormat=format;
    notifyListeners();
  }

  // A utility function to check if two dates are on the same day
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
  // Map<DateTime, List<AttendanceList>> getEventsForDay() {
  //
  //   for (AttendanceList attendence in attendancelist) {
  //     DateTime eventDate = DateTime.parse(attendence.attendanceDate ?? "");
  //       events.add(
  //           Event(eventDate)); // Pass the eventDate to the Event constructor
  //
  //   }
  //   return events;
  // }

  Color getColorForStatus(String status) {
    switch (status) {
      case 'Present':
        return Colors.green; // Set the color for Draft status
      case 'On Leave':
        return Colors.amber; // Set the color for On Hold status
      case 'Absent':
        return Colors.redAccent; // Set the color for To Deliver and Bill status
      case 'Half Day':
        return Colors.indigo; // Set the color for To Bill status
       // Set the color for Closed status
      default:
        return Colors.white; // Set a default color for unknown status
    }
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
      _attendancelist = await AttendanceServices().fetchattendence(selectedYear!,_selectedmonth!);
      attendeancedetails =await AttendanceServices().attendencedata(selectedYear!,selectedMonth!) ?? AttendanceDetails();
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