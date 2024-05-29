import 'package:creaphur/widgets/calendar/main.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent calendarComponent = WidgetbookComponent(
  name: 'Calendar',
  useCases: [
    WidgetbookUseCase(
      name: 'Display March 2024',
      builder: (context) => Calendar(
        month: DateTime.now().month,
        year: DateTime.now().year,
        timeEntries: const [],
        onChange: (m, y) {},
      ),
    ),
  ],
);
