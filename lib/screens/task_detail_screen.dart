import 'package:flutter/material.dart';

class TaskDetailScreen extends StatelessWidget {
  final String title;
  final String time;
  final String description;
  final String status;
  final List<String> taskSteps;

  const TaskDetailScreen({
    super.key,
    required this.title,
    required this.time,
    required this.description,
    required this.status,
    required this.taskSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.red.shade300,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            Text(
              title,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade300,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              time,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),

            // Description Section
            Text(
              'Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade300,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            const SizedBox(height: 24),

            // Status Section
            Row(
              children: [
                Icon(
                  Icons.info,
                  color: _getStatusColor(),
                  size: 24,
                ),
                const SizedBox(width: 10),
                Text(
                  'Status: ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 16,
                    color: _getStatusColor(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Task Steps Section
            Text(
              'Task Steps',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade300,
              ),
            ),
            const SizedBox(height: 12),
            ...taskSteps.map((step) => _buildTaskStep(step)).toList(),
          ],
        ),
      ),
    );
  }

  // Helper method for task steps
  Widget _buildTaskStep(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.red.shade300, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get status color
  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'urgent':
        return Colors.red.shade300;
      case 'pending':
        return Colors.orange.shade300;
      case 'ongoing':
        return Colors.blue.shade300;
      default:
        return Colors.grey.shade400;
    }
  }
}
