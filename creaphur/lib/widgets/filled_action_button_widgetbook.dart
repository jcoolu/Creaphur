import 'package:creaphur/widgets/delete_dialog.dart';
import 'package:creaphur/widgets/filled_action_button.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent filledActionButton = WidgetbookComponent(
  name: 'FilledActionButton',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => const FilledActionButton(
        buttonText: 'Default',
      ),
    ),
  ],
);
