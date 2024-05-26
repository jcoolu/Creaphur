import 'package:creaphur/models/time_entry.dart';
import 'package:creaphur/widgets/calendar/month_year_selector.dart';
import 'package:creaphur/widgets/calendar/yearly_calendar.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  final List<TimeEntry> timeEntries;
  final Function(int, int) onChange;
  final int month;
  final int year;

  const Calendar(
      {super.key,
      required this.month,
      required this.year,
      required this.timeEntries,
      required this.onChange});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MonthYearSelector(
          month: widget.month,
          year: widget.year,
          onChanged: widget.onChange,
        ),
        // Remove Expanded and use a Container with a fixed height
        SizedBox(
          height: 300,
          child: YearlyCalendar(
            year: widget.year,
            month: widget.month,
            timeEntries: widget.timeEntries,
          ),
        ),
      ],
    );
  }
}
