import 'dart:convert';

import 'package:creaphur/models/project.dart';
import 'package:creaphur/widgets/project_status_indicator.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatelessWidget {
  final Project project;

  const OverviewScreen({super.key, required this.project});

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
          Text('Total Cost of Materials: \$${project.getTotalCost(context)}'),
          Text('Total Hours Worked on: ${project.getTotalHours(context)}'),
          Text('Total Cost of Services: ${project.getCostOfServices(context)}'),
          Text('Materials Used: ${project.getMaterials(context)}')
        ],
      ),
    );
  }
}
