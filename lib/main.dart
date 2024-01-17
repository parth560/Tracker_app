import 'package:flutter/material.dart';
import 'emotion_recorder.dart';
import 'diet_recorder.dart';
import 'workout_recorder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiRecorderApp(),
    );
  }
}

class MultiRecorderApp extends StatefulWidget {
  @override
  _MultiRecorderAppState createState() => _MultiRecorderAppState();
}

class _MultiRecorderAppState extends State<MultiRecorderApp> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Tracker'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 150, 196, 226),
        child: PageView(
          controller: _pageController,
          children: [
            EmotionRecorder(),
            const DietRecorder(),
            WorkoutRecorder(),
          ],
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.mood),
            label: 'Emotion',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Diet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workout',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        },
      ),
    );
  }
}
