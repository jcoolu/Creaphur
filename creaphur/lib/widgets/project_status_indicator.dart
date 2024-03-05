import 'package:creaphur/models/project.dart';
import 'package:flutter/material.dart';

class ProjectStatusIndicator extends StatelessWidget {
  final String status;

  const ProjectStatusIndicator({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color returnColor() {
      return status == Project.inProgress
          ? const Color(0xffad99ff)
          : status == Project.finished
              ? Colors.green
              : Colors.red;
    }

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.elliptical(40, 50)),
        color: returnColor(),
      ),
      child: Center(child: Text(status)),
    );
  }
}
