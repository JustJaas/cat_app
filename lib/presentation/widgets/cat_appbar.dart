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
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 25,
        ),
      ),
      backgroundColor: Colors.orange,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
