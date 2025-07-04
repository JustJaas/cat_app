import 'package:cats_app/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class DetailInfo extends StatelessWidget {
  final String title;
  final String text;

  const DetailInfo({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(text: title),
            TextWidget(text: text),
          ],
        ),
      ],
    );
  }
}
