import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class YearlyCalendar extends StatelessWidget {
  final int year;

  YearlyCalendar({required this.year});

  // Function to get the number of days in a given month and year
  int _daysInMonth(int month, int year) {
    return DateTime(year, month + 1, 0).day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Year $year Calendar'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(12, (index) {
            int month = index + 1;
            return _buildMonthGrid(month, year);
          }),
        ),
      ),
    );
  }

  Widget _buildMonthGrid(int month, int year) {
    int daysInMonth = _daysInMonth(month, year);
    List<Widget> weekRows = [];
    List<Widget> currentWeek = [];

    // Add empty widgets for days before the 1st of the month (to align with weekdays)
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    int startingWeekday = firstDayOfMonth.weekday; // 1 for Monday, 7 for Sunday

    // Create empty cells for days before the 1st of the month
    for (int i = 1; i < startingWeekday; i++) {
      currentWeek.add(_buildEmptyDaySquare());
    }

    // Add day squares for each day of the month
    for (int day = 1; day <= daysInMonth; day++) {
      currentWeek.add(_buildDaySquare(day, month, year));

      // If we have filled a complete week (7 days), add it to weekRows and start a new week
      if (currentWeek.length == 7) {
        weekRows.add(Row(children: List.of(currentWeek)));
        currentWeek.clear();
      }
    }

    // Add the last week if it's not already added (for the last days of the month)
    if (currentWeek.isNotEmpty) {
      weekRows.add(Row(children: List.of(currentWeek)));
    }

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat.MMMM().format(DateTime(year, month)),
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Column(children: List.of(weekRows)),
        ],
      ),
    );
  }

  Widget _buildEmptyDaySquare() {
    return Container(
      width: 40.0,
      height: 40.0,
      alignment: Alignment.center,
    );
  }

  Widget _buildDaySquare(int day, int month, int year) {
    return GestureDetector(
      onTap: () {
        // Handle day square tap (e.g., navigate to a specific day)
        print('Selected: $year-$month-$day');
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Text(
          '$day',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
