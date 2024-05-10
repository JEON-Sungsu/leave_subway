import 'package:flutter/material.dart';

class MaterialDialog extends StatelessWidget {
  final String title;
  final String content;
  final bool hasCancelButton;
  final String actionButtonTitle;
  final VoidCallback onPressAction;

  const MaterialDialog({
    super.key,
    required this.title,
    required this.content,
    required this.hasCancelButton,
    required this.actionButtonTitle,
    required this.onPressAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: onPressAction,
          child: Text(actionButtonTitle),
        ),
        if (hasCancelButton)
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('닫기'),
          )
      ],
    );
  }
}
