// import 'package:flutter/material.dart';
// import 'task.dart';

// class AddTaskScreen extends StatefulWidget {
//   @override
//   _AddTaskScreenState createState() => _AddTaskScreenState();
// }

// class _AddTaskScreenState extends State<AddTaskScreen> {
//   final _nameController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   String _category = 'Work';
//   DateTime _dueDate = DateTime.now();
//   bool _isCompleted = false;

//   final List<String> categories = ['Work', 'Personal', 'Study', 'Shopping'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Task'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Task Name'),
//             ),
//             TextField(
//               controller: _descriptionController,
//               decoration: InputDecoration(labelText: 'Description'),
//             ),
//             DropdownButton<String>(
//               value: _category,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   _category = newValue!;
//                 });
//               },
//               items: categories.map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//             ListTile(
//               title: Text('Due Date: ${_dueDate.toLocal()}'.split(' ')[0]),
//               trailing: Icon(Icons.calendar_today),
//               onTap: () async {
//                 DateTime? picked = await showDatePicker(
//                   context: context,
//                   initialDate: _dueDate,
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2101),
//                 );
//                 if (picked != null && picked != _dueDate) {
//                   setState(() {
//                     _dueDate = picked;
//                   });
//                 }
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final task = Task(
//                   name: _nameController.text,
//                   description: _descriptionController.text,
//                   category: _category,
//                   dueDate: _dueDate,
//                   isCompleted: _isCompleted,
//                 );
//                 Navigator.pop(context, task);
//               },
//               child: Text('Add Task'),
//               style: ElevatedButton.styleFrom(primary: Colors.blue),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
