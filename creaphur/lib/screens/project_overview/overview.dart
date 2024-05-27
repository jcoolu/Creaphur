import 'dart:convert';

import 'package:creaphur/models/project.dart';
import 'package:creaphur/models/time_entry.dart';
import 'package:creaphur/models/time_entry_list.dart';
import 'package:creaphur/widgets/calendar/main.dart';
import 'package:creaphur/widgets/compare_chart/main.dart';
import 'package:creaphur/widgets/project_status_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverviewScreen extends StatelessWidget {
  final Project project;
  final int month;
  final int year;
  final Function(int, int) onChange;

  const OverviewScreen(
      {super.key,
      required this.project,
      required this.month,
      required this.year,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    List<TimeEntry> timeEntries =
        Provider.of<TimeEntryList>(context, listen: true)
            .items
            .where((time) => time.projectId == project.id)
            .toList();
    List<String> materials = project.getMaterials(context);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        children: [
          project.image.isEmpty
              ? const Icon(
                  size: 150,
                  Icons.assessment,
                  color: Color(0xff2900cc),
                )
              : Image.memory(base64Decode(project.image)),
          const SizedBox(height: 8),
          Text(
            project.description ?? '',
            style: const TextStyle(
              color: Color(0xff6c47ff),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ProjectStatusIndicator(status: project.status),
          const SizedBox(height: 8),
          Text(
            'Total Cost of Materials: \$${project.getTotalCost(context)},',
            style: const TextStyle(
              color: Color(0xff6c47ff),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Total Time Worked on: ${project.getTotalHours(context)}',
            style: const TextStyle(
              color: Color(0xff6c47ff),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Total Cost of Services: ${project.getCostOfServices(context)}',
            style: const TextStyle(
              color: Color(0xff6c47ff),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Materials Used:',
            style: TextStyle(
              color: Color(0xff6c47ff),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (materials.isNotEmpty)
            ...materials
                .map((item) => ListTile(
                      leading: const Text(
                        "•",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff6c47ff)),
                      ),
                      title: Text(
                        item,
                        style: const TextStyle(
                          color: Color(0xff6c47ff),
                          fontSize: 16,
                        ),
                      ),
                    ))
                .toList()
          else
            const Center(
              child: Text(
                "No materials added.",
                style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Color(0xff6c47ff)),
              ),
            ),
          const SizedBox(height: 8),
          Calendar(
            year: year,
            month: month,
            timeEntries: timeEntries,
            onChange: onChange,
          ),
          CompareChart(
            project: project,
          ),
        ],
      ),
    );
  }
}
