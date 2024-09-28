import 'package:dartz/dartz.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:note_app/core/config/config.dart';
import 'package:note_app/core/util/errors/failure.dart';
import 'package:note_app/core/util/function/set_reminder.dart';

import '../../../core/util/util.dart';
import '../entities/note.dart';
import '../repositories/repositories.dart';

class UpdateNoteUsecase {
  final NoteRepositories noteRepositories;

  UpdateNoteUsecase({
    required this.noteRepositories,
  });

  Future<Either<Failure, Unit>> call(Note note) async {
    final oldNoteZ = await noteRepositories.getNoteById(note.id);

    if (oldNoteZ.isLeft()) {
      return Left(NoDataFailure());
    }

    final oldNote = oldNoteZ.getOrElse(() => Note.empty());
    // Sync reminders with note reminders
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    for (final reminder in oldNote.reminders) {
      if (pendingNotificationRequests.map((x) => x.id).contains(reminder.id)) {
        await flutterLocalNotificationsPlugin.cancel(reminder.id);
      }
    }
    if (note.stateNote != StatusNote.trash) {
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

    return await noteRepositories.updateNote(note);
  }
}
