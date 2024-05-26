import 'package:creaphur/models/time_entry.dart';
import 'package:creaphur/widgets/calendar/day_square.dart';
import 'package:flutter/material.dart';

class YearlyCalendar extends StatelessWidget {
  final int year;
  final int month;
  final List<TimeEntry> timeEntries;

  const YearlyCalendar({
    super.key,
    required this.year,
    required this.month,
    required this.timeEntries,
  });

  // Function to get the number of days in a given month and year
  int _daysInMonth(int month, int year) {
    return DateTime(year, month + 1, 0).day;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDayLabelsRow(),
          const SizedBox(height: 8.0),
          Expanded(
            child: SingleChildScrollView(
              child: _buildMonthGrid(month, year),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthGrid(int month, int year) {
    int daysInMonth = _daysInMonth(month, year);
    List<Widget> weekRows = [];
    List<Widget> currentWeek = [];

    // Add empty widgets for days before the 1st of the month (to align with weekdays)
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    int startingWeekday = firstDayOfMonth.weekday %
        7; // 0 for Sunday, 1 for Monday, ..., 6 for Saturday

    // Create empty cells for days before the 1st of the month
    for (int i = 0; i < startingWeekday; i++) {
      currentWeek.add(const Expanded(
        child: DaySquare(day: null, timeEntries: [], level: 'none'),
      ));
    }

    // Add day squares for each day of the month
    for (int day = 1; day <= daysInMonth; day++) {
      currentWeek.add(Expanded(child: _buildDaySquare(day, month, year)));

      // If we have filled a complete week (7 days), add it to weekRows and start a new week
      if (currentWeek.length == 7) {
        weekRows.add(Row(children: List.of(currentWeek)));
        currentWeek.clear();
      }
    }

    // Add the last week if it's not already added (for the last days of the month)
    if (currentWeek.isNotEmpty) {
      // Fill the rest of the week with empty cells if necessary
      while (currentWeek.length < 7) {
        currentWeek.add(const Expanded(
          child: DaySquare(day: null, timeEntries: [], level: 'none'),
        ));
      }
      weekRows.add(Row(children: List.of(currentWeek)));
    }

    return Column(
      children: weekRows,
    );
  }

  Widget _buildDaySquare(int day, int month, int year) {
    List<TimeEntry> times = timeEntries
        .where((time) =>
            time.startDate.isBefore(DateTime(year, month, day)) &&
            time.endDate.isAfter(DateTime(year, month, day)))
        .toList();

    bool isSelected = times.isNotEmpty;

    if (isSelected) {
      int totalTime =
          times.map((time) => time.getTimeInSeconds()).reduce((a, b) => a + b);
      String level = 'small';
      // if time is greater than or equal to four hours (in seconds)
      if (totalTime >= 14400) {
        level = 'medium';
      }
      // if time is greater than or equal to seven hours (in seconds)
      if (totalTime >= 25200) {
        level = 'large';
      }
      return DaySquare(day: day, timeEntries: times, level: level);
    }

    return DaySquare(day: day, timeEntries: const [], level: 'none');
  }

  Widget _buildDayLabelsRow() {
    return Row(
      children: [
        _buildDayLabel('S'),
        _buildDayLabel('M'),
        _buildDayLabel('T'),
        _buildDayLabel('W'),
        _buildDayLabel('T'),
        _buildDayLabel('F'),
        _buildDayLabel('S'),
      ],
    );
  }

  Widget _buildDayLabel(String label) {
    return Expanded(
      child: Container(
        height: 40.0,
        width: 100,
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
