import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/widgets/date_time_picker.dart';
import 'package:creaphur/widgets/filled_action_button.dart';
import 'package:creaphur/widgets/outlined_dropdown.dart';
import 'package:creaphur/widgets/outlined_file_picker.dart';
import 'package:creaphur/widgets/outlined_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Define a custom Form widget.
class ProjectForm extends StatefulWidget {
  final Function onChange;
  final Project? project;
  final Function onSave;

  const ProjectForm(
      {super.key,
      required this.onChange,
      required this.project,
      required this.onSave});

  @override
  ProjectFormState createState() {
    return ProjectFormState();
  }
}

class ProjectFormState extends State<ProjectForm> {
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
                    initialValue: widget.project?.name ?? '',
                    hintText: 'Project Name',
                    labelText: 'Name *',
                    maxLines: 1,
                    onChange: (value) => widget.onChange('name', value),
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name for your project';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OutlinedTextField(
                    initialValue: widget.project?.description ?? '',
                    hintText: 'Project Description',
                    labelText: 'Description',
                    inputFormatters: [LengthLimitingTextInputFormatter(320)],
                    onChange: (value) => widget.onChange('description', value),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OutlinedDropdown(
                      hint: const Text('Status of Project'),
                      width: double.infinity,
                      height: 56,
                      initialValue:
                          widget.project?.status ?? Project.getStatuses().first,
                      items: Project.getStatuses()
                          .map((status) => DropdownMenuItem<String>(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChange: (value) => widget.onChange('status', value)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DateTimePicker(
                      type: 'startDate',
                      dateTime: widget.project?.startDate ?? DateTime.now(),
                      onChange: handleChangeDate,
                      buttonText: 'Projected Start',
                      conditional: 'isBefore',
                      showTime: false,
                      compareDate: widget.project?.endDate ??
                          DateTime.now().add(const Duration(days: 1))),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DateTimePicker(
                      type: 'endDate',
                      dateTime: widget.project?.endDate ??
                          DateTime.now().add(const Duration(days: 1)),
                      onChange: handleChangeDate,
                      conditional: 'isAfter',
                      showTime: false,
                      compareDate: widget.project?.startDate ??
                          DateTime.now().add(const Duration(days: 1)),
                      buttonText: 'Projected End'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OutlinedTextField(
                    initialValue:
                        widget.project?.estCost.toStringAsFixed(2) ?? '0.00',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    maxLines: 1,
                    hintText: 'Projected Cost for Project',
                    labelText: 'Projected Cost *',
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
                OutlinedFilePicker(
                  onChange: widget.onChange,
                  type: FileType.image,
                  childWidget: Text(
                      (widget.project == null || widget.project!.image.isEmpty)
                          ? 'Select File'
                          : 'Image Selected'),
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
