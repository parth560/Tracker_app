import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Diet Recorder'),
        ),
        body: DietRecorder(),
      ),
    );
  }
}

class DietRecorder extends StatefulWidget {
  const DietRecorder({Key? key}) : super(key: key);

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

      print(
          'Diet recorded - Food: $food, Quantity: $quantity, DateTime: ${DateTime.now()}');

      // Clears the text controllers after recording the diet
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
            decoration: const InputDecoration(labelText: 'Food'),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: quantityController,
            decoration: const InputDecoration(labelText: 'Quantity'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              recordDiet(foodController.text, quantityController.text);
            },
            child: const Text('Record Diet'),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: DietLog(dietLog),
          ),
        ],
      ),
    );
  }
}

class DietCard extends StatefulWidget {
  final String food;
  final String quantity;
  final DateTime datetime;

  DietCard({
    required this.food,
    required this.quantity,
    required this.datetime,
  });

  @override
  _DietCardState createState() => _DietCardState();
}

class _DietCardState extends State<DietCard> {
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
            Text(
              'Food: ${widget.food}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Quantity: ${widget.quantity}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Date and Time: ${widget.datetime.toString()}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
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

        return DietCard(food: food, quantity: quantity, datetime: datetime);
      },
    );
  }
}
