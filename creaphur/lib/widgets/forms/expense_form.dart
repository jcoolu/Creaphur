import 'package:creaphur/common/form_utils.dart';
import 'package:creaphur/models/expense.dart';
import 'package:creaphur/models/material_list.dart';
import 'package:creaphur/screens/dashboard/main.dart';
import 'package:creaphur/widgets/filled_action_button.dart';
import 'package:creaphur/widgets/outlined_text_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

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
    MaterialList list = Provider.of<MaterialList>(context, listen: false);
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
                    maxLines: 1,
                    onChange: (value) => widget.onChange('name', value),
                    onValidate: (String? value) =>
                        FormUtils.onValidateBasicString(
                            value, 'Please enter a name for your expense'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DropdownSearch<String>(
                      items: [
                        ...list.items.map((mat) => mat.name).toList(),
                        ...['None']
                      ],
                      selectedItem: widget.expense!.materialId == 'None'
                          ? 'None'
                          : list.getRelatedMaterialName(
                              widget.expense!.materialId),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Material",
                          hintText: "Material related to expense for project.",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                        ),
                      ),
                      onChanged: (String? val) => widget.onChange(
                          'materialId', list.getRelatedIdOfMaterial(val!))),
                ),
                if (widget.expense!.materialId.isNotEmpty &&
                    widget.expense!.materialId != 'None')
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: OutlinedTextField(
                      initialValue:
                          widget.expense?.quantity.toStringAsFixed(2) ?? '0.00',
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      maxLines: 1,
                      suffix: widget.expense!.getMaterialQuantityType(context),
                      hintText: 'Quantity of Expense',
                      labelText: 'Quantity *',
                      onValidate: (value) => FormUtils.onValidateQuantity(value,
                          'quantity', 'expense', widget.onChange, 'quantity'),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}')),
                      ],
                    ),
                  ),
                if (widget.expense!.materialId == 'None')
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: OutlinedTextField(
                      initialValue:
                          widget.expense?.customCost.toStringAsFixed(2) ??
                              '0.00',
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      hintText: 'Total Cost for Expense',
                      labelText: 'Cost *',
                      maxLines: 1,
                      onValidate: (value) => FormUtils.onValidateCurrency(value,
                          'cost', 'expense', widget.onChange, 'customCost'),
                      prefix: '\$',
                    ),
                  ),
                if (list.items.isEmpty)
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text:
                              'You have no materials listed in your account. Please go to the ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Materials screen',
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Dashboard(
                                        previousState: 'materials')),
                              );
                            },
                        ),
                        const TextSpan(
                          text:
                              ' and create at least one material to assign to this expense.',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
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
