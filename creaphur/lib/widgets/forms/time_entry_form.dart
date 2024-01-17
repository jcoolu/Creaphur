import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/time_entry.dart';
import 'package:creaphur/widgets/date_time_picker.dart';
import 'package:creaphur/widgets/filled_action_button.dart';
import 'package:creaphur/widgets/outlined_text_field.dart';
import 'package:flutter/material.dart';

// Define a custom Form widget.
class TimeEntryForm extends StatefulWidget {
  final Function onChange;
  final TimeEntry? timeEntry;
  final Function onSave;

  const TimeEntryForm(
      {super.key,
      required this.onChange,
      required this.timeEntry,
      required this.onSave});

  @override
  TimeEntryFormState createState() {
    return TimeEntryFormState();
  }
}

class TimeEntryFormState extends State<TimeEntryForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void handleChangeStartDate(field, value) {
      if (field == 'date') {
        DateTime nextDate = value;
        widget.onChange(
            'startDate',
            DateTime(
              nextDate.year,
              nextDate.month,
              nextDate.day,
              widget.timeEntry!.startDate.hour,
              widget.timeEntry!.startDate.minute,
            ));
      } else {
        TimeOfDay nextTime = value;
        widget.onChange(
            'startDate',
            DateTime(
              widget.timeEntry!.startDate.year,
              widget.timeEntry!.startDate.month,
              widget.timeEntry!.startDate.day,
              nextTime.hour,
              nextTime.minute,
            ));
      }
    }

    void handleChangeEndDate(field, value) {
      if (field == 'date') {
        DateTime nextDate = value;
        widget.onChange(
            'endDate',
            DateTime(
              nextDate.year,
              nextDate.month,
              nextDate.day,
              widget.timeEntry!.endDate.hour,
              widget.timeEntry!.endDate.minute,
            ));
      } else {
        TimeOfDay nextTime = value;
        widget.onChange(
            'endDate',
            DateTime(
              widget.timeEntry!.endDate.year,
              widget.timeEntry!.endDate.month,
              widget.timeEntry!.endDate.day,
              nextTime.hour,
              nextTime.minute,
            ));
      }
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: OutlinedTextField(
                    initialValue: widget.timeEntry?.name ?? '',
                    hintText: 'Time Entry Name',
                    labelText: 'Name *',
                    onChange: (value) => widget.onChange('name', value),
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name for your time entry';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DateTimePicker(
                      dateTime: widget.timeEntry?.startDate ?? DateTime.now(),
                      onChange: handleChangeStartDate,
                      buttonText: 'Time Start'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DateTimePicker(
                      dateTime: widget.timeEntry?.endDate ??
                          DateTime.now().add(const Duration(days: 1)),
                      onChange: handleChangeEndDate,
                      buttonText: 'Time End'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OutlinedTextField(
                    initialValue:
                        widget.timeEntry?.costOfServices.toStringAsFixed(2) ??
                            '0.00',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    hintText: 'Time Entry Cost of Service',
                    labelText: 'Cost of Services *',
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a projected cost for your project';
                      }
                      if (!Utils.isCurrencyValid(value)) {
                        return 'Please enter a valid format for Projected Cost.';
                      }
                      widget.onChange('estCost', double.parse(value));
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: FilledActionButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.onSave();
                        }
                      },
                      buttonText: 'Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
