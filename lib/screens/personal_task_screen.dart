import 'package:flutter/material.dart';

class PersonalTaskScreen extends StatelessWidget {
  final String title;
  final String description;

  const PersonalTaskScreen({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section with Icon
            Row(
              children: [
                Icon(Icons.phone_android, color: Colors.green, size: 30),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Objective Section with subtle background color
            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Objective',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create a visually engaging and user-friendly app design focusing on personal tasks, interaction, and functionality.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Task Details Section with shadow effect
            Text(
              'Task Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTaskDetailItem(
                    'Analyze current app design trends to integrate modern design elements.',
                  ),
                  _buildTaskDetailItem(
                    'Create wireframes and prototypes for user flow, focusing on smooth interaction.',
                  ),
                  _buildTaskDetailItem(
                    'Conduct usability testing to gather feedback on design effectiveness and improvements.',
                  ),
                  _buildTaskDetailItem(
                    'Collaborate with the development team to ensure design consistency across screens.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Additional Information
            _buildInfoRow(Icons.calendar_today, 'Deadline:', 'March 5, 2024'),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.access_time, 'Time:', '8:00 - 11:00 AM'),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.warning, 'Status:', 'Urgent',
                color: const Color.fromRGBO(255, 229, 115, 115)),
          ],
        ),
      ),
    );
  }

  // Helper method for task detail items
  Widget _buildTaskDetailItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 20),
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

  // Helper method for displaying information rows
  Widget _buildInfoRow(IconData icon, String title, String value,
      {Color color = Colors.green}) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800]),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}
