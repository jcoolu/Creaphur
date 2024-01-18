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
    String formatDuration() {
      Duration duration = timeEntry.endDate.difference(timeEntry.startDate);
      String result = '';

      if (duration.inDays > 0) {
        result += '${duration.inDays} ${duration.inDays == 1 ? 'day' : 'days'}';
      }

      if (duration.inHours.remainder(24) > 0) {
        result +=
            '${result.isEmpty ? '' : ', '}${duration.inHours.remainder(24)} ${duration.inHours.remainder(24) == 1 ? 'hour' : 'hours'}';
      }

      if (duration.inMinutes.remainder(60) > 0) {
        result +=
            '${result.isEmpty ? '' : ', '}${duration.inMinutes.remainder(60)} ${duration.inMinutes.remainder(60) == 1 ? 'minute' : 'minutes'}';
      }

      return result.isEmpty ? '0 minutes' : result;
    }

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
                  Text('Duration: ${formatDuration()}'),
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
