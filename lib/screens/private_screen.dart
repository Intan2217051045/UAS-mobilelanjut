import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Private Data',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const PrivateScreen(),
    );
  }
}

class PrivateScreen extends StatefulWidget {
  const PrivateScreen({super.key});

  @override
  State<PrivateScreen> createState() => _PrivateScreenState();
}

class _PrivateScreenState extends State<PrivateScreen> {
  List<Map<String, dynamic>> privateData = [];

  @override
  void initState() {
    super.initState();
    _loadPrivateData();
  }

  Future<void> _loadPrivateData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? privateDataString = prefs.getString('private_data');
    if (privateDataString != null) {
      setState(() {
        privateData = (jsonDecode(privateDataString) as List<dynamic>)
            .map((item) => item as Map<String, dynamic>)
            .toList();
      });
    }
  }

  Future<void> _savePrivateData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('private_data', jsonEncode(privateData));
  }

  void _addPrivateData(Map<String, dynamic> data) {
    setState(() {
      privateData.add(data);
    });
    _savePrivateData();
  }

  void _deletePrivateData(int index) {
    setState(() {
      privateData.removeAt(index);
    });
    _savePrivateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Private Data'),
        backgroundColor: Colors.green,
      ),
      body: privateData.isEmpty
          ? const Center(
              child: Text(
                'No private data yet. Tap "+" to add one.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: privateData.length,
              itemBuilder: (context, index) {
                final data = privateData[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    title: Text(data['title']),
                    subtitle: Text(
                      'Time: ${data['time']}\nLocation: ${data['location']}',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrivateDataDetailScreen(
                            data: data,
                          ),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deletePrivateData(index);
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
            MaterialPageRoute(builder: (context) => const AddPrivateDataScreen()),
          );
          if (result != null && result is Map<String, dynamic>) {
            _addPrivateData(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddPrivateDataScreen extends StatefulWidget {
  const AddPrivateDataScreen({super.key});

  @override
  State<AddPrivateDataScreen> createState() => _AddPrivateDataScreenState();
}

class _AddPrivateDataScreenState extends State<AddPrivateDataScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Private Data'),
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
              maxLines: 4,
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
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: 'Time (YYYY-MM-DD HH:MM)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final data = {
                  'title': _titleController.text,
                  'description': _descriptionController.text,
                  'location': _locationController.text,
                  'time': _timeController.text,
                };
                Navigator.pop(context, data);
              },
              child: const Text('Add Data'),
            ),
          ],
        ),
      ),
    );
  }
}

class PrivateDataDetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const PrivateDataDetailScreen({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['title']),
        backgroundColor: Colors.green.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data['title'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Time: ${data['time']}'),
            Text('Location: ${data['location']}'),
            const SizedBox(height: 10),
            const Text('Description:'),
            Text(data['description'] ?? ''),
          ],
        ),
      ),
    );
  }
}
