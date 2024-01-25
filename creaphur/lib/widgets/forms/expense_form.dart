import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/expense.dart';
import 'package:creaphur/models/material_list.dart';
import 'package:creaphur/widgets/filled_action_button.dart';
import 'package:creaphur/widgets/outlined_text_field.dart';
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
                      if (!Utils.isQuantityValid(value)) {
                        return 'Please enter a valid format for quantity of expense.';
                      }
                      widget.onChange('quantity', double.parse(value));
                      return null;
                    },
                  ),
                ),
                DropdownSearch<DropdownMenuItem>(
                  items: Provider.of<MaterialList>(context, listen: false)
                      .items
                      .map((mat) => DropdownMenuItem(
                          value: mat.id, child: Text(mat.name)))
                      .toList(),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Material",
                      hintText: "Material related to expense for project.",
                    ),
                  ),
                  selectedItem: DropdownMenuItem(
                    value: widget.expense?.materialId,
                    child: Text(widget.expense!.materialId),
                  ),
                  onChanged: (DropdownMenuItem? val) =>
                      widget.onChange('materialId', val!.value),
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
