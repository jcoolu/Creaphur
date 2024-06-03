import 'package:creaphur/widgets/ko_fi.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent kofiWidget = WidgetbookComponent(
  name: 'Ko-Fi',
  useCases: [
    WidgetbookUseCase(
      name: 'Widget',
      builder: (context) => const KoFi(),
    ),
  ],
);
