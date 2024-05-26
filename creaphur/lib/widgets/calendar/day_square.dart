import 'package:creaphur/models/time_entry.dart';
import 'package:flutter/material.dart';

class DaySquare extends StatelessWidget {
  final int? day;
  final List<TimeEntry> timeEntries;
  final String level;

  const DaySquare(
      {super.key,
      required this.day,
      required this.timeEntries,
      required this.level});
  @override
  Widget build(BuildContext context) {
    int totalTime = timeEntries.isNotEmpty
        ? timeEntries
            .map((time) => time.getTimeInSeconds())
            .reduce((a, b) => a + b)
        : 0;
    Color handleColor() {
      if (level == 'small') {
        return const Color(0xff6c47ff);
      }
      if (level == 'medium') {
        return const Color.fromARGB(255, 59, 12, 247);
      }
      if (level == 'large') {
        return const Color(0xff2900cc);
      }
      return const Color(0xffad99ff);
    }

    String formatDuration(int seconds) {
      // Calculate hours from seconds
      int hours = seconds ~/ 3600;

      // Calculate remaining seconds after extracting hours
      int remainingSeconds = seconds % 3600;

      // Calculate minutes from remaining seconds
      int minutes = remainingSeconds ~/ 60;

      // Create formatted duration string
      String formattedDuration = '$hours:${minutes.toString().padLeft(2, '0')}';

      return formattedDuration;
    }

    return day != null
        ? Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            message: formatDuration(totalTime), // Tooltip message
            child: Container(
              width: 40.0,
              height: 40.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff2900cc)),
                shape: BoxShape.circle,
                color: handleColor(),
              ),
              child: Text(
                '$day',
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
          )
        : Container(
            width: 40.0,
            height: 40.0,
            alignment: Alignment.center,
          );
  }
}
