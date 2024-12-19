
import 'package:flutter/material.dart';
import 'package:myapp/screens/event_screen.dart';
import 'package:myapp/screens/meeting_screen.dart';
import 'package:myapp/screens/private_screen.dart';
import '../widgets/category_card.dart';
import 'task_list_screen.dart';
import 'create_task_screen.dart'; 

class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Board'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            CategoryCard(
              title: 'Personal',
              taskCount: '5 Tasks',
              image: Image.asset(
                'assets/images/personal.jpg',
                width: 40,
                height: 40,
              ),
                onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TaskListScreen()),
                );
              },
            ),
            CategoryCard(
              title: 'Work',
              taskCount: '10 Tasks',
              image: Image.asset(
                'assets/images/work.jpg',
                width: 40,
                height: 40,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TaskListScreen()),
                );
              },
            ),
            CategoryCard(
              title: 'Private',
              taskCount: '2 Tasks',
              image: Image.asset(
                'assets/images/private.jpg',
                width: 40,
                height: 40,
              ),
               onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PrivateScreen()),
                );
              },
            ),
            CategoryCard(
              title: 'Meeting',
              taskCount: '8 Tasks',
              image: Image.asset(
                'assets/images/meeting.jpg',
                width: 40,
                height: 40,
              ),
               onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MeetingScreen()),
                );
              },
            ),
            CategoryCard(
              title: 'Events',
              taskCount: '3 Tasks',
              image: Image.asset(
                'assets/images/events.jpg',
                width: 40,
                height: 40,
              ),
               onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EventScreen()),
                );
              },
            ),
            CategoryCard(
              title: 'Create Board',
              taskCount: '',
              icon: Icons.add,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateTaskScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
