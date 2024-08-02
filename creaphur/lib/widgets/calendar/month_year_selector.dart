import 'package:creaphur/widgets/outlined_dropdown.dart';
import 'package:flutter/material.dart';

class MonthYearSelector extends StatelessWidget {
  final int month; // 0-based index for month
  final int year;
  final Function(int, int) onChanged;

  MonthYearSelector({
    super.key,
    required this.month,
    required this.year,
    required this.onChanged,
  });

  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  List<int> _getYears() {
    int currentYear = DateTime.now().year;
    return List.generate(100, (index) => currentYear - index); // Past 100 years
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedDropdown(
              initialValue: month,
              items: _months.asMap().entries.map((entry) {
                int index = entry.key;
                String month = entry.value;
                return DropdownMenuItem<int>(
                  value: index + 1,
                  child:
                      Text(month, style: const TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChange: (newIndex) {
                onChanged(newIndex!, year);
              },
              width: double.infinity,
              height: 56,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: OutlinedDropdown(
                initialValue: year,
                items: _getYears().map((year) {
                  return DropdownMenuItem<int>(
                    value: year,
                    child: Text(year.toString(),
                        style: const TextStyle(color: Colors.black)),
                  );
                }).toList(),
                onChange: (newYear) {
                  onChanged(month, newYear!);
                },
                width: double.infinity,
                height: 56),
          ),
        ],
      ),
    );
  }
}
