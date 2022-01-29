import 'package:intl/intl.dart';

class CheckIn {
  String key;
  String message;
  DateTime date;
  String mood;

  CheckIn({
    required this.key,
    required this.message,
    required this.date,
    required this.mood,
  });

  factory CheckIn.fromRTDB(Map<dynamic, dynamic> data, String? key) {
    return CheckIn(
      key: key ?? '',
      mood: data['mood'] ?? '',
      message: data['message'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(data['timestamp']),
    );
  }

  String getFormattedDate() {
    return DateFormat('dd MMM yy').format(date);
  }
}
