// Widgetbook file: widgetbook.dart
import 'package:creaphur/widgets/date_time_picker_widgetbook.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [],
      directories: [
        dateTimePicker,
      ],
    );
  }
}
