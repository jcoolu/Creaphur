import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/time_entry.dart';
import 'package:flutter/material.dart';

class TimeEntrySummaryCard extends StatelessWidget {
  final TimeEntry timeEntry;
  final void Function()? onTap;

  const TimeEntrySummaryCard({
    super.key,
    required this.timeEntry,
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
              title: Text(timeEntry.name,
                  softWrap: false,
                  style: const TextStyle(overflow: TextOverflow.ellipsis)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Duration: ${timeEntry.getDuration(context)}'),
                  Text('Cost: \$${timeEntry.costOfServices}')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
