import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatelessWidget {
  final DateTime dateTime;
  final Function onChange;
  final String buttonText;

  const DateTimePicker(
      {super.key,
      required this.dateTime,
      required this.onChange,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year + 100));

    Future<TimeOfDay?> pickTime() => showTimePicker(
          initialTime: TimeOfDay.now(),
          context: context,
        );

    void chooseDate() async {
      DateTime? selectedDate = await pickDate();
      if (selectedDate != null) {
        onChange('date', selectedDate);
      }
    }

    void chooseTime() async {
      TimeOfDay? selectedTime = await pickTime();
      if (selectedTime != null) {
        onChange('time', selectedTime);
      }
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: OutlinedButton(
              onPressed: chooseDate,
              child: Text(
                  '$buttonText Date *: ${DateFormat.yMMMMEEEEd().format(dateTime)}')),
        ),
        OutlinedButton(
            onPressed: chooseTime,
            child:
                Text('$buttonText Time *: ${DateFormat.jm().format(dateTime)}'))
      ],
    );
  }
}
