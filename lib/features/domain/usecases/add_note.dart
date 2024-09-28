import 'package:dartz/dartz.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:note_app/core/util/function/set_reminder.dart';

import '../../../core/util/util.dart';
import '../entities/note.dart';
import '../repositories/repositories.dart';

class AddNoteUsecase {
  final NoteRepositories noteRepositories;
  AddNoteUsecase({
    required this.noteRepositories,
  });

  Future<Either<Failure, Unit>> call(Note note) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    if (note.reminders.isNotEmpty) {
      for (final reminder in note.reminders) {
        await setReminder(
          flutterLocalNotificationsPlugin,
          reminder.id,
          reminder.dateTime,
          note.title,
          note.content,
        );
      }
    }
    return await noteRepositories.addNote(note);
  }
}
