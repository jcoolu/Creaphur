import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/time_entry.dart';
import 'package:creaphur/widgets/date_time_picker.dart';
import 'package:creaphur/widgets/filled_action_button.dart';
import 'package:creaphur/widgets/outlined_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    void handleChangeDate(field, value) {
      DateTime nextDate = value;
      widget.onChange(
          field,
          DateTime(
            nextDate.year,
            nextDate.month,
            nextDate.day,
            nextDate.hour,
            nextDate.minute,
          ));
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
                    maxLines: 1,
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
                      type: 'startDate',
                      dateTime: widget.timeEntry?.startDate ?? DateTime.now(),
                      onChange: handleChangeDate,
                      conditional: 'isBefore',
                      compareDate: widget.timeEntry?.endDate ??
                          DateTime.now().add(const Duration(days: 1)),
                      buttonText: 'Time Start'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DateTimePicker(
                      type: 'endDate',
                      dateTime: widget.timeEntry?.endDate ??
                          DateTime.now().add(const Duration(days: 1)),
                      conditional: 'isAfter',
                      compareDate:
                          widget.timeEntry?.startDate ?? DateTime.now(),
                      onChange: handleChangeDate,
                      buttonText: 'Time End'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OutlinedTextField(
                    initialValue:
                        widget.timeEntry?.costOfServices.toStringAsFixed(2) ??
                            '0.00',
                    maxLines: 1,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
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
                      widget.onChange('costOfServices', double.parse(value));
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
