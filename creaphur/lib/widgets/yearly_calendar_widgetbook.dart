import 'package:creaphur/widgets/yearly_calendar.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent yearlyCalendarComponent = WidgetbookComponent(
  name: 'YearlyCalendar',
  useCases: [
    WidgetbookUseCase(
      name: 'Display 2024',
      builder: (context) => YearlyCalendar(year: 2024),
    ),
  ],
);
