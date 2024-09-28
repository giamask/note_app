import 'package:hive/hive.dart';
part 'reminder_hive.g.dart';

@HiveType(typeId: 3)
class ReminderHive extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime dateTime;

  ReminderHive({required this.id, required this.dateTime});
}
