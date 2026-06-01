import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget{
  final String title;
  final String? actionText;
  const SectionTitle({
    super.key,
    required this.title,
    this.actionText
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          actionText != null
              ? TextButton(onPressed: () {}, child: Text(actionText!))
              : SizedBox.shrink()

        ],
      ),
    );
  }

}