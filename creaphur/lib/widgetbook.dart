// Widgetbook file: widgetbook.dart
import 'package:creaphur/widgets/calendar/calendar_widgetbook.dart';
import 'package:creaphur/widgets/date_time_picker_widgetbook.dart';
import 'package:creaphur/widgets/delete_dialog_widgetbook.dart';
import 'package:creaphur/widgets/filled_action_button_widgetbook.dart';
import 'package:creaphur/widgets/project_summary_card_widgetbook.dart';
import 'package:creaphur/widgets/calendar/yearly_calendar_widgetbook.dart';
import 'package:creaphur/widgets/unit_dropdown_widgetbook.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:creaphur/widgets/ko_fi_widgetbook.dart';

void main() {
  runApp(const HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: const [],
      directories: [
        dateTimePicker,
        deleteDialog,
        filledActionButton,
        projectSummaryCard,
        yearlyCalendarComponent,
        calendarComponent,
        kofiWidget,
        unitDropdown,
      ],
    );
  }
}
