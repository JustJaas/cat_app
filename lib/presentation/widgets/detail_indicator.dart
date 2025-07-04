import 'package:cats_app/config/app_config.dart';
import 'package:cats_app/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class DetailIndicator extends StatelessWidget {
  final String title;
  final int value;

  const DetailIndicator({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    const int maxCircles = 5;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(text: title),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(maxCircles, (index) {
                  bool isFilled = index < value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isFilled
                            ? AppConfig.instance.colorPrimary
                            : AppConfig.instance.colorQuaternary,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
        Divider(thickness: 0.2),
      ],
    );
  }
}
