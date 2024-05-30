import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCalendarHeader extends StatelessWidget {
  final int? selectedYear;
  final int? selectedMonth;
  final Function(int?) onYearChanged;
  final Function(int?) onMonthChanged;

  const CustomCalendarHeader({
    Key? key,
    this.selectedYear,
    this.selectedMonth,
    required this.onYearChanged,
    required this.onMonthChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<int>(
            value: selectedMonth,
            onChanged: onMonthChanged,
            items: List.generate(12, (index) {
              return DropdownMenuItem<int>(
                value: index + 1,
                child: Text('${DateFormat.MMMM().format(DateTime(2022, index + 1))}'),
              );
            }),
          ),
          SizedBox(width: 10),
          DropdownButton<int>(
            value: selectedYear,
            onChanged: onYearChanged,
            items: List.generate(5, (index) {
              return DropdownMenuItem<int>(
                value: DateTime.now().year + index,
                child: Text('${DateTime.now().year + index}'),
              );
            }),
          ),
        ],
      ),
    );
  }
}
