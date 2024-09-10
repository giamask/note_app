import 'package:hive/hive.dart';

import 'state_note_hive.dart';

part 'note_hive.g.dart';

@HiveType(typeId: 0)
class NoteHive extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  @HiveField(3)
  int colorIndex;

  @HiveField(4)
  DateTime modifiedTime;

  @HiveField(5)
  StateNoteHive stateNoteHive;

  @HiveField(6)
  List<String>? imagePaths;

  NoteHive(
      {required this.id,
      required this.title,
      required this.content,
      required this.colorIndex,
      required this.modifiedTime,
      required this.stateNoteHive,
      this.imagePaths = const []});
}
