// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DateTimePicker extends StatelessWidget {
  final DateTime dateTime;
  final Function onChange;
  final String buttonText;
  final String type;
  String? conditional = "";
  DateTime? compareDate;
  bool? showTime = true;

  DateTimePicker(
      {super.key,
      required this.dateTime,
      required this.onChange,
      required this.buttonText,
      required this.type,
      this.showTime,
      this.conditional,
      this.compareDate});

  @override
  Widget build(BuildContext context) {
    DateTime firstDate = (conditional == 'isAfter' && compareDate != null)
        ? compareDate!
        : DateTime(1900);
    DateTime lastDate = (conditional == 'isBefore' && compareDate != null)
        ? compareDate!
        : DateTime(DateTime.now().year + 100);

    Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: lastDate,
        initialDate: dateTime);

    Future<TimeOfDay?> pickTime() async {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      );

      if (selectedTime != null) {
        DateTime selectedDateTime = DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        // Validate time based on the condition
        if (conditional == 'isAfter' && compareDate != null) {
          if (selectedDateTime.isAfter(compareDate!)) {
            return selectedTime;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('Time must be after the selected start time')),
            );
          }
        } else if (conditional == 'isBefore' && compareDate != null) {
          if (selectedDateTime.isBefore(compareDate!)) {
            return selectedTime;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('Time must be before the selected end time')),
            );
          }
        } else {
          return selectedTime;
        }
      }
      return null;
    }

    void chooseDate() async {
      DateTime? selectedDate = await pickDate();
      if (selectedDate != null) {
        onChange(type, selectedDate);
        if (compareDate != null && compareDate!.day == selectedDate.day) {
          bool isValid = conditional == 'isBefore'
              ? selectedDate.isAfter(compareDate!)
              : selectedDate.isBefore(compareDate!);
          if (!isValid) {
            if (conditional == 'isAfter') {
              DateTime updatedTime = compareDate!.add(const Duration(hours: 1));
              onChange(
                  type,
                  DateTime(selectedDate.year, selectedDate.month,
                      selectedDate.day, updatedTime.hour, updatedTime.minute));
            } else {
              DateTime updatedTime =
                  compareDate!.subtract(const Duration(hours: 1));
              onChange(
                  type,
                  DateTime(selectedDate.year, selectedDate.month,
                      selectedDate.day, updatedTime.hour, updatedTime.minute));
            }
          }
        }
      }
    }

    void chooseTime() async {
      TimeOfDay? selectedTime = await pickTime();
      if (selectedTime != null) {
        onChange(
            type,
            DateTime(dateTime.year, dateTime.month, dateTime.day,
                selectedTime.hour, selectedTime.minute));
      }
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
                onPressed: chooseDate,
                child: Text(
                    '$buttonText Date *: ${DateFormat.yMMMMEEEEd().format(dateTime)}')),
          ),
        ),
        if (showTime ?? true)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
                onPressed: chooseTime,
                child: Text(
                    '$buttonText Time *: ${DateFormat.jm().format(dateTime)}')),
          )
      ],
    );
  }
}
