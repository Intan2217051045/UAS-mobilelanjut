import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String taskCount;
  final Image? image;
  final IconData? icon;
  final VoidCallback? onTap;

  const CategoryCard({super.key, 
    required this.title,
    required this.taskCount,
    this.image,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null) image!,
            if (icon != null) Icon(icon, size: 40),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (taskCount.isNotEmpty)
              Text(
                taskCount,
                style: const TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
