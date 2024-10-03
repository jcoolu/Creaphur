import 'package:creaphur/models/time_entry.dart';
import 'package:creaphur/widgets/calendar/yearly_calendar.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent yearlyCalendarComponent = WidgetbookComponent(
  name: 'YearlyCalendar',
  useCases: [
    WidgetbookUseCase(
      name: 'Display March 2024',
      builder: (context) => const YearlyCalendar(
        year: 2024,
        month: 3,
        timeEntries: [],
      ),
    ),
    WidgetbookUseCase(
      name: 'Display January 2023',
      builder: (context) => const YearlyCalendar(
        year: 2023,
        month: 1,
        timeEntries: [],
      ),
    ),
    WidgetbookUseCase(
      name: 'With time entry',
      builder: (context) => YearlyCalendar(
        year: 2023,
        month: 1,
        timeEntries: [
          TimeEntry(
              id: '1',
              name: 'Shaving fur',
              startDate: DateTime(2024, 1, 1, 9),
              endDate: DateTime(2024, 1, 1, 19),
              costOfServices: 60.50,
              projectId: '1',
              image: '',
              profileId: 'profileId')
        ],
      ),
    ),
  ],
);
