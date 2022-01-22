import 'package:intl/intl.dart';

class Journal {
  String key;
  String message;
  DateTime date;
  String category;

  Journal({
    required this.key,
    required this.message,
    required this.date,
    required this.category,
  });

  factory Journal.fromRTDB(Map<dynamic, dynamic> data, String? key) {
    return Journal(
      key: key ?? '',
      message: data['message'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(data['timestamp']),
      category: data['category'] ?? '',
    );
  }

  String getFormattedDate() {
    return DateFormat('dd MMM yy').format(date);
  }
}
