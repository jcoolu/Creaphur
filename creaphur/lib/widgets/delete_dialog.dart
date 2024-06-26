import 'package:creaphur/widgets/filled_action_button.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final bool isIconButton;
  final String buttonText;
  final String model;
  final void Function()? onDelete;
  final bool isDeleteDisabled;
  final Widget confirmedWidgetPath;

  const DeleteDialog({
    super.key,
    required this.isIconButton,
    required this.buttonText,
    required this.model,
    required this.onDelete,
    required this.isDeleteDisabled,
    required this.confirmedWidgetPath,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> showDeleteDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xffad99ff),
            titleTextStyle: const TextStyle(color: Colors.white),
            contentTextStyle: const TextStyle(color: Colors.white),
            icon: const Icon(Icons.warning, color: Color(0xff2900cc)),
            title: const Text('Are you sure?'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure you would like to delete this $model?'),
                  const Text('This action cannot be undone.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FilledActionButton(
                buttonText: 'Confirm',
                onPressed: () {
                  if (onDelete != null) {
                    onDelete!();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => confirmedWidgetPath),
                    );
                  }
                },
              ),
            ],
          );
        },
      );
    }

    if (isIconButton) {
      return IconButton(
          onPressed: isDeleteDisabled ? null : showDeleteDialog,
          icon: const Icon(Icons.delete, color: Colors.white));
    }
    return TextButton(onPressed: showDeleteDialog, child: Text(buttonText));
  }
}
