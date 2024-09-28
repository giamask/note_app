import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:note_app/features/data/datasources/local/hive/reminder_hive.dart';

class Reminder extends Equatable {
  final DateTime dateTime;
  final int id;

  const Reminder({
    required this.dateTime,
    required this.id,
  });

  ReminderHive get reminderHive => ReminderHive(dateTime: dateTime, id: id);

  String get formattedDateTime =>
      DateFormat('dd MMM yyyy HH:mm').format(dateTime);

  @override
  List<Object> get props => [dateTime, id];
}
