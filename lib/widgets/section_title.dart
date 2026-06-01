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
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 0,
      ),
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