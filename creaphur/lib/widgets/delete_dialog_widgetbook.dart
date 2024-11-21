import 'package:creaphur/widgets/delete_dialog.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent deleteDialog = WidgetbookComponent(
  name: 'DeleteDialog',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => DeleteDialog(
          isIconButton: false,
          buttonText: 'Delete',
          model: 'item',
          onDelete: () {},
          isDeleteDisabled: false,
          confirmedWidgetPath: null),
    ),
    WidgetbookUseCase(
      name: 'Icon Button',
      builder: (context) => DeleteDialog(
          isIconButton: true,
          buttonText: '',
          model: 'icon button',
          onDelete: () {},
          isDeleteDisabled: false,
          confirmedWidgetPath: null),
    ),
    WidgetbookUseCase(
      name: 'Disabled',
      builder: (context) => DeleteDialog(
          isIconButton: true,
          buttonText: 'Delete Disabled',
          model: '',
          onDelete: () {},
          isDeleteDisabled: true,
          confirmedWidgetPath: null),
    ),
  ],
);
