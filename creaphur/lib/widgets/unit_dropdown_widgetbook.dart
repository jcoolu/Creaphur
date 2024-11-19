import 'package:creaphur/widgets/unit_dropdown.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent unitDropdown = WidgetbookComponent(
  name: 'UnitDropdown',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => const UnitDropdown(),
    ),
    WidgetbookUseCase(
      name: 'With empty function',
      builder: (context) => UnitDropdown(onChange: (val) {}),
    ),
    WidgetbookUseCase(
      name: 'With initial value set & empty function',
      builder: (context) =>
          UnitDropdown(initialValue: 'Sheet', onChange: (val) {}),
    ),
  ],
);
