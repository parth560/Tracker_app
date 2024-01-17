import 'package:flutter/material.dart';

class EmotionRecorder extends StatefulWidget {
  @override
  _EmotionRecorderState createState() => _EmotionRecorderState();
}

class _EmotionRecorderState extends State<EmotionRecorder> {
  List<Map<String, dynamic>> emotionLog = [];

  Map<String, String> emojiMeanings = {
    '😊': 'Happy',
    '😢': 'Sad',
    '😍': 'In Love',
    '😎': 'Cool',
    '😇': 'Blessed',
  };

  @override
  void initState() {
    super.initState();
    // Add some card format mock data on initialization
    emotionLog.addAll([
      {
        'emoji': '😊',
        'datetime': DateTime.now(),
      },
      {
        'emoji': '😢',
        'datetime': DateTime.now().subtract(const Duration(days: 1)),
      },
    ]);
  }

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

  const _EmotionSelector(this.onEmotionSelected);

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
            onTap: () {
              final emoji = String.fromCharCodes([0x1F600 + index]);
              onEmotionSelected(emoji);
              print('User is Feeling: $emoji'); // Add this line for logging
            },
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
                style: const TextStyle(fontSize: 30),
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

  const EmotionLog(this.emotionLog, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: emotionLog.length,
      itemBuilder: (context, index) {
        final emoji = emotionLog[index]['emoji'];
        final datetime = emotionLog[index]['datetime'];

        return EmotionCard(emoji: emoji, datetime: datetime);
      },
    );
  }
}

class EmotionCard extends StatelessWidget {
  final String emoji;
  final DateTime datetime;

  const EmotionCard({required this.emoji, required this.datetime});

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
              'User is feeling: $emoji',
              style: const TextStyle(fontSize: 16),
            ),
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
