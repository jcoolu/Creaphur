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
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xff6c47ff), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              tileColor: const Color(0xffad99ff),
              textColor: Colors.white,
              splashColor: const Color(0xff2900cc),
              leading: project.image.isEmpty
                  ? const Icon(
                      Icons.assessment,
                      color: Color(0xff2900cc),
                    )
                  : Image.memory(base64Decode(project.image)),
              title: Text(project.name,
                  softWrap: false,
                  style: const TextStyle(overflow: TextOverflow.ellipsis)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Utils.daysBetween(DateTime.now(), project.endDate) < 0
                      ? const Text('Project End Date Passed')
                      : Text(
                          '${Utils.daysBetween(DateTime.now(), project.endDate).toString()} days left'),
                  const Text('Current Cost: \$0.00')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
