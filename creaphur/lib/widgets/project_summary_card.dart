import 'dart:convert';

import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/project.dart';
import 'package:flutter/material.dart';

class ProjectSummaryCard extends StatelessWidget {
  final Project project;
  final void Function()? onTap;

  const ProjectSummaryCard({
    super.key,
    required this.project,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
                leading: project.image.isEmpty
                    ? const Icon(Icons.assessment)
                    : Image.memory(base64Decode(project.image)),
                title: Text(project.name),
                subtitle: Text(project.description ?? ''),
                trailing: Column(
                  children: [
                    const Text('0 Hours Logged'),
                    Text('\$ 0 / ${project.estCost}'),
                    Utils.daysBetween(DateTime.now(), project.endDate) < 0
                        ? const Text('Project End Date Passed')
                        : Text(
                            '${Utils.daysBetween(DateTime.now(), project.endDate).toString()} days left'),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
