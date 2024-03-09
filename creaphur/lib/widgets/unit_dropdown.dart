import 'package:flutter/material.dart';

final Map<String, List<String>> items = {
  "Length": ["Yard", "Meter", "Inch", "Foot", "Centimeter", "Millimeter"],
  "Weight": ["Ounce", "Gram", "Pound"],
  "Volume": [
    "Drop",
    "Teaspoon",
    "Tablespoon",
    "Fluid Ounce",
    "Cup",
    "Pint",
    "Quart",
    "Gallon",
    "Milliliter",
    "Liter"
  ],
  "Yarn Specific": ["Ball", "Skein", "Cake", "Hank"],
  "Fabric Specific": [
    "Bolt",
    "Fat Quarter",
    "Square Yard",
    "Square Meter",
  ],
  "Paper Specific": ["Sheet", "Ream", "Pad", "Square Inch", "Square Foot"],
  "Flower Specific": ["Bunch", "Stem Length"],
  "Count": ["Each", "Dozen", "Gross"],
  "Thread/Beading Specific": ["Thread Count", "Gauge"]
};

class UnitDropdown extends StatelessWidget {
  final String? initialValue;
  final void Function(String?)? onChange;

  const UnitDropdown({
    super.key,
    required this.initialValue,
    required this.onChange,
  });

  List<DropdownMenuItem<String>> returnDropdownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    items.forEach((groupName, unitList) {
      // Add the disabled group name item
      dropdownItems.add(DropdownMenuItem<String>(
        value: null,
        child: GestureDetector(
          onTap: () {
            // Do nothing when tapped (making it non-clickable)
          },
          child: Text(
            groupName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ));

      // Add clickable unit items
      dropdownItems.addAll(unitList.map((unit) {
        return DropdownMenuItem<String>(
          value: unit,
          child: Text(unit),
        );
      }));
    });
    return dropdownItems;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: initialValue ?? 'Each',
        items: returnDropdownItems(),
        onChanged: onChange);
  }
}
