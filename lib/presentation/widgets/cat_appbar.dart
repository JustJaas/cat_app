import 'package:cats_app/config/app_config.dart';
import 'package:flutter/material.dart';

class CatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const CatAppBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppConfig.instance.colorAppBarLetter,
          fontSize: 25,
        ),
      ),
      backgroundColor: AppConfig.instance.getColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppConfig.instance.colorAppBarLetter),
    );
  }
}
