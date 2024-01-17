import 'package:flutter/material.dart';

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

  Map<String, String> exerciseEmojis = {
    'Running': '🏃',
    'Cycling': '🚴',
    'Weightlifting': '🏋️',
    'Swimming': '🏊',
    'Yoga': '🧘',
    'Jumping Jacks': '❤️‍🔥',
    'Squats': '🏋️‍♂️',
    'Push-ups': '🤸',
  };

  @override
  void initState() {
    super.initState();
    workoutLog.addAll([
      {
        'exercise': 'Running',
        'quantity': '30 minutes',
        'datetime': DateTime.now().subtract(const Duration(days: 1)),
      },
      {
        'exercise': 'Weightlifting',
        'quantity': '3 sets of 10 reps',
        'datetime': DateTime.now().subtract(const Duration(days: 2)),
      },
    ]);
  }

  void recordWorkout() {
    String quantity = quantityController.text;
    quantityController.clear();

    setState(() {
      workoutLog.add({
        'exercise': selectedExercise,
        'quantity': quantity,
        'datetime': DateTime.now(),
      });
    });

    print(
        'Workout Recorded: Exercise: $selectedExercise, Quantity: $quantity, Datetime: ${DateTime.now()}');
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
          const SizedBox(height: 16.0),
          TextField(
            controller: quantityController,
            decoration: const InputDecoration(labelText: 'Quantity'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              recordWorkout();
            },
            child: const Text('Record Workout'),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: WorkoutLog(workoutLog, exerciseEmojis),
          ),
        ],
      ),
    );
  }
}

class WorkoutLog extends StatelessWidget {
  final List<Map<String, dynamic>> workoutLog;
  final Map<String, String> exerciseEmojis;

  WorkoutLog(this.workoutLog, this.exerciseEmojis);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: workoutLog.length,
      itemBuilder: (context, index) {
        final exercise = workoutLog[index]['exercise'];
        final quantity = workoutLog[index]['quantity'];
        final datetime = workoutLog[index]['datetime'];

        return WorkoutCard(
          exercise: exercise,
          quantity: quantity,
          datetime: datetime,
          emoji: exerciseEmojis[exercise] ?? 'Not Found',
        );
      },
    );
  }
}

class WorkoutCard extends StatelessWidget {
  final String exercise;
  final String quantity;
  final DateTime datetime;
  final String emoji;

  WorkoutCard({
    required this.exercise,
    required this.quantity,
    required this.datetime,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Exercise: $exercise $emoji',
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quantity: $quantity',
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Date and Time: ${datetime.toString()}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
