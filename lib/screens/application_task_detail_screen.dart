
import 'package:flutter/material.dart';

class ApplicationTaskDetailScreen extends StatelessWidget {
  const ApplicationTaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Design Task'),
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
                Icon(Icons.design_services, color: Colors.green, size: 30),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Application Design',
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

            // Objective Section
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
                    'Design a visually appealing and intuitive application interface that enhances user experience and aligns with brand aesthetics.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Task Details Section
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
                    'Lakukan riset pengguna untuk mengumpulkan wawasan tentang kegunaan aplikasi dan fitur-fitur yang menarik bagi pengguna.',
                  ),
                  _buildTaskDetailItem(
                    'Buat wireframe dan prototipe untuk antarmuka aplikasi dengan fokus pada alur pengguna yang mulus.',
                  ),
                  _buildTaskDetailItem(
                    'Integrasikan umpan balik dari pengujian kegunaan dan lakukan iterasi pada elemen desain.',
                  ),
                  _buildTaskDetailItem(
                    'Bekerja sama dengan pengembang untuk memastikan konsistensi desain di seluruh aplikasi.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Additional Information
            _buildInfoRow(Icons.calendar_today, 'Deadline:', 'March 10, 2024'),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.access_time, 'Time:', '9:00 - 11:30 AM'),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.info, 'Status:', 'Pending', color: Colors.orange),
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
  Widget _buildInfoRow(IconData icon, String title, String value, {Color color = Colors.green}) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
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
