import 'package:creaphur/common/form_utils.dart';
import 'package:creaphur/common/retailers.dart';
import 'package:creaphur/models/material.dart' as material_model;
import 'package:creaphur/widgets/filled_action_button.dart';
import 'package:creaphur/widgets/outlined_dropdown.dart';
import 'package:creaphur/widgets/outlined_file_picker.dart';
import 'package:creaphur/widgets/outlined_text_field.dart';
import 'package:creaphur/widgets/unit_dropdown.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaterialForm extends StatefulWidget {
  final Function onChange;
  final material_model.Material? material;
  final Function onSave;
  final bool isNew;

  const MaterialForm(
      {super.key,
      required this.onChange,
      required this.material,
      required this.onSave,
      required this.isNew});

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
                    onValidate: (value) => FormUtils.onValidateMaterial(
                        value, context, widget.isNew),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: OutlinedDropdown(
                    labelText: 'Vendor',
                    initialValue: retailers.contains(widget.material?.retailer)
                        ? widget.material?.retailer
                        : 'Other',
                    items: retailers
                        .map((retailer) => DropdownMenuItem<String>(
                              value: retailer,
                              child: Text(retailer),
                            ))
                        .toList(),
                    width: double.infinity,
                    height: 56,
                    onChange: (value) => widget.onChange('retailer', value),
                  ),
                ),
                (widget.material?.retailer == 'Other' ||
                        !retailers.contains(widget.material?.retailer))
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: OutlinedTextField(
                          initialValue: widget.material?.retailer ?? '',
                          hintText: 'Retailer Name',
                          labelText: 'Retailer Name *',
                          maxLines: 1,
                          onChange: (value) =>
                              widget.onChange('retailer', value),
                          onValidate: (String? value) =>
                              FormUtils.onValidateBasicString(
                                  value, 'Please enter a retailer name'),
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Flexible(
                        child: OutlinedTextField(
                          initialValue:
                              widget.material?.costPer.toStringAsFixed(2) ??
                                  '0.00',
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          hintText: 'Cost for Material Per Unit',
                          labelText: 'Cost *',
                          maxLines: 1,
                          onValidate: (value) => FormUtils.onValidateCurrency(
                              value,
                              'cost',
                              'material',
                              widget.onChange,
                              'costPer'),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text('Per'),
                      const SizedBox(width: 5),
                      UnitDropdown(
                          initialValue: widget.material?.quantityType,
                          onChange: (value) =>
                              widget.onChange('quantityType', value)),
                    ],
                  ),
                ),
                OutlinedFilePicker(
                  onChange: widget.onChange,
                  type: FileType.image,
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
