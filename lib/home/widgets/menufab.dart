import 'package:flutter/material.dart';

class MenuFab extends StatelessWidget {
  final VoidCallback onPressed;

  const MenuFab({super.key, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      // backgroundColor: Colors.green[200],
      mini: true,
      elevation: 3.0,

      onPressed: onPressed,
      // backgroundColor: Colors.green[200],
      child: const Icon(
        Icons.menu,
        size: 26.0,
        color: Colors.white70,
      ),
    );
  }
}
