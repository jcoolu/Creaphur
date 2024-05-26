import 'dart:convert';

import 'package:creaphur/models/project.dart';
import 'package:creaphur/widgets/calendar/main.dart';
import 'package:creaphur/widgets/project_status_indicator.dart';
import 'package:flutter/material.dart';

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
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        children: [
          project.image.isEmpty
              ? const Icon(
                  Icons.assessment,
                  color: Color(0xff2900cc),
                )
              : Image.memory(base64Decode(project.image)),
          Text(project.description ?? ''),
          ProjectStatusIndicator(status: project.status),
          Text('Total Cost of Materials: ${project.getTotalCost(context)}'),
          Text('Total Hours Worked on: ${project.getTotalHours(context)}'),
          Text('Total Cost of Services: ${project.getCostOfServices(context)}'),
          Text('Materials Used: ${project.getMaterials(context)}'),
          Calendar(
            year: year,
            month: month,
            timeEntries: [],
            onChange: onChange,
          )
        ],
      ),
    );
  }
}
