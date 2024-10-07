import 'dart:convert';

import 'package:creaphur/common/form_utils.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/widgets/date_time_picker.dart';
import 'package:creaphur/widgets/filled_action_button.dart';
import 'package:creaphur/widgets/image_file_picker.dart';
import 'package:creaphur/widgets/outlined_dropdown.dart';
import 'package:creaphur/widgets/outlined_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

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
  late ConfettiController _confettiController;
  late String selectedStatus;
  late String shownImage;
  static const int confettiDelay = 1;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: confettiDelay));
    selectedStatus = widget.project?.status ?? Project.getStatuses().first;
    shownImage = widget.project?.image ?? '';
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

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

    void handleRotateImage() async {
      Uint8List bytes = base64Decode(widget.project!.image);
      List<int> result = await FlutterImageCompress.compressWithList(bytes,
          quality: 100, rotate: 90);
      setState(() => shownImage = base64Encode(result));
      widget.onChange('image', base64Encode(result));
    }

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    shownImage.isEmpty
                        ? const Center(
                            child: Icon(
                              size: 150,
                              Icons.assessment,
                              color: Color(0xff2900cc),
                            ),
                          )
                        : Center(
                            child: Image.memory(base64Decode(shownImage),
                                width: MediaQuery.of(context).size.width / 2,
                                fit: BoxFit.cover),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: OutlinedTextField(
                        initialValue: widget.project?.name ?? '',
                        hintText: 'Project Name',
                        labelText: 'Name *',
                        maxLines: 1,
                        onChange: (value) => widget.onChange('name', value),
                        onValidate: (String? value) =>
                            FormUtils.onValidateBasicString(
                                value, 'Please enter a name for your project'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: OutlinedTextField(
                        initialValue: widget.project?.description ?? '',
                        hintText: 'Project Description',
                        labelText: 'Description',
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(320)
                        ],
                        onChange: (value) =>
                            widget.onChange('description', value),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: OutlinedDropdown(
                          hint: const Text('Status of Project'),
                          width: double.infinity,
                          height: 56,
                          initialValue: selectedStatus,
                          items: Project.getStatuses()
                              .map((status) => DropdownMenuItem<String>(
                                    value: status,
                                    child: Text(status),
                                  ))
                              .toList(),
                          onChange: (value) {
                            setState(() {
                              selectedStatus = value;
                            });
                            widget.onChange('status', value);
                          }),
                    ),
                    const SizedBox(child: Text('Projected Start: *')),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: DateTimePicker(
                          type: 'startDate',
                          dateTime: widget.project?.startDate ?? DateTime.now(),
                          onChange: handleChangeDate,
                          buttonText: '',
                          conditional: 'isBefore',
                          showTime: false,
                          compareDate: widget.project?.endDate ??
                              DateTime.now().add(const Duration(days: 1))),
                    ),
                    const SizedBox(child: Text('Projected End: *')),
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
                          buttonText: ''),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: OutlinedTextField(
                          initialValue:
                              widget.project?.estCost.toStringAsFixed(2) ??
                                  '0.00',
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          maxLines: 1,
                          hintText: 'Projected Cost for Project',
                          labelText: 'Projected Cost *',
                          onValidate: (value) => FormUtils.onValidateCurrency(
                              value,
                              'projected cost',
                              'project',
                              widget.onChange,
                              'estCost'),
                          prefix: '\$'),
                    ),
                    ImageFilePicker(
                        onFileChange: (String field, String value) {
                          widget.onChange(field, value);
                          setState(() => shownImage = value);
                        },
                        childWidget: Text((widget.project!.image.isEmpty)
                            ? 'Select Image'
                            : 'Image Selected'),
                        onRotateImage: handleRotateImage,
                        icon: Icons.rotate_90_degrees_cw_outlined,
                        isFilePicked: widget.project?.image != null &&
                            widget.project!.image.isNotEmpty),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: FilledActionButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Check if the status is "Completed"
                              if (selectedStatus == 'Completed') {
                                // Start confetti
                                _confettiController.play();
                                // Delay to let the confetti finish.
                                Future.delayed(
                                    const Duration(seconds: confettiDelay + 1),
                                    () {
                                  widget.onSave();
                                });
                              } else {
                                widget
                                    .onSave(); // Save immediately if status is not "Complete"
                              }
                            }
                          },
                          buttonText: 'Save'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            numberOfParticles: 50,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
          ),
        ),
      ],
    );
  }
}
