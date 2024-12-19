import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart'; // Import library intl untuk format tanggal

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meeting App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MeetingScreen(),
    );
  }
}

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({super.key});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  List<Map<String, dynamic>> meetings = [];
  String _selectedDay = '';

  @override
  void initState() {
    super.initState();
    _loadMeetings();
  }

  // Memuat data meeting dari SharedPreferences
  Future<void> _loadMeetings() async {
    final prefs = await SharedPreferences.getInstance();
    final String? meetingsString = prefs.getString('meetings');
    if (meetingsString != null) {
      setState(() {
        meetings = List<Map<String, dynamic>>.from(jsonDecode(meetingsString));
        _selectedDay = meetings.first['time'].split(' ')[0];
      });
    }
  }

  // Menyimpan data meeting ke SharedPreferences
  Future<void> _saveMeetings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('meetings', jsonEncode(meetings));
  }

  // Menambahkan meeting baru
  void _addMeeting(Map<String, dynamic> meeting) {
    setState(() {
      meetings.add(meeting);
    });
    _saveMeetings();
  }

  // Menandai meeting sebagai selesai
  void _markAsDone(int index) {
    setState(() {
      meetings.removeAt(index);
    });
    _saveMeetings();
  }

  // Menghapus data meeting
  void _deleteMeeting() {
    setState(() {
      meetings = [];
    });
    _saveMeetings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meetings'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DropdownButtonFormField(
              value: _selectedDay,
              onChanged: (value) {
                setState(() {
                  _selectedDay = value as String;
                });
              },
              items: meetings.map((meeting) {
                return DropdownMenuItem(
                  child: Text(meeting['time'].split(' ')[0]),
                  value: meeting['time'].split(' ')[0],
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: meetings.isEmpty
                ? const Center(
                    child: Text(
                      'Belum ada meeting. Tap "+" untuk menambahkan.',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: meetings.length,
                    itemBuilder: (context, index) {
                      final meeting = meetings[index];
                      if (meeting['time'].split(' ')[0] == _selectedDay) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: ListTile(
                            title: Text(meeting['title']),
                            subtitle: Text(
                              'Time: ${meeting['time']}\nLocation: ${meeting['location']}',
                            ),
                            trailing: Checkbox(
                              value: meeting['done'],
                              onChanged: (value) {
                                setState(() {
                                  meetings[index]['done'] = value;
                                });
                                _saveMeetings();
                              },
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: _deleteMeeting,
              child: const Text('Hapus Data'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final DateTime now = DateTime.now();
          final String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMeetingScreen(formattedDate: formattedDate)),
          );
          if (result != null && result is Map<String, dynamic>) {
            _addMeeting(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddMeetingScreen extends StatefulWidget {
  final String formattedDate;

  const AddMeetingScreen({ required this.formattedDate, super.key});

  @override
  State<AddMeetingScreen> createState() => _AddMeetingScreenState();
}

class _AddMeetingScreenState extends State<AddMeetingScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = widget.formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Meeting'),
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
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _dateController,
              readOnly: true, // Disable manual input for date
              decoration: InputDecoration(
                labelText: 'Time (YYYY-MM-DD HH:MM)',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null) {
                      setState(() {
                        _dateController.text = DateFormat('yyyy-MM-dd HH:mm').format(picked);
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final meeting = {
                  'title': _titleController.text,
                  'description': _descriptionController.text,
                  'location': _locationController.text,
                  'time': _dateController.text,
                  'done': false, // Default value for the checkbox
                };
                Navigator.pop(context, meeting);
              },
              child: const Text('Add Meeting'),
            ),
          ],
        ),
      ),
    );
  }
}

class MeetingDetailScreen extends StatelessWidget {
  final Map<String, dynamic> meeting;

  const MeetingDetailScreen({required this.meeting, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meeting['title']),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meeting['title'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Time: ${meeting['time']}'),
            Text('Location: ${meeting['location']}'),
            const SizedBox(height: 10),
            Text('Description:'),
            Text(meeting['description'] ?? ''),
          ],
        ),
      ),
    );
  }
}