import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/material.dart' as material_model;
import 'package:creaphur/models/material_list.dart';
import 'package:creaphur/widgets/filled_action_button.dart';
import 'package:creaphur/widgets/outlined_file_picker.dart';
import 'package:creaphur/widgets/outlined_text_field.dart';
import 'package:creaphur/widgets/unit_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MaterialForm extends StatefulWidget {
  final Function onChange;
  final material_model.Material? material;
  final Function onSave;

  const MaterialForm(
      {super.key,
      required this.onChange,
      required this.material,
      required this.onSave});

  @override
  MaterialFormState createState() {
    return MaterialFormState();
  }
}

class MaterialFormState extends State<MaterialForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                    initialValue: widget.material?.name ?? '',
                    hintText: 'Material Name',
                    labelText: 'Name *',
                    maxLines: 1,
                    onChange: (value) => widget.onChange('name', value),
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name for your material';
                      }

                      if (Provider.of<MaterialList>(context, listen: false)
                          .isDuplicate(value)) {
                        return 'Duplicate name';
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OutlinedTextField(
                    initialValue:
                        widget.material?.quantity.toStringAsFixed(2) ?? '0.00',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    maxLines: 1,
                    hintText: 'Available Quantity of Material',
                    labelText: 'Available Quantity *',
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a quantity for your material';
                      }
                      if (!Utils.isCurrencyValid(value)) {
                        return 'Please enter a valid format for quantity of material.';
                      }
                      widget.onChange('quantity', double.parse(value));
                      return null;
                    },
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: OutlinedTextField(
                          initialValue:
                              widget.material?.costPer.toStringAsFixed(2) ??
                                  '0.00',
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          hintText: 'Cost for Material Per Unit',
                          labelText: 'Cost *',
                          maxLines: 1,
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a cost for your material';
                            }
                            if (!Utils.isCurrencyValid(value)) {
                              return 'Please enter a valid format for material cost.';
                            }
                            widget.onChange('costPer', double.parse(value));
                            return null;
                          },
                        ),
                      ),
                    ),
                    const Text('Per'),
                    UnitDropdown(
                        initialValue: widget.material?.quantityType,
                        onChange: (value) =>
                            widget.onChange('quantityType', value)),
                  ],
                ),
                OutlinedFilePicker(
                  onChange: widget.onChange,
                  childWidget: Text((widget.material == null ||
                          widget.material!.image.isEmpty)
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
