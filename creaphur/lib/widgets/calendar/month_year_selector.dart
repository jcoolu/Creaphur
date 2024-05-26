import 'package:flutter/material.dart';

class MonthYearSelector extends StatelessWidget {
  final int month; // 0-based index for month
  final int year;
  final Function(int, int) onChanged;

  MonthYearSelector({
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
            child: DropdownButton<int>(
              value: month,
              items: _months.asMap().entries.map((entry) {
                int index = entry.key;
                String month = entry.value;
                return DropdownMenuItem<int>(
                  value: index + 1,
                  child:
                      Text(month, style: const TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (int? newIndex) {
                onChanged(newIndex!, year);
              },
              isExpanded: true,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: DropdownButton<int>(
              value: year,
              items: _getYears().map((year) {
                return DropdownMenuItem<int>(
                  value: year,
                  child: Text(year.toString(),
                      style: TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (int? newYear) {
                onChanged(month, newYear!);
              },
              isExpanded: true,
            ),
          ),
        ],
      ),
    );
  }
}
