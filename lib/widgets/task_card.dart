import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String time;
  final String status;
  final VoidCallback? onTap;

  const TaskCard({super.key, 
    required this.title,
    required this.time,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(time),
        trailing: Text(
          status,
          style: TextStyle(
            color: status == 'Urgent' ? Colors.red : Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
