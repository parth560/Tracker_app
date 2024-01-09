import 'package:flutter/material.dart';

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

class MultiRecorderApp extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Tracker'),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          EmotionRecorder(),
          DietRecorder(),
          WorkoutRecorder(),
        ],
      ),
    );
  }
}

class EmotionRecorder extends StatefulWidget {
  @override
  _EmotionRecorderState createState() => _EmotionRecorderState();
}

class _EmotionRecorderState extends State<EmotionRecorder> {
  List<Map<String, dynamic>> emotionLog = [];

  void recordEmotion(String emoji) {
    setState(() {
      emotionLog.add({
        'emoji': emoji,
        'datetime': DateTime.now(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _EmotionSelector(recordEmotion),
        Expanded(
          child: EmotionLog(emotionLog),
        ),
      ],
    );
  }
}

class _EmotionSelector extends StatelessWidget {
  final Function(String) onEmotionSelected;

  _EmotionSelector(this.onEmotionSelected);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        children: List.generate(
          24,
          (index) => GestureDetector(
            onTap: () =>
                onEmotionSelected(String.fromCharCodes([0x1F600 + index])),
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                String.fromCharCodes([0x1F600 + index]),
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmotionLog extends StatelessWidget {
  final List<Map<String, dynamic>> emotionLog;

  EmotionLog(this.emotionLog);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: emotionLog.length,
      itemBuilder: (context, index) {
        final emoji = emotionLog[index]['emoji'];
        final datetime = emotionLog[index]['datetime'];

        return ListTile(
          title: Text('$emoji   ${datetime.toString()}'),
        );
      },
    );
  }
}

class DietRecorder extends StatefulWidget {
  @override
  _DietRecorderState createState() => _DietRecorderState();
}

class _DietRecorderState extends State<DietRecorder> {
  List<Map<String, dynamic>> dietLog = [];
  final TextEditingController foodController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  void recordDiet(String food, String quantity) {
    setState(() {
      dietLog.add({
        'food': food,
        'quantity': quantity,
        'datetime': DateTime.now(),
      });
      // Clear the text controllers after recording
      foodController.clear();
      quantityController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: foodController,
            decoration: InputDecoration(labelText: 'Food'),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: quantityController,
            decoration: InputDecoration(labelText: 'Quantity'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              recordDiet(foodController.text, quantityController.text);
            },
            child: Text('Record Diet'),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: DietLog(dietLog),
          ),
        ],
      ),
    );
  }
}

class DietLog extends StatelessWidget {
  final List<Map<String, dynamic>> dietLog;

  DietLog(this.dietLog);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dietLog.length,
      itemBuilder: (context, index) {
        final food = dietLog[index]['food'];
        final quantity = dietLog[index]['quantity'];
        final datetime = dietLog[index]['datetime'];

        return ListTile(
          title: Text('$food   $quantity   ${datetime.toString()}'),
        );
      },
    );
  }
}

class WorkoutRecorder extends StatefulWidget {
  @override
  _WorkoutRecorderState createState() => _WorkoutRecorderState();
}

class _WorkoutRecorderState extends State<WorkoutRecorder> {
  List<Map<String, dynamic>> workoutLog = [];
  final TextEditingController quantityController = TextEditingController();

  List<String> exercises = [
    'Running',
    'Cycling',
    'Weightlifting',
    'Swimming',
    'Yoga',
    'Jumping Jacks',
    'Squats',
    'Push-ups',
  ];

  String selectedExercise = 'Running';

  void recordWorkout() {
    setState(() {
      workoutLog.add({
        'exercise': selectedExercise,
        'quantity': quantityController.text,
        'datetime': DateTime.now(),
      });
      // Clear the text controller after recording
      quantityController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          DropdownButton<String>(
            value: selectedExercise,
            items: exercises.map((String exercise) {
              return DropdownMenuItem<String>(
                value: exercise,
                child: Text(exercise),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedExercise = newValue;
                });
              }
            },
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: quantityController,
            decoration: InputDecoration(labelText: 'Quantity'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              recordWorkout();
            },
            child: Text('Record Workout'),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: WorkoutLog(workoutLog),
          ),
        ],
      ),
    );
  }
}

class WorkoutLog extends StatelessWidget {
  final List<Map<String, dynamic>> workoutLog;

  WorkoutLog(this.workoutLog);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: workoutLog.length,
      itemBuilder: (context, index) {
        final exercise = workoutLog[index]['exercise'];
        final quantity = workoutLog[index]['quantity'];
        final datetime = workoutLog[index]['datetime'];

        return ListTile(
          title: Text('$exercise   $quantity   ${datetime.toString()}'),
        );
      },
    );
  }
}
