
import 'package:flutter/material.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  // Status ceklis untuk setiap tugas
  final List<bool> _taskCompletionStatus = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Design'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Task Detail', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                CircleAvatar(radius: 20, backgroundColor: Colors.green.shade100, child: const Text('A')),
                const SizedBox(width: 10),
                CircleAvatar(radius: 20, backgroundColor: Colors.green.shade100, child: const Text('B')),
                const SizedBox(width: 10),
                CircleAvatar(radius: 20, backgroundColor: Colors.green.shade100, child: const Text('C')),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Due Date: Oct 30, 2020',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tasks',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Tugas 1
            CheckboxListTile(
              title: const Text('Create user flow'),
              value: _taskCompletionStatus[0],
              onChanged: (bool? value) {
                setState(() {
                  _taskCompletionStatus[0] = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.green,
            ),
            // Tugas 2
            CheckboxListTile(
              title: const Text('Create onboarding page'),
              value: _taskCompletionStatus[1],
              onChanged: (bool? value) {
                setState(() {
                  _taskCompletionStatus[1] = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.green,
            ),
            // Tugas 3
            CheckboxListTile(
              title: const Text('Buat Desain'),
              value: _taskCompletionStatus[2],
              onChanged: (bool? value) {
                setState(() {
                  _taskCompletionStatus[2] = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
