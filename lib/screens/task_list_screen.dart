import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // Memuat data task dari SharedPreferences
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      setState(() {
        tasks = List<Map<String, dynamic>>.from(jsonDecode(tasksString));
      });
    }
  }

  // Menyimpan data task ke SharedPreferences
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tasks', jsonEncode(tasks));
  }

  // Menambahkan task baru
  void _addTask(Map<String, dynamic> task) {
    setState(() {
      tasks.add(task);
    });
    _saveTasks();
  }

  // Menandai task sebagai selesai
  void _markAsDone(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        backgroundColor: Colors.green,
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Text(
                'Belum ada task. Tap "+" untuk menambahkan.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  color: _getCardColor(task['status']),
                  child: ListTile(
                    title: Text(task['title']),
                    subtitle: Text(
                      'Time: ${task['time']}\nStatus: ${task['status']}',
                    ),
                    onTap: () {
                      // Navigasi ke halaman detail
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailScreen(
                            title: task['title'],
                            time: task['time'],
                            description: task['description'],
                            status: task['status'],
                            taskSteps: task['taskSteps'],
                          ),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.check, color: _getStatusColor(task['status'])),
                      onPressed: () {
                        _markAsDone(index);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
          if (result != null && result is Map<String, dynamic>) {
            _addTask(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Helper method to get status color
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'urgent':
        return Colors.red.shade300;
      case 'pending':
        return Colors.yellow.shade300;
      case 'ongoing':
        return Colors.green.shade300;
      default:
        return Colors.grey.shade400;
    }
  }

  // Helper method to get card color
  Color _getCardColor(String status) {
    switch (status.toLowerCase()) {
      case 'urgent':
        return Colors.red.shade100;
      case 'pending':
        return Colors.yellow.shade100;
      case 'ongoing':
        return Colors.green.shade100;
      default:
        return Colors.grey.shade100;
    }
  }
}

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _taskStepsController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _selectedStatus = 'Urgent';
  final List<String> _statusOptions = ['Urgent', 'Pending', 'Ongoing'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
        title: const Text('Add Task'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _descriptionController,
              maxLines: 4, // Text area for description
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2025),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate != null
                          ? 'Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'
                          : 'Select Date',
                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  setState(() {
                    _selectedTime = pickedTime;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedTime != null
                          ? 'Time: ${_selectedTime!.format(context)}'
                          : 'Select Time',
                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const Icon(Icons.access_time, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField(
              value: _selectedStatus,
              items: _statusOptions.map((status) {
                return DropdownMenuItem(
                  child: Text(status),
                  value: status,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value as String;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _taskStepsController,
              decoration: const InputDecoration(
                labelText: 'Task Steps (comma separated)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final task = {
                  'title': _titleController.text,
                  'description': _descriptionController.text,
                  'time': _selectedDate != null
                      ? '${DateFormat('yyyy-MM-dd').format(_selectedDate!)} ${_selectedTime != null ? _selectedTime!.format(context) : ''}'
                      : '',
                  'status': _selectedStatus,
                  'taskSteps': _taskStepsController.text.split(',').map((step) => step.trim()).toList(),
                };
                Navigator.pop(context, task);
              },
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}

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
    required this.taskSteps });

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
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: _getStatusColor(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
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
        return Colors.yellow.shade300;
      case 'ongoing':
        return Colors.green.shade300;
      default:
        return Colors.grey.shade400;
    }
  }
}