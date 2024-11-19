import 'package:creaphur/widgets/delete_dialog.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent deleteDialog = WidgetbookComponent(
  name: 'DeleteDialog',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => DeleteDialog(
          isIconButton: false,
          buttonText: '',
          model: '',
          onDelete: () {},
          isDeleteDisabled: false,
          confirmedWidgetPath: null),
    ),
  ],
);
