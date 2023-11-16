import 'package:creaphur/widgets/date_time_picker.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent dateTimePicker = WidgetbookComponent(
  name: 'DateTimePicker',
  useCases: [
    WidgetbookUseCase(
      name: 'For Prospected date',
      builder: (context) => DateTimePicker(
          dateTime: DateTime.now(), onChange: () {}, buttonText: 'Prospected'),
    ),
  ],
);
