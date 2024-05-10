import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoDialog extends StatelessWidget {
  final String title;
  final String content;
  final bool hasCancelButton;
  final String actionButtonTitle;
  final VoidCallback onPressAction;

  const CupertinoDialog({
    super.key,
    required this.title,
    required this.content,
    required this.hasCancelButton,
    required this.actionButtonTitle,
    required this.onPressAction,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: onPressAction,
          child: Text(actionButtonTitle, style: const TextStyle(color: Colors.blue),),
        ),
        if(hasCancelButton)
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('닫기'),
          ),
      ],
    );
  }
}
