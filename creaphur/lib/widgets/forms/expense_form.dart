import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/expense.dart';
import 'package:creaphur/models/material.dart' as material_model;
import 'package:creaphur/models/material_list.dart';
import 'package:creaphur/widgets/filled_action_button.dart';
import 'package:creaphur/widgets/outlined_file_picker.dart';
import 'package:creaphur/widgets/outlined_text_field.dart';
import 'package:creaphur/widgets/unit_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseForm extends StatefulWidget {
  final Function onChange;
  final Expense? expense;
  final Function onSave;

  const ExpenseForm(
      {super.key,
      required this.onChange,
      required this.expense,
      required this.onSave});

  @override
  ExpenseFormState createState() {
    return ExpenseFormState();
  }
}

class ExpenseFormState extends State<ExpenseForm> {
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
                    initialValue: widget.expense?.name ?? '',
                    hintText: 'Expense Name',
                    labelText: 'Name *',
                    onChange: (value) => widget.onChange('name', value),
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name for your expense';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OutlinedTextField(
                    initialValue:
                        widget.expense?.quantity.toStringAsFixed(2) ?? '0.00',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    hintText: 'Quantity of Expense',
                    labelText: 'Quantity *',
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a quantity for your expense';
                      }
                      if (!Utils.isCurrencyValid(value)) {
                        return 'Please enter a valid format for quantity of expense.';
                      }
                      widget.onChange('quantity', double.parse(value));
                      return null;
                    },
                  ),
                ),
                DropdownSearch<String>(
                  items: Provider.of<MaterialList>(context, listen: false)
                      .items
                      .map((mat) => mat.name)
                      .toList(),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Menu mode",
                      hintText: "country in menu mode",
                    ),
                  ),
                  onChanged: print,
                  selectedItem: Provider.of<MaterialList>(context,
                              listen: false)
                          .items
                          .where((mat) => mat.id == widget.expense!.materialId)
                          .isNotEmpty
                      ? Provider.of<MaterialList>(context, listen: false)
                          .items
                          .where((mat) => mat.id == widget.expense!.materialId)
                          .first
                          .name
                      : '',
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
