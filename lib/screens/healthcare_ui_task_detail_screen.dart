
import 'package:flutter/material.dart';

class HealthcareUITaskDetailScreen extends StatelessWidget {
  const HealthcareUITaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthcare UI Design Task'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section with Icon
            Row(
              children: [
                Icon(Icons.health_and_safety, color: Colors.green, size: 30),
                const SizedBox(width: 10),
                Text(
                  'Healthcare UI Design',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Task Description Section
            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(10),
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
                    'Develop a user-friendly and accessible UI design tailored for healthcare applications, focusing on simplicity, clarity, and patient accessibility.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Task Details Section
            Text(
              'Task Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTaskDetailItem(
                   'Lakukan penelitian tentang tren UI terkini dalam aplikasi kesehatan untuk memastikan desain memenuhi standar industri dan meningkatkan pengalaman pengguna.'
                    ),
                  _buildTaskDetailItem(
                 'Kembangkan wireframe dan mockup fidelitas tinggi untuk portal pasien, termasuk layar untuk janji temu, resep, dan catatan medis.'
                  ),  
                  _buildTaskDetailItem(
                   'Fokus pada fitur aksesibilitas, seperti ukuran teks yang dapat disesuaikan dan opsi kontras, untuk memastikan UI dapat digunakan oleh pasien dengan kebutuhan beragam.'
                    ),
                  _buildTaskDetailItem(
                 'Bekerja sama dengan tim pengembangan untuk meninjau dan menyempurnakan desain berdasarkan umpan balik.'
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Additional Information
            _buildInfoRow(Icons.calendar_today, 'Deadline:', 'March 15, 2024'),
            _buildInfoRow(Icons.access_time, 'Time:', '03:00 - 05:00 PM'),
            _buildInfoRow(Icons.info, 'Status:', 'Pending', color: Colors.orange),
          ],
        ),
      ),
    );
  }

  // Helper method for task detail items
  Widget _buildTaskDetailItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
  Widget _buildInfoRow(IconData icon, String title, String value, {Color color = const Color.fromRGBO(255, 229, 115, 115)}) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }
}

