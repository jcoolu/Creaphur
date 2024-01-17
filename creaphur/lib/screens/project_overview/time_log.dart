import 'package:creaphur/models/time_entry_list.dart';
import 'package:creaphur/models/time_entry.dart';
import 'package:creaphur/screens/timeEntry.dart';
import 'package:creaphur/widgets/time_entry_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeEntriesScreen extends StatelessWidget {
  final String projectId;

  const TimeEntriesScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    List<TimeEntry> timeEntries =
        Provider.of<TimeEntryList>(context, listen: true).items;

    void selectTimeEntry(TimeEntry timeEntry) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TimeEntryScreen(
            timeEntry: timeEntry,
          ),
        ),
      );
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: timeEntries.isEmpty
            ? const Center(
                child: Text(
                    'No time entries found. Please click (+) below to create a new time entry.'),
              )
            : SingleChildScrollView(
                child: Column(
                  children: timeEntries
                      .map(
                        (timeEntry) => TimeEntrySummaryCard(
                          timeEntry: timeEntry,
                          onTap: () => selectTimeEntry(timeEntry),
                        ),
                      )
                      .toList(),
                ),
              ),
      ),
    );
  }
}
