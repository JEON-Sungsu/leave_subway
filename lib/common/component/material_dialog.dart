import 'package:flutter/material.dart';
import 'package:leave_subway/common/const/color.dart';

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
          child: Text(
            actionButtonTitle,
            style: const TextStyle(
              color: PRIMARY_COLOR,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (hasCancelButton)
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text(
              '닫기',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          )
      ],
    );
  }
}
