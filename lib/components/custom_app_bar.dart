import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0, // Remove the shadow
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text(
        'Breshop', // Customize the title
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications), // Add notification icon
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart), // Add shopping cart icon
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
